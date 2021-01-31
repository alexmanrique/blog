---
layout: single
title: "How to detect and fix memory leaks in your Java application"
date: 2021-01-29 19:08:53 +0200
categories: books
comments: true
lang: en
tags: developer, 2021
image: images/developer-2021.jpg
---

In this post we are going to talk about how to find a memory leak in Java and some strategies to fix them. 

Unknown unknown
---------------------
You don’t look actively into memory leaks in your Java code if there are no symptoms that lead you to think that you have a memory leak. It’s a common unknown unknown between java developers that are starting their career in software development. 

Memory leak symptoms
---------------------
One of the symptoms is that you see that: 
- your application is not behaving as expected 
- it stops without a particular reason
- you need to restart everyday this application cause the memory usage increases without limit. 
- you detect out-of-memory heap error in the logs.

Common reasons
--------------------
Common reasons for a memory leak can be resource that is not released:
 
```java
 private static final String QUERY_INSERT = "INSERT INTO CARS (CODE, NAME) VALUES (?, ?)";
 
 public static void insertCar(Car car, Connection connection) throws SQLException {
        PreparedStatement stmt = connection.prepareStatement(QUERY_INSERT);
        stmt.setString(1, car.getCode());
        stmt.setString(2, car.getName());
        stmt.executeUpdate();
        //stmt.close(); <-- Not calling this close can lead to memory leak 
}
```
A way to solve this memory leak will be using the try with resources that closes the `PreparedStatement` 

```java

 private static final String QUERY_INSERT = "INSERT INTO CARS (CODE, NAME) VALUES (?, ?)";

    public static void insertCar(Car car, Connection connection) throws SQLException {
        try (PreparedStatement stmt = connection.prepareStatement(QUERY_INSERT)) {
            stmt.setString(1, car.getCode());
            stmt.setString(2, car.getName());
            stmt.executeUpdate();
        }
    }
```

A reference to an object is not released

// example of object that is not released

Maps keeping references alive because equals and hashcode are not implemented.

Inner classes that reference outer classes can leak. (make them static to avoid).
//  example of inner class that references and outer class

How to fix this problems?
---------------------------
You should use a tool like VisualVM to visualize the memory usage of your application. You can download it from the following link https://visualvm.github.io/ 

Once you have downloaded it you can open the application and attach VisualVM to your application.

Next step is to perform the operation that causes the bad performance. Inspect the Monitor and the memory pools tab. The objects leaked will be in the old gen pool.
 
How to proceed
---------------------
One thing that you can do is to comment parts of the code that might be the root cause of your problem to see if the memory leak disappears. 

You should look for unclosed `PreparedStatement` if you have code that accesses to the database, you should check `OutputBufferSteam`, `File`, `InputBufferStream` and ensure that you are closing them.

Make sure to use properly code that has `Autoclosable` if you are using Java 7 or later, opening the resource with the try catch with resources capability this way you will not need to close explicitly

Heap dumps
----------------
Heap dumps can help you to investigate if there’s a memory leak in your code , they allow you to see how many instances of classes are open and how much space they utilize.  

Conclusion
-----------------



 

