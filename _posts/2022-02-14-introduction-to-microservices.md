---
layout: single
title: "Introduction to microservices"
date: 2022-02-06 09:08:53 +0200
categories: development
comments: true
lang: en
tags: microservices
image: images/microservices.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/microservices.jpg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@jjying?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">JJ Ying</a> on <a href="https://unsplash.com/s/photos/tech?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef} 

In this post, we are going to talk about which are the things that we have to consider when working with a microservices architecture. Microservices have advantages but they have also challenges and difficulties to overcome.

Monolithic repositories
----------------------------------- 
Let's start by mentioning what microservices are not. If you have a Java application and everybody is contributing to its codebase and it is released once a week then you don't have a microservice, you have a monolith. 

When a change is introduced is difficult to find where is the problem and finding the problems are a complicated task because a lot of people are introducing changes at the same time and you don't know where the problem comes from.

Monolithic databases 
-------------------------
The database can be also monolithic, one piece of hardware running an oracle database, when this goes down everything goes down. In this scenario, the only way to scale it's vertically adding more hardware.

An old way of developing software
------------------------------
Lack of agility it's also a problem because everything is deeply interconnected. Direct calls to the database are being done, applications referencing table schemas and adding a column can become a cross-functional project. This way of doing projects was typical from the early 2000's.

A formal definition of a microservice
----------------------------
We have the following definition by Martin Fowler:

> the microservice architectural style is an approach to developing a single application as a suite of small 
> services, each running in its process and communicating with lightweight mechanisms, often an HTTP 
> resource API

This definition might be technically correct but it doesn't give us enough about the flavor of what it means to build a microservice.

An easier definition of a microservice
------------------------------------------
We can see the microservices approach as an evolutionary response to the monolithic applications that we had in the late 90's early 2000's. 

> Separation of concerns is one of the critical things that this paradigm encourages. 

Modularity and encapsulation are also important in this kind of architectures. We say that software is modular when it's decomposed into smaller parts using standardized interfaces. Encapsulation is a property that software has when it hides direct access to the data providing methods.  

In terms of scalability, we need horizontal scaling to increase the number of instances in case of high traffic peaks. Workload partitioning as we are working with distributed systems we can break our work in a way that different instances do the work in parallel. 

Microservices need virtualization and elasticity
-----------------------------------------------------
All these things don't work if you are not in an environment where on-demand provisioning can be used and we need for this virtualization & elasticity. 

Virtualization is the act of creating a virtual (rather than actual) version of something, including virtual computer hardware platforms, storage devices, and computer network resources. 

Elasticity is the degree to which a system is able to adapt to workload changes by provisioning and de-provisioning resources in an autonomic manner, such that at each point in time the available resources match the current demand as closely as possible

> we can think about microservices as organs in an organ system, similar to the human body. The systems come together to form the entire organism.

Problems when dealing with microservices
------------------------------------------
When dealing with microservices we have `intra-services` requests and here is where problems can happen like network latency or congestion.

<a href="https://en.wikipedia.org/wiki/Cascading_failure">Cascading failure</a> can happen when one service fails with improper defenses and the clients of this service all fail.
<a href="https://github.com/Netflix/Hystrix">Hystrix</a> is a Netflix OSS library has mechanisms to solve this kind of problems. 

Defining critical microservices 
---------------------------------------------------
How can we test when we have a lot of services avoiding the combinatorial explosion of testing all microservices between them?

We have to define which are the critical microservices: which are the ones that are most important and test those only. 

In the following <a href="https://eng.uber.com/crisp-critical-path-analysis-for-microservice-architectures/"> 
link </a> we have a blog post from Uber that explains a tool that they developed to find the critical path of a microservices architecture.

CAP theorem
-------------------------------
The CAP theorem states that any distributed data store can only provide two of the following three guarantees:

- Consistency: Every read receives the most recent write or an error.
- Availability: Every request receives a (non-error) response, without the guarantee that it contains the most recent write.
- Partition tolerance: The system continues to operate despite an arbitrary number of messages being dropped (or delayed) by the network between nodes.

> In the presence of network partition, we must choose between consistency and availability.

We need client libraries 
------------------------------------------
Microservices are an abstraction and they are not as simple as we might think. At some point, you might need data that is stored in a persistence layer. 

We need to provide Java client libraries to access the data, and we need to add caches to avoid unnecessary calls to the database. 

A microservice is the collaboration between the service, the client code, the cache, and the database that has the data that is accessed. 

But client libraries can be a trap
--------------------------------
Client libraries are interesting to develop in case we have common logic and common access patterns. Client libraries can have bugs, memory leaks, transitive dependencies, or other problems that can be impacting the application that is using this client library.

The idea is to simplify these libraries as much as possible. Client libraries can be a parasitic infestation. It's important to limit the logic and heap consumption of these clients libraries.

Auto-scaling and chaos in microservices
-----------------------------------------
Autoscaling is super important for microservices. With this strategy nodes can be replaced easily.
Simulate that you make the service fail. With tools like <a href ="https://netflix.github.io/chaosmonkey/">Chaos monkey</a> we can make one node fail and our service should survive to that failure. 

The same principle applies for regions. If one region fails our service should survive. To achieve this we have to use multiregion to not be attached to a single region. If one region fails we can redirect traffic to another region.

Stateless or stateful microservices
----------------------------------
We have stateless microservices that are the ones that don't have a cache neither a database, and are frequently accessed metadata. 

On the other hand we have stateful services Databases & caches custom apps that hold large amounts of data. Loss of node is a notable event

Dedicated shards are a single point of failure
------------------------------------------------
Dedicated shards is an antipattern because they are a single point of failure. If all the requests from one region go to a particular shard, then if this shard goes down all the traffic of this region will be affected.

Variance in microservices
-----------------------------------
Operational drift happens in a microservices environment. It's unintentional. The need to share code between microservices using platform libraries and the consequent maintenance that comes with them has a cost.

It can be a configuration drift due to a myriad of properties files or configuration sources; dependency hell due to library version drift; or delivery drift caused by feature parity between projects and the pipelines required to deliver them.

Conway's law
--------------
Organizations that design systems are constrained to produce designs that are copies of the communication structures of these organizations.

Any piece of software reflects the organizational structure that produced it. If you have four teams working on a compiler you will end up with a four pass compiler. More info about this law can be found <a href="https://en.wikipedia.org/wiki/Conway%27s_law">here</a>

### Conclusion
In this post we have seen an introduction to different concepts related to microservices that are important to know if we are working with this kind of architecture.



