---
layout: single
title: "How to increase time jboss starting time"
date: 2022-07-23 09:08:53 +0200
categories: development
comments: true
lang: en
tags: jboss, queries
image: 
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/)
{: refdef}

The last project that I had to work we had to figure out a way to deploy an app into Google cloud platform that had to connect to a database that was on-premise outside of Google cloud platform. This make that all the queries to the database increased the time by 3ms. 

Another things to consider is that this app load a lot of data into memory caches to avoid doing queries to the database. As the app has to do a lot of reads and few writes into the database it was a good candidate to use cache.  Considering the amount of queries done by the app the amount of time needed to boot the app surpassed the maximim 300 seconds defined in the JBoss configuration. 

When we started the app we had the following stacktrace:

```java
{"@timestamp":"2022-06-09T12:40:42.487Z","message":"JBWEB000287: Exception sending context initialized event to listener instance of class com.sun.faces.config.ConfigureListener","thread_name":"ServerService Thread Pool -- 64","level":"ERROR","logger_name":"org.apache.catalina.core.ContainerBase.[jboss.web].[default-host].[/visit-engine]","ndc":"","type":"standard","logname":"server.log","exception":{"class":"java.lang.IllegalArgumentException","message":"JBAS011857: NamingStore is null","stacktrace":"java.lang.IllegalArgumentException: JBAS011857: NamingStore is null\n\tat org.jboss.as.naming.NamingContext.<init>(NamingContext.java:152)\n\tat org.jboss.as.naming.NamingContext.<init>(NamingContext.java:125)\n\tat org.jboss.as.naming.InitialContext$DefaultInitialContext.<init>(InitialContext.java:184)\n\tat org.jboss.as.naming.InitialContext.getDefaultInitCtx(InitialContext.java:117)\n\tat org.jboss.as.naming.InitialContext.getURLOrDefaultInitCtx(InitialContext.java:156)\n\tat javax.naming.InitialContext.lookup(InitialContext.java:417)\n\tat javax.naming.InitialContext.lookup(InitialContext.java:417)\n\tat com.sun.faces.config.WebConfiguration.processJndiEntries(WebConfiguration.java:702)\n\tat com.sun.faces.config.WebConfiguration.<init>(WebConfiguration.java:134)\n\tat com.sun.faces.config.WebConfiguration.getInstance(WebConfiguration.java:194)\n\tat com.sun.faces.config.ConfigureListener.contextInitialized(ConfigureListener.java:158)\n\tat org.apache.catalina.core.StandardContext.contextListenerStart(StandardContext.java:3339)\n\tat org.apache.catalina.core.StandardContext.start(StandardContext.java:3780)\n\tat org.jboss.as.web.deployment.WebDeploymentService.doStart(WebDeploymentService.java:163)\n\tat org.jboss.as.web.deployment.WebDeploymentService.access$000(WebDeploymentService.java:61)\n\tat org.jboss.as.web.deployment.WebDeploymentService$1.run(WebDeploymentService.java:96)\n\tat java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n\tat java.util.concurrent.FutureTask.run(FutureTask.java:266)\n\tat java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n\tat java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n\tat java.lang.Thread.run(Thread.java:748)\n\tat org.jboss.threads.JBossThread.run(JBossThread.java:122)\n"}}
```

Then to fix the issue we changed the commands.cli file and we added the following lines.

```java
connect localhost:12345
batch
/system-property=jboss.as.management.blocking.timeout:add(value=600)
run-batch
```

References

Configuring jboss.as.management.blocking.timeout in JBoss EAP 6/7 : https://access.redhat.com/solutions/1190323

How to increase default timeout of 300 seconds : https://developer.jboss.org/thread/250218


Conclusion
------------


