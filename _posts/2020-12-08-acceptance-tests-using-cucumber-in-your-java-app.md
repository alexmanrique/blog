---
layout: single
title: "Acceptance tests using cucumber in Java applications"
date: 2020-12-8 12:08:53 +0200
categories: development
comments: true
lang: en
tags: mocks, testing
image: images/acceptance-tests.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/acceptance-tests.jpg)
<span>Photo by <a href="https://unsplash.com/@scienceinhd?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Science in HD</a> on <a href="https://unsplash.com/s/photos/tests?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>
{: refdef}

In the same way that vaccines have to be tested before the rollout to the world population, we need to test our software before releasing it also to our customers. 

Today the first <a href="https://www.theguardian.com/world/2020/dec/08/coventry-woman-90-first-patient-to-receive-covid-vaccine-in-nhs-campaign">woman</a> received the Pfizer vaccine and before this, several protocols have been executed before today's event. 

Software engineering it's a science (<a href="https://en.wikipedia.org/wiki/Computer_science">Computer science</a>) and because of that we need procedures to ensure that our software is doing what is expected.   

Behavior-driven development
-------------------------------
Behavior-driven development (BDD) it's like an extension to Test-driven development (TDD) where the collaboration between developers, QA's, and non-technical participants pursue the definition of a set of sentences that will become executable tests. 

Those tests look to meet the acceptance criteria defined before starting the development of the project. The idea is to formalize the shared knowledge of how the application should behave.

BDD is achieved through the usage of domain-specific language (DSL) like natural language constructs (e.g., English-like sentences) that can express the behavior and the expected outcome.

User story definition
--------------------------------
Every user story should define the following: 

- Title: An explicit title.

- Narrative: A short introductory section with the following structure:
As a: the person or role who will benefit from the feature;
I want the feature;
so that: the benefit or value of the feature.

+ Acceptance criteria: A description of each specific scenario of the narrative with the following structure:
    - Given: the initial context at the beginning of the scenario, in one or more clauses.
    - When: The event that triggers the scenario.
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

In the following example, we will define a group of sentences to test an API that allows creating and reading books from a store.

```java
Group of tests to validate the books-api behavior

Developers that need to retrieve booking data will benefit from the books-api operations

Scenario: Validate that we can read an existing book 

Given a book with uuid 123e4567-e89b-12d3-a456-426614174000 in our store

When a request is done to our books-api with an uuid 123e4567-e89b-12d3-a456-426614174000

Then the books-api returns a book with uuid 123e4567-e89b-12d3-a456-426614174000
```

each one of these sentences needs to be defined in the glue code that interacts directly with our application. In this particular case `BooksApiSteps` class is where we have placed our sentences.

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

@Given("a book with id (.*)$ in our store")
public void createABookGivenAnId(String uuid) {
    bookCreated = new BookingBuilder.withUuid(uuid).build(new Random());
    booksApiService.create(bookCreated);
}
    
@When("a request is done to our books-api with id (.*)$")
public void aRequestIsDoneToRetrieveABook(String uuid) {
    bookRetrieved = booksApiService.getBookById(uuid);
}

@Then("the books-api returns a book with id (.*)$")
public void validateTheResponse(String uuid) {
    assertEquals(bookCreated, bookRetrieved);
    assertEquals(uuid, bookRetrieved.getUuid());
}

}
```

Boundaries in your application
-------------------------------
The first step to defining what are you going to test is to know the boundaries of your application. Is your application using an external API to retrieve data or to do any kind of operation? 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/acceptance_tests_boundaries.png)
{: refdef}

your acceptance tests should not depend on external services or systems, these are the boundaries of your application where you call these external systems. 

Mocking our boundaries
-------------------------------
To have deterministic tests that don't fail randomly and that test only your code and not the code from the external systems you should mock those systems in a way that represents the normal behavior of this external system.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/acceptance_tests_mocking.png)
{: refdef}

Typically what you can do in services that are defined by contracts is to create a particular implementation for the contract that you control and that you know what this implementation is going to return.

```java
public interface RatingService {
    Integer getBookingRating(String uuid); 
}  

public class RatingServiceMock implements RatingService {

    Integer getBookingRating(String uuid) {
       //return a value
    } 
}

```

Randomize your inputs 
-------------------------------
If your are always sending the same request to the system that you are testing it's possible that you always test the same behavior. In this case the `BookingBuilder` has different attributes as we can see in the following `builder`.

```java
new BookingBuilder.
      withUuid(uuid).
      withGenre(genre).
      withDatePublished(date).
      withAuthor(author).
      withStars(stars).
      withComments(comments).
      withPrice(price).
      build();
```

A good practice here would be to randomize the inputs that you do to your services to ensure that there's no corner case that you have not considered. It would be good to provide a constructor in your builder that allows creating objects with random fields. 

```java
new BookingBuilder.
      build(new Random());
```
This way you will have books with different types of genres, stars, price ... that should not affect the result of the test execution. 


Conclusion
----------------------------
In this post we have seen the concept of BDD and how can we create acceptance tests using Cucumber. We have seen that is important to mock our boundaries to avoid depending on a third-party system to run our tests and we have seen also that we need to randomize the inputs of our tests especially if our tests don't depend on a particular object state.
