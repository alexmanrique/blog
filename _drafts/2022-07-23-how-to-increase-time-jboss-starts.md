---
layout: single
title: "How to increase time JBoss starting time"
date: 2022-07-23 09:08:53 +0200
categories: development
comments: true
lang: en
tags: jboss, queries
image: 
---

In the last project that I had to work we had to figure out a way to deploy an app into <a href="https://cloud.google.com/">Google cloud platform</a> (GCP) that had to connect to an Oracle database that was On premise outside of GCP. 

This make that all the queries to the database increased the time by 3ms for a total of 6ms if we consider the round trip. 

Another thing to consider is that the app loads a lot of data into memory caches to avoid doing queries to the database (as the app has to do a lot of reads and few writes into the database it was a good candidate to use cache) 

Considering the amount of queries done by the app the amount of time needed to boot the app surpassed the maximim 300 seconds defined in the JBoss startup configuration. When we started the app we had the following stacktrace:

```java
{"@timestamp":"2022-06-09T12:40:42.487Z","message":"JBWEB000287: Exception sending context initialized event to listener instance of class com.sun.faces.config.ConfigureListener","thread_name":"ServerService Thread Pool -- 64","level":"ERROR","logger_name":"org.apache.catalina.core.ContainerBase.[jboss.web].[default-host].[/visit-engine]","ndc":"","type":"standard","logname":"server.log","exception":{"class":"java.lang.IllegalArgumentException","message":"JBAS011857: NamingStore is null","stacktrace":"java.lang.IllegalArgumentException: JBAS011857: NamingStore is null\n\tat org.jboss.as.naming.NamingContext.<init>(NamingContext.java:152)\n\tat org.jboss.as.naming.NamingContext.<init>(NamingContext.java:125)\n\tat org.jboss.as.naming.InitialContext$DefaultInitialContext.<init>(InitialContext.java:184)\n\tat org.jboss.as.naming.InitialContext.getDefaultInitCtx(InitialContext.java:117)\n\tat org.jboss.as.naming.InitialContext.getURLOrDefaultInitCtx(InitialContext.java:156)\n\tat javax.naming.InitialContext.lookup(InitialContext.java:417)\n\tat javax.naming.InitialContext.lookup(InitialContext.java:417)\n\tat com.sun.faces.config.WebConfiguration.processJndiEntries(WebConfiguration.java:702)\n\tat com.sun.faces.config.WebConfiguration.<init>(WebConfiguration.java:134)\n\tat com.sun.faces.config.WebConfiguration.getInstance(WebConfiguration.java:194)\n\tat com.sun.faces.config.ConfigureListener.contextInitialized(ConfigureListener.java:158)\n\tat org.apache.catalina.core.StandardContext.contextListenerStart(StandardContext.java:3339)\n\tat org.apache.catalina.core.StandardContext.start(StandardContext.java:3780)\n\tat org.jboss.as.web.deployment.WebDeploymentService.doStart(WebDeploymentService.java:163)\n\tat org.jboss.as.web.deployment.WebDeploymentService.access$000(WebDeploymentService.java:61)\n\tat org.jboss.as.web.deployment.WebDeploymentService$1.run(WebDeploymentService.java:96)\n\tat java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n\tat java.util.concurrent.FutureTask.run(FutureTask.java:266)\n\tat java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n\tat java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n\tat java.lang.Thread.run(Thread.java:748)\n\tat org.jboss.threads.JBossThread.run(JBossThread.java:122)\n"}}
```
An option could have been reduce the number of queries that were accessing to the database but to do that we needed to use joins and other optimizations that would have been risky and we wanted to find a good solution for this temporary problem. 

Taking into consideration that at some moment the Oracle database will be in cloud at some moment this extra time of 3ms will disappear in a near future.  

Then finally we decided to fix the issue we changed the `commands.cli` file and we added the following lines:

```java
connect localhost:12345
batch
/system-property=jboss.as.management.blocking.timeout:add(value=600)
run-batch
```

References
-------------
Configuring jboss.as.management.blocking.timeout in JBoss EAP 6/7 : <a href="https://access.redhat.com/solutions/1190323">https://access.redhat.com/solutions/1190323</a>

How to increase default timeout of 300 seconds : <a href="https://developer.jboss.org/thread/250218">"https://developer.jboss.org/thread/250218"</a>

JBoss enterprise application app documentation <a href="https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.0/html/getting_started_guide/index"> https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.0/html/getting_started_guide/index
</a>

Conclusion
------------
In this post we have seen how to increase the blocking timeout of JBoss from 300 seconds that is the default one to 600 seconds. We needed to do this as a workaround for a temporary situation.


