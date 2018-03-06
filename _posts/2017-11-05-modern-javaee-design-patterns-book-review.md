---
title:  "Modern Java EE Design Patterns book review"
date:   2017-11-05 14:13:53 +0200
categories: development
comments: true
lang: en
ref: design
tags: java book microservices
---

My kindle paperwhite says in the beginning of the book that the time to read this book is 2 hours and 55 minutes. Time spent reading was worth it. 

About the author
-------------------

The book that I'm going to make a review is called <a href="http://www.oreilly.com/programming/free/modern-java-ee-design-patterns.csp">Modern Java EE Design Patterns</a> writen by <a href="http://blog.eisele.net/">Markus Eisele</a> a Java Champion, former Java EE Expert Group member, Java community leader of German DOAG and a very well known figure in the Enterprise Java world.  

This book is about ...
----------------------- 

The book talks about building scalable architecture for sustainable enterprise development. The main emphasis is on understanding Java Enterprise edition (<a href="http://www.oracle.com/technetwork/java/javaee/overview/index.html">Java EE</a>) design patterns, as well as how to work with new development paradigms, such as microservices, <a href="https://en.wikipedia.org/wiki/DevOps">DevOps</a> and cloud based operations. Shows how to migrate existing <a href="https://en.wikipedia.org/wiki/Monolithic_application">monoliths</a> into more fine-grained and service oriented systems by respecting the enterprise environment.

Towards a new architecture
----------------------------------

In the beginning it talks about the difficulties that have large organizations that need a much higuer level of standarization than startups or small companies and how Java EE has become an standard platform across a great number of enterprises to build complex applications that are stable in the long term. 

Says that traditional enterprises have become business-centric and treat IT and operations as cost centers but the good news is that many organizations have started to take notice and are undertaking changes towards easier and more efficient architecture management that scales up.


From monoliths to microservices
-----------------------------------

Talks about how the typical enterprise Java application has evolved from a monolith to use microservices architecture approach in part because the changes in the software are nowadays more frequent in a world of <a href="http://agilemanifesto.org/">agile methodlogies</a> that promote iterative and incremental changes, that test hypothesis rather than analysing if something wil be sucessful or not, during long periods of time before trying it.

Today's most relevant architectures rely on <a href="https://en.wikipedia.org/wiki/Operating-system-level_virtualization">containers</a> to define the software stack to run and provide enough flexibility to projects while maintaining manageability alongside cost-effective operations. Cloud infrastructures help to pay what you use with rapid provisioning. 

Microservices are not always the best choice
------------------------------------

However, microservices is not always the best approach. It should not be considered unless you have a system that's too large and complex to be built as a classical monolith. The majority of modern software systems should still be built as a single application that is modular and takes advanage of state-of-the-art software architecture patterns. 
<a href="https://twitter.com/martinfowler">Martin Fowler</a> explains in this <a href="https://martinfowler.com/bliki/MicroservicePremium.html">post</a> that in small applications can be counterproductive.


Microservices Best practices 
---------------------

What I found more interesting was the Microservices Best practices section, that those are like microservices commandments that you should follow in this kind of architecture:

- Design for automation (<a href="https://continuousdelivery.com/">Continuous delivery</a> (CD))
- <a href="https://medium.com/netflix-techblog/fault-tolerance-in-a-high-volume-distributed-system-91ab4faae74a">Design for failure</a> (Service <a href="https://en.wikipedia.org/wiki/Load_balancing_(computing)">load balancing</a> and automatic scaling, Retry on failure, <a href="https://martinfowler.com/bliki/CircuitBreaker.html">Circuit breaker</a>, Bulkheads, Timeouts)
- Design for data separation (Separate datastores) 
- Design for integrity (One service related exactly to one transaction, use transactions, separate reads from writes, event-driven design, use transaction IDs)
- Design for performance (Load test early, load-test often, use the right technology for the job, use API gateways and load balancers, use caches at the right layer)
- Independently deployable and Fully contained
- Crosscutting concerns (<a href="https://en.wikipedia.org/wiki/Aspect-oriented_programming">Aspect oriented programming</a> (AOP), <a href="https://en.wikipedia.org/wiki/Dependency_injection">Dependency injection</a> (DI))
- Security
- Logging (<a href="https://www.elastic.co/products/kibana">Kibana</a>, <a href="https://www.elastic.co/products/elasticsearch">Elasticsearch</a>, <a href="https://www.elastic.co/products/logstash">Logstash</a>)
- Health checks
- Integration testing (<a href="http://arquillian.org/">Arquilian</a>) 

Bonus: A really good <a href="https://martinfowler.com/articles/microservices.html">article</a> about Microservices by Martin Fowler that can help understand all those principles.

Conclusion
---------------------------
This is a really good book to learn about how new architectures can help deliver software faster and scale in a world of continuous changes that we live in. Those changes are accelerating and we need a new way to evolve those systems that are used for milions of users which need to be available 24 hours per day 7 days a week.   



