---
layout: single
title: "Use mocks in your acceptance tests"
date: 2020-11-22 12:08:53 +0200
categories: books
comments: true
lang: en
tags: mocks, testing
image: images/
---

Behavouir driven development
-------------------------------


Using gherkin in your acceptance tests
---------------------------------------


Boundaries in your application
-------------------------------
The first step to define what are you going to test is to know the boundaries of your application. Is your application using an external API to retrieve data or to do any kind of operation? your acceptance tests should not depend on external services or systems, these are the boundaries of your application where you call these external systems. 

Mocking your boundaries
-------------------------------
To have deterministic tests that don't fail randomly and that test only your code and not the code from the external systems you should mock those systems in a way that represent the normal behavoir of this external system. I.e: if you are using an api that given a carId returns a Car entity you can create a mock that returns this Car entity. 

Typically what you can do in services that are defined by contracts is to create a particular implementation for the contract that you control and that you know what this implementation is going to return.

```java
public interface CarService {
    Car findCarById(long id); 
}  

public class CarServiceMock implements CarService {

    Car findCarById(long id) {
        return new Car();
    } 
}

```

Boot a server with your mock
------------------------------------



Randomize your inputs 
-------------------------------
If you are always sending the same request to the system that you are doing the acceptance test is possible that you always test the same behavour

Validate your outputs 
-------------------------------


Conclusion
----------------------------
   