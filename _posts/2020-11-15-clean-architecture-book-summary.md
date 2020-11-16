---
layout: single
title: "Clean architecute book summary"
date: 2020-11-15 21:08:53 +0200
categories: books
comments: true
lang: en
tags: architecture, clean, design
image: images/clean-architecture.png
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/clean-architecture.png)
{: refdef}

High-level thoughts
-----------------------------
This is a good book by <a href="https://twitter.com/unclebobmartin">uncle Bob</a>. In this publication, he explains how to achieve clean architecture and he mixes some stories from his experience to explain some concepts that help the reader understanding the philosophy behind them. Also, there are figures with drawings to explain the concepts. 

I recommend this <a href="https://www.amazon.es/s?k=clean+architecture&__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=FSWH05AEJOUX&sprefix=clean+archite%2Caps%2C179&ref=nb_sb_ss_ts-a-p_1_13">book</a> to all the people that are interested in having a higher level picture of how to organize modules and applications in a way that is sustainable for the future, to maximize the productivity of developers and people working with software.    

Summary Notes
------------------------------
- Chapter 1 - What is design and architecture?
    - Organizations need to start taking the quality of its software architecture seriously.
    - We need to build systems that minimize effort and maximize productivity.
    - Software developers should be able to build systems that have long profitable lifetimes.
- Chapter 2 - A tale of two values
    - Fight for the architecture: If architecture comes last, then the system will become ever more costly to develop, and eventually change will become practically impossible for part or all of the system. If that is allowed it means the software development team did not fight hard enough for what they knew was necessary.
- Chapter 3 - Paradigm overview
    - The 3 followning paradigms align with the three big concerns of architecture: function, separation of concerns and data management
        - Structured programming
        - Object oriented programming
        - Functional programming
- Chapter 4 - Structured programming
    - The value is to be able to create falsifiable units of programming. Modern languages don't support unrestrained goto statements. At every level software is a science, that is driven by falsifiability.
- Chapter 5 - Object oriented programming
    - Encapsulation
    - Inheritance
    - Polimorphism
    - Dependency inversion
- Chapter 6 - Functional programming
    - Inmutability it's super important to avoid race conditions
    - It's our job to avoid creating a mess even if we have deadlines.
- Chapter 7 - SRP priniciple
    - A module should have one, and only one, single reason to change.
    - A software module has to have only one actor(stakeholder) that wants to do changes.
    - Symptoms of not applying this principle:
        - Accidental duplication
        - Merges
- Chapter 8 - The Open-closed principle
    - A software artifact should be open for extension but closed for modification
    - The goal is to make the system easy to extend without incurring a high impact of change
- Chapter 9 - LSP : The Liskov substitution principle
    - Substitutability regarding implementations. We have to be able to replace a particular implementation for another one without impacting in the users.
- Chapter 10 - The interface segregation principle
    - You should not depend on things that you don't need
- Chapter 11 - Dependency inversion principle
    - Instead of depending on some concrete implementation it's better to depend on interfaces that can be implemented by different classes and this way we are not coupled with any particular one. Higher level modules should not depend on lower level both should depend on abstractions.
- Chapter 12 - Components
    - Jars, dll's are componenents which can be plugged together at runtime, are the software components of our architectures.
- Chapter 13 - Component cohesion
    - REP : Reuse equivalent principle → The granule of reuse is the granule of release.
    - CCP: The common closure principle → Separate into diferent components classes that change at different times for different reasons.
    - CRP: Common reuse principle → Don't force users of a component to depend on things they don't need. Generalizing the idea it would be don't depend on things you don't need.
- Chapter 14 - Component coupling
    - Allow no cycles in the component dependency graph (apply depndency inversion principle)
    - Depend in the direction of stability (component that a lot of components depend on)
    - A component should be as abstract as it is stable.
- Chapter 15 - Architecture
    - The strategy behind the architect facilitation is to leave as many options open as possible, for as long as possible.
    - Good archtecture makes the system easy to understand, easy to develop, easy to mantain, and easy to deploy. The ultimate goal is to minimize the lifetime cost of the system and to maximize programmer productivity.
    - A good architect maximizes the number of decisions not made
    - Examples : Device independence, junk mail and physical addressing
- Chapter 16 - Independence
    - The architecture must support
        - use cases and they should be visible within the structure of that system.
        - operations
        - development
        - deployment
        - decoupling layers
    - The decoupling mode of a system is one of those things that is likely to change with time.
