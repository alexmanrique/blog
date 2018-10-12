---
layout: single
title:  "Improving performance of JPA queries"
date:   2018-09-23 00:13:53 +0200
categories: development
comments: true
lang: es
tags: development
---

Why to use JPA?
-------------------------
JPA stands for Java persistence and describes the management of relational data in applications using the Java platform.

One important concept of JPA is the concept of persistence entity. An entity It's a lightweight java class whose state is typically persisted to a table in a relational database. Instances of such entity are rows in a table.

JPA is a java standard defined in the java community process which is a formalized mechanism that allows interested parties to develop standard technical specifications for Java technology.

Using something standard is a good practice when using technology and using JPA is not an exception.

The task
-------------------------
One of the last development tasks that I had to do has been to reduce the time that an API rest operation spend when calling it.

To test the API I was using <a href="https://www.getpostman.com/">Postman</a> application because it has a lot of features available to test web API's.

The application was written in Java 8 using <a href="https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/6.4/html/6.4.0_release_notes/index">JBoss 6.4 GA</a> and the persistence of the application was managed by JPA and hibernate. The database management system was <a href="https://en.wikipedia.org/wiki/Oracle_Database">Oracle 11g</a>.

Bad performance in the API
--------------------------
The operation getAllEntities() returned a JSON with all the entities and it was spending 120 seconds to retrieve 95 entities from the database.

One of this entities had in another database table 2000 rows that were related to that entity. A part from that, the main entity was using different tables that were related, having a star database typical schema <a href="https://en.wikipedia.org/wiki/Star_schema">https://en.wikipedia.org/wiki/Star_schema</a>

![Star schema]({{ site.baseurl }}/images/Star-schema-example.jpg)

Printing logs
-------------------------
The first thing that I did was to activate in the <a href="https://docs.oracle.com/cd/E16439_01/doc.1013/e13981/undejdev003.htm#CHDIDBBF">persistence.xml</a> the following properties:  

```
<property name="hibernate.show_sql" value="true"/>
<property name="hibernate.generate_statistics" value="true" />
<property name="hibernate.format_sql" value="true"/>
<property name="hibernate.use_sql_comments" value="true"/>
```

and in the log4j.properties I added also the following lines:

```
# basic log level for all messages
log4j.logger.org.hibernate=info

# SQL statements and parameters
log4j.logger.org.hibernate.SQL=debug
log4j.logger.org.hibernate.type.descriptor.sql=trace
log4j.logger.org.hibernate.stat=debug
```

This way I was able to show sql in the logs, generate statistics, format the sql and having sql comments to understand better which queries where being executed.

Checking statistics
---------------------------

The surprise was that a lot of queries to the database were executed:  

```
2018-09-19 11:17:56,656 INFO  [http-0.0.0.0:8080-1: : ] [StatisticalLoggingSessionEventListener] - Session Metrics {
    306789321 nanoseconds spent acquiring 35595 JDBC connections;
    137441803 nanoseconds spent releasing 35595 JDBC connections;
    776012325 nanoseconds spent preparing 35595 JDBC statements;
    44350389007 nanoseconds spent executing 35595 JDBC statements;
    0 nanoseconds spent executing 0 JDBC batches;
    58259175 nanoseconds spent performing 4646 L2C puts;
    0 nanoseconds spent performing 0 L2C hits;
    176674 nanoseconds spent performing 1 L2C misses;
    47106855 nanoseconds spent executing 1 flushes (flushing a total of 4645 entities and 35594 collections);
    5540 nanoseconds spent executing 1 partial-flushes (flushing a total of 0 entities and 0 collections)
}
```

35595 JDBC connections were done to the database. If this API has to be used by a high number of users this is not acceptable. 

I realize that there was a problem of n+1 select query issue problem in <a href="https://en.wikipedia.org/wiki/Object-relational_mapping">ORM</a> <a href="https://stackoverflow.com/questions/97197/what-is-the-n1-select-query-issue">https://stackoverflow.com/questions/97197/what-is-the-n1-select-query-issue</a>

