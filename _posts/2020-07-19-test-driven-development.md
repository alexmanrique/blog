---
layout: single
title: "Test driven development"
date: 2020-07-19 13:20:53 +0200
categories: development
comments: true
lang: en
tags: test, unit-test, quality 
---

![test driven development]({{ site.baseurl }}/images/tdd.jpg)

In this post we are going to talk about test driven development and how it can help you improve the quality of your code. A lot of times we have hearth this concept. Let's learn more about it. 

Practices that support change
-------------------------------------
We need to encourage practices that support change and TDD is one of those practices. Frequent manual testing is impractical. We must automate testing as much as we can to reduce the costs of building, deploying and modifying versions of the system.

We have to keep the code as simple as possible, so it’s easy to understand and modify for the developers that will come in the future. Developers spend far more time reading code that writing

> “Indeed, the ratio of time spent reading versus writing is well over 10 to 1. We are constantly reading old code as part of the effort to write new code. ...[Therefore,] making it easy to read makes it easier to write.”(Robert C. Martin, Clean Code: A Handbook of Agile Software Craftsmanship) 

so we need to optimize for readability. Simplicity takes effort, so we constantly refactor our code as we work with it.

Tests are like having a safety net of regression tests that give us confidence to make changes in our code base.

Benefits of TDD 
--------------------------- 
Having the test written first makes us: 
- Clarify the acceptance criteria for the next piece of work that we are going to write
encourage writing loosely coupled components.
- Those components can be easily tested in isolation and, at higher levels, combined together.
- Adds an executable description of what the code does.
- Adds a complete regression suite (implementation)
- Detects errors while the context is fresh in our mind.
- Let's us know when we have done enough, discouraging unnecessary features.

The golden rule of TDD is :

> Never write a new functionality without a failing test

How writing a test first helps the Design
----------------------------------------
- Starting with a test means that we have to describe what we want to achieve before we consider how.
- To keep unit tests understandable we have to limit their scope.
- To construct an object for a unit test, we have to pass its dependencies to it, which means that we have to know what they are. 
- This encourages context independence, since we have to be able to set up the target object’s environment before we can unit test it..

Application from scratch - walking skeleton
----------------------------------------------
The first thing that we have to do if we create an application from scratch is to create walking skeleton. Deciding what to do will flush all sorts of questions about the application and its place in the world. The automation of building, packaging and deploying into a production-like environment will flush out all sorts of technical and organizational questions.

An important part of the test-driven development skills is judging, where to set the boundaries of what to test and how to eventually cover everything.

The most important thing is to have a sense of direction and a concrete implementation to test your assumptions. 

All the mundane but brittle tasks, such as deployment and upgrades, will have been automated in the beginning of the project. Well-run incremental development and project automation in the firsts stages of a project seems starting unsettled but then after few features have been implemented settles in to a routine.

Working with legacy code
---------------------------------------------------------------------------------
It is risky to start changing a system where there are no tests to detect regression. The safest way to start the TDD process is to automate the build and deploy and then we can add end to end tests to cover the areas of code that we need to change. With this protection we can start to address internal quality issues with more confidence, refactoring the code and introducing unit tests and as we add functionality. 

Test readability
------------------------------
Our tests should be expressive and transmit intention through its names. It’s not the same:

{% highlight java %}
@Test
void testAuctionMethod() throws Exception
{% endhighlight %}
than 

{% highlight java %}
@Test
public void notifiesAuctionClosedWhenCloseMessageReceived() throws Exception
{% endhighlight %}

The name of the test should be the first clue for a developer to understand what is being tested and how the target object is supposed to behave.

The first test name doesn't transmit intention, we don't know beforehand what this method is going to test. The second one has a long name but 

> it suggests intention and this is what we are looking for in our unit tests.

When the test reads well, we then build up the infrastructure to support the test. We know we have implemented enough of the supporting code when the test fails in the way we'd expect, with a clear error message describing what needs to be done. Only then we start writing the code to make the test pass. 

Pressured by a deadline?
--------------------------------------
Lots of teams leave tests for the end of the project and they start with the implementation. In the following graphic we can see the amount of chaos that a team needs to handle if the tests are done at the beginning of the project or in the last minute.

![test first vs test later]({{ site.baseurl }}/images/Test-First_Test-Later.png)
  
If you’re a dealing with a hard deadline and the code base is difficult to introduce unit tests in it, you can negotiate doing them after the deadline, but try to reduce the number of times that you have to delay it. 

> Start testing in the first stages of the project and don’t leave them for the end of the project. 

Conclusion
---------------
In this post we have talked about test driven development and his advantages. I definitely recommend that you read Growing object oriented software guided by tests.by Steve Freeman and Nat Pryce.



