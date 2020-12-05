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
Behavoir driven development (BDD) it's like an extension to Test driven development (TDD) where the collaboration between developers, QA's and non-technical participants pursue the definition of a set of sentences that will become executable tests. 

Those tests look to meet the acceptance criteria defined before starting the development of the project. The idea is to formalize the shared knowledge of how the application should behave.

BDD is achieved through the usage of domain specific language (DSL) like natural language constructs (e.g., English like sentences) that can express the behavoir and the expected outcome.

User story definition
--------------------------------
Every user story should define the following: 

Title

An explicit title.

Narrative

A short introductory section with the following structure:
As a: the person or role who will benefit from the feature;
I want: the feature;
so that: the benefit or value of the feature.

Acceptance criteria

A description of each specific scenario of the narrative with the following structure:

Given: the initial context at the beginning of the scenario, in one or more clauses;

When: the event that triggers the scenario;

Then: the expected outcome, in one or more clauses.


Using gherkin in your acceptance tests
---------------------------------------

Given we have a bunch of books in our store

When a request is done to our books-api with an id

Then the books-api returns a book


Given we have no books in our store

When a request is done to our books-api with an id

Then the books-api returns no book


Given we have a bunch of books in our store

When a request is done to our books-api to retrieve all books

Then the books api returns all book ids


Boundaries in your application
-------------------------------
The first step to define what are you going to test is to know the boundaries of your application. Is your application using an external API to retrieve data or to do any kind of operation? your acceptance tests should not depend on external services or systems, these are the boundaries of your application where you call these external systems. 

Mocking our boundaries
-------------------------------
To have deterministic tests that don't fail randomly and that test only your code and not the code from the external systems you should mock those systems in a way that represent the normal behavoir of this external system. I.e: if you are using an api that given a carId returns a Car entity you can create a mock that returns this Car entity. 

Typically what you can do in services that are defined by contracts is to create a particular implementation for the contract that you control and that you know what this implementation is going to return.

```java
public interface LibraryService {
    Book findBookById(long id); 
}  

public class LibraryServiceMock implements LibraryService {

    Book findBookById(long id) {
        return new Book();
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
   