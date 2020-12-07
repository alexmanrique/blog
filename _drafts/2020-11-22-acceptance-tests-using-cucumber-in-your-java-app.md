---
layout: single
title: "Acceptance tests using cucumber in your Java application"
date: 2020-11-22 12:08:53 +0200
categories: development
comments: true
lang: en
tags: mocks, testing
image: images/
---

Behavior driven development
-------------------------------
Behavoir driven development (BDD) it's like an extension to Test driven development (TDD) where the collaboration between developers, QA's and non-technical participants pursue the definition of a set of sentences that will become executable tests. 

Those tests look to meet the acceptance criteria defined before starting the development of the project. The idea is to formalize the shared knowledge of how the application should behave.

BDD is achieved through the usage of domain specific language (DSL) like natural language constructs (e.g., English like sentences) that can express the behavoir and the expected outcome.

User story definition
--------------------------------
Every user story should define the following: 

- Title: An explicit title.

- Narrative : A short introductory section with the following structure:
As a: the person or role who will benefit from the feature;
I want: the feature;
so that: the benefit or value of the feature.

+ Acceptance criteria: A description of each specific scenario of the narrative with the following structure:
    - Given: the initial context at the beginning of the scenario, in one or more clauses.
    - When: the event that triggers the scenario.
    - Then: the expected outcome, in one or more clauses.

Using cucumber for your acceptance tests
---------------------------------------
One of the frameworks that I like to use when I have to develop acceptance tests is called <a href="https://cucumber.io/docs/installation/java/">`Cucumber`</a>. It has a java library for Java Maven applications that you can integrate easily within your `pom.xml`

```java
<dependency>
    <groupId>io.cucumber</groupId>
    <artifactId>cucumber-java</artifactId>
    <version>6.8.1</version>
    <scope>test</scope>
</dependency>
```

In the following example we will define a group of sentences to test a API that allows creating and reading books from a store.

```java
Group of tests to validate the books-api behavior

Developers that need to retrieve booking data will benefit from the books-api operations

Given a book with id 1 in our store

When a request is done to our books-api with an id 1

Then the books-api returns a book with id 1
```

each one of this sentences needs to be defined inside parenthesis in an anotation 

```java

@ScenarioScoped
public class BooksApiSteps {

private BooksApiService booksApiService;
private Book bookRetrieved;
private Book bookCreated;

@Inject
public BooksApiSteps(BooksApiService booksApiService){
    this.booksApiService = booksApiService;
}

@Given("a book with id $1 in our store")
public void createABookGivenAnId(String uuid) {
    bookCreated = new BookingBuilder.withId(uuid).build(new Random());
    booksApiService.create(bookCreated);
}
    
@When("a request is done to our books-api with id $1")
public void aRequestIsDoneToRetrieveABook(String uuid) {
    bookRetrieved = booksApiService.getBookById(uuid);
}

@Then("the books-api returns a book with id $1")
public void validateTheResponse(String uuid) {
    assertEquals(bookCreated, bookRetrieved);
    assertEquals(uuid, bookRetrieved.getUuid());
}

}
```

Boundaries in your application
-------------------------------
The first step to define what are you going to test is to know the boundaries of your application. Is your application using an external API to retrieve data or to do any kind of operation? 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/acceptance_tests_boundaries.png)
{: refdef}

your acceptance tests should not depend on external services or systems, these are the boundaries of your application where you call these external systems. 

Mocking our boundaries
-------------------------------
To have deterministic tests that don't fail randomly and that test only your code and not the code from the external systems you should mock those systems in a way that represent the normal behavoir of this external system.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/acceptance_tests_mocking.png)
{: refdef}

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

Given the previous mock of `LibraryService` it would be good to use it in a lightweight application server like <a href="https://www.eclipse.org/jetty/">Jetty</a>

```java
import com.sun.net.httpserver.HttpServer;
import org.apache.log4j.Logger;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.NetworkTrafficServerConnector;
import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.server.handler.HandlerList;

private final NetworkTrafficServerConnector connector;
private final ContextHandlerCollection contextHandlerCollection;

JettyServer(int portNumber, boolean listenInAllInterfaces) {
   final org.eclipse.jetty.server.Server server = new org.eclipse.jetty.server.Server();
   connector = new NetworkTrafficServerConnector(server);
   connector.setHost(listenInAllInterfaces ? "0.0.0.0" : "localhost");
   connector.setPort(portNumber);
   connector.setIdleTimeout(30000);
   server.addConnector(connector);
   HandlerList handlers = new HandlerList();
   WsGzipHandler wsGzipHandler = new WsGzipHandler();
   contextHandlerCollection = new ContextHandlerCollection();
   wsGzipHandler.setHandler(contextHandlerCollection);
   handlers.addHandler(wsGzipHandler);
   // Needed by Jetty to publish endpoints
   handlers.addHandler(contextHandlerCollection); 
   server.setHandler(handlers);
}
```
This way every time that we call the endpoint `findBookById` we will receive the object that we have set in our `BooksApiSteps`


Randomize your inputs 
-------------------------------
If you are always sending the same request to the system that you are doing the acceptance test is possible that you always test the same behavoir. For that, a good practise is to randomize the inputs that you do to your services to ensure that there's no corner case that you have not considered.


Conclusion
----------------------------
In this post we have seen the concept of BDD and how can we create acceptance tests using Cucumber. We have seen that is important to mock our boundaries to avoid depending of a third party system to run our tests and we have seen also that we need to randomize the inputs of our tests specially if our tests don't depend on a particular object state. 
   