- Chapter 17 - Boundaries drawing the line
    - Architects should not make premature decisions to avoid multiplying the development efforts. I.e: Using mysql or not in a system is a decision that can be delayed or using a SOA architecture in the beginning of a project.
    - We draw the line between between the interface and the interface implementation.
    - The arrows point toward the core business.
    - Dependency arrows are arranged to point from low-level details to higuer level abstractions.
- Chapter 18 - Boundary anatomy
    - Boundaries in a system are oftenly a mixture of local chatty boundaries and boundaries that are more concerned with latency.
- Chapter 19 - Policy and level
    - A computer program is a detailed description of the policy by which inputs are transformed into outputs.
    - Low level components are designed so that they depend on high level components.
    - We have to decouple the high level policies from the low level policies. Low-level components should be plugins to the higuer-level components.
- Chapter 20 - Business rules
    - Business rules are the core functionality of the systems. They carry code that saves or makes money
    - They should be the most independent and reusable code in the system.
- Chapter 21 - Screaming architecture
    - Your architecture should tell readers about the system and not about the frameworks you used in your system.
- Chapter 22 - Clean architecture
    - Architectures should be:
        - Independent of frameworks
        - Testable
        - Independent of the UI
        - Independent of the database
        - Independent of any external agency
    - Source code dependencies must point only inward, toward higuer level policies.
- Chapter 23 - Presenters and humble objects
    - The humble object pattern: way to help unit testers to separate behavoirs that are hard to test from behavoirs that are easy to test.
    - Boundaries will almost always divide something that is hard to test from something that is easy to test. The usage of this pattern increases the testability of the entire system.
- Chapter 24 - Implement partial boundaries
    - Skip the last step: Create independently compilable and deployable components, and simply keep them together in the same component. Compile and deploy all of them as a simple component.
    - One-dimensional boundaries: Use a ServiceBoundary interface that separates the client from the Service Impl. This sets the stage for a future architectural boundary.
    - Facades: In this strategy the dependency inversion has been sacrificed. The Facade lists all the services as methods and deploys the service calls that the client is not supposed to access. Client in this case has a transitive dependency with on all those service classes.
- Chapter 25 - Layers and boundaries
    - The goal is to implement the boundaries right at the inflection point where the cost of implementing becomes less than the cost of ignoring.
- Chapter 26 - Main component
    - Is the entry point of the system.
    - Think of main as a plugin to the application. A plugin that sets up the initial conditions and configurations, gathers all the outside resources and hands control over to the high-level policy of the application. When you think about it as a plugin component, the problem of configuration becomes a lot of easier to solve.
- Chapter 27 - Great and small
    - The architecture of the system is defined by the boundaries drawn within that system, and by the dependencies that cross those boundaries.
- Chapter 28 - The test boundary
    - Tests are not outside the system, they are parts of the system that must be well designed if they are to provide the desired benefits of stability and regression.
    - Tests that are not designed as part of the system tend to be fragile and difficult to mantain.
- Chapter 29 - Clean embedded architecture
    - Letting all code become firmware is not good for your product's long term health. Being  able to test only in the target hardware is not good for your product long term health.
- Chapter 30 - The database is a detail
    - The data model, is architecturally significant. The technologies that move the data on and off a rotating magnetic surface are not. The data is significant. The database is a detail.
- Chapter 31 - The web is a detail.
    - The WEB is an IO device. In the 1960's, we learned the value of writing applications that were device independent. The motivation for this device independence has not changed. The web is not an exception to this rule.
- Chapter 32 - Frameworks are details
    - When faced with a framework, try not to marry right away. Keep the framework behind an architectural boundary if at all possible, for as long as possible. Perhaps you can find a way to "get the milk without buying the cow".
    - Spring is a good dependency injection framework, however, you should not sprinkle the autowired annotation all throughout your business objects. Your business objects should not know about Spring.
- Chapter 33 - Case study : Video sales
    - Example where the principles of the previous chapters are used.
- Chapter 34 - The missing chapter
    - Design intentions can be destroyed if you don't consider the implementation strategy. The devil is in the implementation details

Conclusion
----------------------------
A really good book that anyone interested in software quality should read to become a better professional when we have to face more high-level decisions regarding the architecture of a software system.   