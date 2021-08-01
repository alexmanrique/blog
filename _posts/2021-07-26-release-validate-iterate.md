---
layout: single
title: "Release, evaluate and iterate"
date: 2021-07-26 09:08:53 +0200
categories: development
comments: true
lang: en
tags: release
image: images/release.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/release.jpg)
{: refdef}

{:refdef: style="text-align: center; font-size:9px"}
Photo by <a href="https://unsplash.com/@an_ku_sh?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Ankush Minda</a> on <a href="https://unsplash.com/s/photos/release?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{:refdef}
  
Some time ago I was working in a team where we had developed an application that had some complicated logic and unfortunately, the integration tests were not developed. In another post, we talked about test-driven development <a href="{{ site.baseurl }}{% post_url 2020-07-19-test-driven-development %}">approach</a> something that I definitely recommend.

An application that didn't scale
----------------------------------
The application didn't scale because with more traffic the main process was queuing more and more data and the time to deliver information to an external system was not acceptable. 

The time to process the data was near 1 hour and the data should arrive at the external system within 30 minutes.

Trying to improve the application
-----------------------------------
What we did at that moment was trying to improve the main process that was accessing the <a href="https://en.wikipedia.org/wiki/Database">database</a> for each element that was retrieved from the first <a href="https://www.educative.io/blog/what-is-database-query-sql-nosql">query</a>. 

> Minimize the number of times that you go to the database to retrieve data. 

Instead of that, we tried to <a href="https://www.w3schools.com/sql/sql_join.asp">join</a> the data from the first table with the data from the second table to avoid doing a query to the database for each of the resulting elements from the first query.

Then one member of the team suggested also doing a refactor adding <a href="https://projectlombok.org/">Lombok</a> in the application and simplifying some logic here and there to reduce the number of lines of code.

1st release
---------------
When we did the release the main key performance indicators (KPI) of the application drop by 30% and we had our business stakeholders chasing us asking if we had a problem with the application and the data that we were sending to the external system (see the purple line)

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/drop.png)
{: refdef}

> You need to have integration tests before refactoring your application to be sure that you are not removing any functionality

2nd release
---------------
The action that we decided was to do another release with a fix that we thought was the culprit of the 30% drop. The result was that the KPI reduced the drop to 20% but didn't recover fully from the previous state. 

We had a new invitation from our beloved business partners requesting us a clarification. In that meeting, we asked when was the moment that they saw in the KPI's that the application was working at full capacity and that the KPIs were ok.

They told us the specific date and from that date, we inferred which release version was working fine. The release number was just before the release that we did with the improvement of the query using the join and the Lombok refactor.  

3rd release
----------------
We reverted the code to the version that business told us that was working fine. We deploy it to production and after 2 days we had the confirmation that the KPIs came back to normal recovering from the 30% drop. 

4th release
----------------
At this point that we had recovered from the drop, we analyzed using metrics, which part of the process was consuming more time and we find out that we had a bigger problem than the queries done to the database. (See a previous post where I talk about how to  <a href="{{ site.baseurl }}{% post_url 2018-01-15-metrics-in-your-java-application %}">metricate</a> your Java application) 

> Use metrics to see which are the points of your application where you spend more time.

Each time that we were sending data to the external system we were waiting for a response from the server that we were not using, that was creating a bottleneck because we were slowing down the sending of newer elements and we were adding delays in all the sendings progressively. 

Sending data without blocking
-------------------------------
The point here was that we could send the data asynchronously without waiting for a response from the server. That would increase the throughput and that was what we did exactly. We used `CompletableFuture` to send data asynchronously to the external system.  

```java
private void sendEventAsyncronously(List<Event> events) {
    CompletableFuture.runAsync(() -> eventsDispatcher.sendEventAsyncronously(events), executorService)
        .exceptionally((e) -> {
        metricsController.errorExecutingRobot(e.getCause().getClass().getSimpleName());
        log.error("There was a problem sending events ", e);
        return null;
    });
}
```

Impact of the changes
-------------------------------
The result was that we started sending more events to the external system (see purple line).  
{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/recovery.png)
{: refdef}


And that lead to a 40% increase in orders after the 4th release. 
{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/releases.png)
{: refdef}

## Conclusion
In this post, we have seen different learnings: 
- It's quite important to have integration tests that protect the functionality of your application in a way that you can do refactors without compromising anything. 
- Secondly, we have seen that is a bad practice to release different things at the same time.
- Third, we have seen the importance of using metrics to find out the points of your application that can be improved.
- Fourth we have seen that we can send data to another system asynchronously without blocking the application and let it work in other tasks.  

