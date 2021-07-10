---
layout: single
title: "How to apply template method design pattern in Java"
date: 2021-05-09 09:08:53 +0200
categories: development
comments: true
lang: en
tags: java, design-patterns
image: images/template.jpeg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/template.jpeg)
{: refdef}

{:refdef: style="text-align:center font-size:9px"}
Photo by <a href="https://unsplash.com/@domenicoloia?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Domenico Loia</a> on <a href="https://unsplash.com/s/photos/design?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef}  

This week I was with a co-worker doing <a href="https://en.wikipedia.org/wiki/Pair_programming">pair programming</a> and we saw that two Java classes were very similar.

## The problem: duplicate code

The two Java classes instantiated a publisher and sent a message to a <a href="https://kafka.apache.org/documentation/#intro_topics">Kafka topic</a>. The only difference between the two was that they posted on different topics. Here you can see the `TestAssignmentPublisher` class.

```java
public class TestAssignmentPublisher {

    private static final Logger LOGGER = Logger.getLogger(EventPublisher.class);

    @MessagePublisher(topic = TEST_ASSIGNMENT_TOPIC)
    private Publisher<DomainEvent> publisher;
    
    ...

    public <T extends SpecificRecord> void publish(T record) {
        final DomainEvent<T> domainEvent = new DomainEvent<>(record);
        try {
            publisher.publish(domainEvent);
        } catch (final PublishMessageException e) {
            LOGGER.error("Error publishing domain event of type: " + record.getClass() + " : " + record.toString(), e);
        }
    }
}
```

And the `VisitCreatedPublisher` class that as you can see is a "copy-paste" of the previous one.

```java
public class VisitCreatedPublisher {

    private static final Logger LOGGER = Logger.getLogger(EventPublisher.class);

    @MessagePublisher(topic = VISIT_CREATED_TOPIC)
    private final Publisher<DomainEvent> publisher;

    ...

    public <T extends SpecificRecord> void publish(T record) {
        final DomainEvent<T> domainEvent = new DomainEvent<>(record);
        try {
            publisher.publish(domainEvent);
        } catch (final PublishMessageException e) {
            LOGGER.error("Error publishing domain event of type: " + record.getClass() + " : " + record.toString(), e);
        }
    }
}
``` 

One might think that the name of the topic could be parameterized by passing it as a parameter to the function that published in the kafka queue. 

It was not a possible solution because to instantiate the kafka topic as you can see in the previous code you have to use an annotation to define the topic in which we want to publish.

## The solution: Use template method design pattern

As the two classes needed the same code, we thought about using an <a href="https://docs.oracle.com/javase/tutorial/java/IandI/abstract.html">abstract class</a> where we could put the common code and then an abstract method that would be the one that would give us the `publisher` corresponding to the implementation that interests us.

```java
public abstract class EventPublisher {

    private static final Logger LOGGER = Logger.getLogger(EventPublisher.class);

    public abstract Publisher<DomainEvent> getPublisher();
    public abstract String getTopicName();

    public <T extends SpecificRecord> void publish(T record) {
        final DomainEvent<T> domainEvent = new DomainEvent<>(record);
        try {
            getPublisher().publish(domainEvent);
        } catch (final PublishMessageException e) {
            LOGGER.error("Error publishing domain event of type: " + record.getClass() + " : " + record.toString(), e);
        }
    }
}
``` 

Next we see the first implementation of the abstract class.

```java
public class TestAssignmentEventPublisher extends EventPublisher {

    private static final String TEST_ASSIGNMENT_TOPIC = "EXPERIMENTS.TEST_ASSIGNMENT";

    @MessagePublisher(topic = TEST_ASSIGNMENT_TOPIC)
    private Publisher<DomainEvent> publisher;

    @Override
    public Publisher<DomainEvent> getPublisher() {
        return publisher;
    }

    @Override
    public String getTopicName() {
        return TEST_ASSIGNMENT_TOPIC;
    }
}
```

And here we have the second implementation of the abstract class.

```java
public class VisitCreatedEventPublisher extends EventPublisher {

    private static final String VISIT_CREATED_TOPIC = "VISIT.VISIT";

    @MessagePublisher(topic = VISIT_CREATED_TOPIC)
    private Publisher<DomainEvent> publisher;

    @Override
    public Publisher<DomainEvent> getPublisher() {
        return publisher;
    }
    @Override
    public String getTopicName() {
        return VISIT_CREATED_TOPIC;
    }
}
```

We are using the design pattern called <a href="https://en.wikipedia.org/wiki/Template_method_pattern"> `template`</a> where we have a common logic which is what we have put in the abstract class and then for each <a href="https://docs.oracle.com/javase/tutorial/java/IandI/subclasses.html">subclass</a> we define the topic where we want to publish the messages.

> we have managed to reuse code and leave it extensible to be able to add future implementations that will be able to  publish in other kafka topics without changing the code we already have.

## Conclusion

In this post we have seen how to reuse code using the design pattern called `template`. Do you use design patterns when developing software? What is your favorite?
