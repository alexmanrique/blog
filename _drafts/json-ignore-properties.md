---
layout: single
title: "Mantaining backward compatibility - Don't break your clients"
date: 2019-12-31 00:13:53 +0200
categories: development
comments: true
lang: en
tags: apis, java, jaxrs, backward compatibility
---

Maintaining backward compatibility between different releases of your API is of *utmost* importance in ensuring that your API will remain compatible with all of the clients that consume it.

Note: We are talking in this post about client-server integrations that use Java in the server side and use java client contracts in client side.

Adding fields
--------------------------------
`JsonIgnoreProperties` is a <a href="https://github.com/FasterXML/jackson">jackson</a> annotation that allows to ignore new fields sent from a client to a java jaxrs API. Jackson is a library that allows you to serialize and deserialize json to java objects and viceversa, it's included in JBoss application server in his dependencies and you can include it in your project. This is important if you want to keep backward compatibility. 

Imagine that you have a service that you want to add a new parameter to an existing method of some endpoint.

```java
public interface OrderService {
   createOrder(Order order);
}
```

```java
public class Order {
    private Long id;
    private Customer customer;
    private Payment payment; 
}
```

```java
public class OrderApiResource implements OrderService {

@Override
public createOrder(Order order){
  //do whatever
}
}

```

If you release the service with the changes to accept a new parameter you have to enable that this new field is *optional* and not mandatory. 

```java
public class Order {
    private Long id;
    private Customer customer;
    private Payment payment;
    private String newFieldThatThorwJacksonException;
}
```

If you just add a new field in a request object and you don’t have this annotation you will receive in the clients an error from the service similar to this:

```
org.codehaus.jackson.map.exc.UnrecognizedPropertyException: Unrecognized field *** not marked as ignorable at *** at org.codehaus.jackson.map.exc.UnrecognizedPropertyException ***
```

To avoid this exception to be thrown you have to add the annotation in the `Order` class 

```java
@JsonIgnoreProperties(ignoreUnknown = true)
public class Order {
    private Long id;
    private Customer customer;
    private Payment payment;
    private String newFieldThatDoesntThorwsJacksonException;
}
```

Removing fields
------------------------------
If you need to remove fields a good way to do it is to warn your clients that in a future release those fields will not be available anymore or create a new version of the API.

In the previous example if we want to remove the field `newFieldThatDoesntThorwsJacksonException` we should use `@Deprecated` annotation 

```java
@JsonIgnoreProperties(ignoreUnknown = true)
public class Order {
    private Long id;
    private Customer customer;
    private Payment payment;
    @Deprecated
    private String newFieldThatDoesntThorwsJacksonException;
}
```
When we add this annotation we should publish a new version of the contract and allow the clients use this contract. Deprecated annotation should warn them that this new field will be removed in a future release and they should avoid using it.


Conclusion
-------------------------
We have seen a way to mantain backward compatiblity in java rest apis using jackson library.

An stackoverflow question/answer about this topic:
https://stackoverflow.com/questions/5455014/ignoring-new-fields-on-json-objects-using-jackson

This is the documentation for the jackson annotation:
http://fasterxml.github.io/jackson-annotations/javadoc/2.7/com/fasterxml/jackson/annotation/JsonIgnoreProperties.html







 















  