Using FetchType.Eager
-----------------------

Then I tried to set anotation `FetchType.EAGER` that according to the book <a href="https://www.manning.com/books/java-persistence-with-hibernate">Java Persistence with Hibernate 2007</a>, it was one of the ways to fix this problem because it forces to make joins with the related entities instead of doing a query for each table related with the first entity.

{% highlight java %}
@Embeddable
public class CampaignConditionsEntity implements Serializable {

@ElementCollection(fetch = FetchType.EAGER)
@CollectionTable(name = "CAMPAIGN_COND_TRIP_TYPE", joinColumns = @JoinColumn(name = CAMPAIGN_ID))
private Set<TripTypeConditionEntity> tripTypeConditions;
{% endhighlight %}

The problem was that the related tables with the main entity were using `@ElementCollection` and the number of queries after executing this change was the same as before.

Using Join fetch
------------------------
We tried then with a <a href="https://es.wikipedia.org/wiki/Java_Persistence_Query_Language">JPQL</a> query that did `JOIN FETCH` because according to specification it says the following:

In the JPA 2.2 specification (<a href="http://download.oracle.com/otn-pub/jcp/persistence-2_2-mrel-spec/JavaPersistence.pdf?AuthParam=1537804209_8090f5eb50f5ef167e6551d97e04fa27">JSR 338</a>):

```
A FETCH JOIN enables the fetching of an association or element collection as a side effect of the execution of a query.
```

The first attempt of this optimization was with `JOIN fetch`. It returned no results because there were some relationships that have no related rows and because of that we had to use LEFT joins instead of that.

The results were the ones expected for a single operation: 1 JDBC connection. However, time to retrieve the data for this query was still 8 seconds:

```

2018-09-19 11:36:17,733 INFO  [http-0.0.0.0:8080-1: : ] [StatisticalLoggingSessionEventListener] - Session Metrics {
    366522 nanoseconds spent acquiring 1 JDBC connections;
    7645 nanoseconds spent releasing 1 JDBC connections;
    538334 nanoseconds spent preparing 1 JDBC statements;
    674436612 nanoseconds spent executing 1 JDBC statements;
    0 nanoseconds spent executing 0 JDBC batches;
    108560425 nanoseconds spent performing 4664 L2C puts;
    0 nanoseconds spent performing 0 L2C hits;
    0 nanoseconds spent performing 0 L2C misses;
    47723651 nanoseconds spent executing 1 flushes (flushing a total of 4664 entities and 35879 collections);
    5627 nanoseconds spent executing 1 partial-flushes (flushing a total of 0 entities and 0 collections)
}
```

Next calls to the operation spend 2.8 seconds approximately. We wonder if JPA/hibernate Level 1 cache was caching some way our database query, but what we did was to get the raw query and execute it directly in the oracle sql developer. The first execution was slow and next ones were faster.

Reviewing the query plan
-------------------------
I thought that this query could be improved and we check the query plan in the sql developer.

![Query plan]({{ site.baseurl }}/images/query_plan.jpg)

We found that there was an order by that was adding a cost that we could reduce. We had to delete `@OrderBy` annotation in one of the entities that was increasing the query time. This helped to reduce the time of the query to 2.8 seconds in the first execution.

Conclusion
--------------------------

Using a left join was a good option to decrease the time that the API operation spent in time, because JPA was doing a lot of queries to the database and it increased a lot the time to get the data requested in the API operation. 
In the following charts you can see a summary with a chart with times and the reduction of time for each optimization. In this case was a good option but it depends on the database design.
 I recommend the book <a href="https://www.amazon.com/Java-Persistence-Hibernate-Revised-Action/dp/1932394885/"> Java Persistence Hibernate in action </a> where it explains in more detail how to optimize your queries.

![Table times]({{ site.baseurl }}/images/times_table.png)

![chart times]({{ site.baseurl }}/images/times_chart.png)




