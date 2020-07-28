---
layout: single
title: "Avoid breaking backward compatibility in your REST Java API"
date: 2019-12-29 00:13:53 +0200
categories: development
comments: true
lang: en
tags: apis, java, jaxrs, backward compatibility
---

![java code]({{ site.baseurl }}/images/java-code.jpg)

Keeping backward compatibility between different releases of your API is of _utmost_ importance in ensuring that your API will remain compatible with all of the clients that consume it.

We will talk in this post about client-server integrations that use Java in the server side and use Java client contracts in client side.

There are different approaches to design an API but here we are using a <a href="https://dzone.com/articles/designing-rest-api-what-is-contract-first">_contract first approach_</a> where we establish a definition of your API before the implementation of it. 


Changing contract - Adding fields
--------------------------------
 
Imagine that you have a service that you want to add a new field in an object parameter of an existing method of an endpoint. Let's look at the following example:

This is the Java interface that defines the contract. 

```java
public interface OrderService {
   createOrder(Order order);
}
```

This is the Resource that implements the operation in the service.

```java
public class OrderApiResource implements OrderService {

@Override
public createOrder(Order order){
  //do whatever
}
}

```
This is the class that defines an `Order`.

```java
public class Order {
    private Long id;
    private Customer customer;
    private Payment payment; 
}
```

In the following architecture diagram we can see the interaction between 2 clients that are using a order-contract-1.0.0 and the server that they are calling where is implemented the service and that uses also 1.0.0 version of the contract. 

{:refdef: style="text-align: center;"}
![Client-server]({{ site.baseurl }}/images/Client-server.png)
{: refdef}

If you release the service with changes to accept a new parameter you have to enable that this new field is *optional* and not mandatory. We release order-contract-1.0.1 new version and we release also the service that implements this new contract.  

This new version of the contract has added a new field in the `Order` class.

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

Adding this new field has broken the integration between the clients and the server because a new unrecognized property has been added without the _agreement_ of the clients.

{:refdef: style="text-align: center;"}
![Client-server]({{ site.baseurl }}/images/Client-server_2.png)
{: refdef} 

`@JsonIgnoreProperties` is a <a href="https://github.com/FasterXML/jackson">Jackson</a> annotation that allows to ignore new fields sent from a client to a java jaxrs API. Jackson is a library that allows you to serialize and deserialize json to java objects and viceversa, it's <a href="https://docs.jboss.org/resteasy/docs/3.0.2.Final/userguide/html/json.html">included</a> in JBoss application server in his dependencies and you can include it in your project. This is important if you want to keep backward compatibility.

To avoid this exception to be thrown you have to <a href="https://stackoverflow.com/questions/5455014/ignoring-new-fields-on-json-objects-using-jackson">add</a> the annotation in the `Order` class 

```java
@JsonIgnoreProperties(ignoreUnknown = true)
public class Order {
    private Long id;
    private Customer customer;
    private Payment payment;
    private String newFieldThatDoesntThorwsJacksonException;
}
```
With this new version of orders-contract-1.0.2 clients don't break because the new String is not mandatory to send in the request when we create a new `Order`

{:refdef: style="text-align: center;"}
![Client-server 3]({{ site.baseurl }}/images/Client-server_3.png)
{: refdef}

Changing contract - Removing fields
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
When we add this annotation we should publish a new version of the contract and allow the clients use this contract. Deprecated annotation will warn clients that this new property will be removed in a future release and they should avoid using it. How you keep backward compatibility in your API's? Leave a comment below to share how you achieve backward compatibility. 


Conclusion
-------------------------
We have seen a way to mantain backward compatiblity in Java rest apis using jackson library in the two most important scenarios, when we have to add fields and when we have to remove. 








 















  












