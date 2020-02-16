---
layout: single
title: "10 mistakes using exceptions in Java"
date: 2020-02-15 00:13:53 +0200
categories: development
comments: true
lang: en
tags: java, exception
---

In this post, we are going to go through some common mistakes using exceptions in java. Exceptions in Java are not an easy topic and different teams can have different views on how to use them in the code. However, there is a set of best practices that are used by most teams. In this post, we are going to see the most important ones you can use to get started or to improve your exception handling.  

## 1- Catching Exception.

There’s a rule in <a href="https://pmd.github.io/pmd-5.8.1/pmd-java/rules/java/strictexception.html">PMD</a> that warns you if you catch `Exception`. If you do it you will treat the same way all kinds of exceptions. The idea is that for every kind of exception you have to give a different treatment, otherwise, you will do the same in all the exceptions. 

```java
//bad practice
catch(Exception e){
    // do whatever you have to do 
}
```
you should catch the especific exception that you expect

```java
//ok 
catch(FileNotFoundException e){
    // do whatever you have to do
}
```

## 2 - Don’t know the difference between checked and unchecked exceptions.

Checked exceptions are the ones that are checked at compile-time and that you have to declare in the method that is throwing them to the callers: I.e: [IOException](https://docs.oracle.com/javase/7/docs/api/index.html?overview-summary.html), [InterruptedException](https://docs.oracle.com/javase/7/docs/api/index.html?overview-summary.html), [FileNotFoundException](https://docs.oracle.com/javase/7/docs/api/java/io/FileNotFoundException.html). 

Unchecked are not checked at compile-time, the kinds of exceptions that are not declared in the methods: I.e: [IllegalArgumentException](https://docs.oracle.com/javase/7/docs/api/java/lang/IllegalArgumentException.html), [NullPointerException](https://docs.oracle.com/javase/7/docs/api/java/lang/NullPointerException.html). Catching [unchecked](https://docs.oracle.com/javase/tutorial/essential/exceptions/runtime.html) exceptions is not a really good practice.

```java
//don't catch unchecked exceptions
catch(NullPointerException e){
    
}
```


## 3 - Use log and throw inside of a catch.

This is an antipattern. Logging and throwing an exception has no sense because if you rethrow the exception means that you are delaying the resolution of this problem to another place, then there’s no need to write anything in the log.

```java
catch(IOException e) {
    logger.error("IOException error" , e);
    throw new SessionException("Session exception " , e);
}
```

you should do this instead:

```java
catch(IOException e) {
    logger.error("IOException error" , e);
    //send a metric to your metrics/alerts system
}
```
or do this instead:

```java
catch(IOException e) {
   throw new SessionException("Session exception " , e);
}
```
## 4 - Using exceptions for non-exceptional situations.

Exceptions are, as their name implies, to be used only for exceptional conditions; they should never be used for ordinary control flow. Read the following [post](https://dzone.com/articles/exceptions-as-controlflow-in-java) if you are curious about the impact in terms of performance if you use exceptions for ordinary control flow.

```java
public Car bookCar(long id){
    Car car = null;
    try {
       Car car = findCarById(id);
    }
    catch(CarNotFoundException e){
        //we are using exceptions to control program flow
    }
  }
}

private Car findCarById(long id){
  Car car = retrieveCarByIdFromDB(id);
  if (car == null){
    throw new CarNotFoundException("Car not found");
  }
  else{
      return car;
  }
}

```
```java 
//better control flow without using exceptions
public Car bookCar(long id){
    Car car = findCarById(id);
    if(car!=null){
       //book car in the system   
    }
    else{
      //handle when car is not found     
    }
  }
}

private Car findCarById(long id){
  return retrieveCarByIdFromDB(id);
}
```

## 5 - Not using finally to close resources (before Java 7)

If you open a [datasource](https://docs.oracle.com/javase/7/docs/api/javax/sql/DataSource.html) connection to interact with the database you have to close it in the `finally` clause. Not doing this can lead to a leak and you can eventually run out of database connections from the database pool.

```java
//you have a connection leak
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    stmt.executeUpdate( "INSERT INTO MyTable( name ) VALUES ( 'my name' ) " );
} 
//we don't do anything else :(
```

```java
// ok
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    // do whatever you want to do
} finally {
    try { rs.close(); } catch (Exception e) { /* ignored */ }
    try { ps.close(); } catch (Exception e) { /* ignored */ }
    try { conn.close(); } catch (Exception e) { /* ignored */ }
}
//we don't have any connection leak
```


## 6 - Not using try with resources mechanism.

Since Java 7 you have the option to use this [mechanism](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html) to write less code. One of the things that Java is criticized is because is a verbose programming language code. With this mechanism, you don’t have to write finally with the closing statement. Not using it means writing more than necessary code. 

```java
   try (Connection connection = datasource.getConnection();
       PreparedStatement stmt = connection.prepareStatement();) {
       ResultSet rs = stmt.executeQuery(query);
   }
   //no don't need to close the connections like before :) 
   
```

## 7 - Non-usage of existing exceptions and creating new ones.

Reusing pre-existing exceptions has several benefits. If you are developing a new API, it will be easier to learn and use it because it matches established conventions that programmers are already familiar with. If you use new exceptions it will be more difficult to learn those new unfamiliar exceptions in your program.

## 8 - Throwing exceptions from low levels to higher levels.

Imagine that a [SQLException](https://docs.oracle.com/javase/7/docs/api/java/sql/SQLException.html) is thrown at the store layer of your application. It’s not a good practice to pass this exception to other layers of your application. If you want to propagate this exception to the front layer is better that you wrap this exception into another Exception that belongs to the domain of the other layers. It's not good to couple store layer with service layer. Your application must be loosely coupled.  

## 9 - Throwable and error classes should not be caught.

[Throwable](https://docs.oracle.com/javase/8/docs/api/java/lang/Throwable.html) should not be caught because if you do it will catch all the exceptions and also the errors thrown by the JVM. Errors are thrown by the JVM to indicate serious problems that are not intended to be handled by the application. For example [OutOfMemoryError](https://docs.oracle.com/javase/8/docs/api/java/lang/OutOfMemoryError.html) or [StackOverflowError](https://docs.oracle.com/javase/8/docs/api/java/lang/StackOverflowError.html) are examples of this kind of errors that can be thrown by the JVM.

```java
//don't do this
catch(StackOverflowError e){
    // do whatever you have to do 
}
```

## 10 - Losing the original exception when logging inside the catch clause. 

Another problem when dealing with exceptions is that the original exception is not wrapped inside another exception. For instance, imagine that we have the following code

```java
//the original exception here is lost
catch(IOException e){
   throw new SessionException(“Session Exception”);
}
```

In this situation, we are losing the original exception that is [IOException](https://docs.oracle.com/javase/7/docs/api/java/io/IOException.html). The good way would be to wrap this IOException inside Exception.

```java
//ok we are not losing the original exception
catch(IOException e){
   throw new SessionException(“SessionException ”, e)
}
```

Conclusion
-------------------------
In this post, we have reviewed the most common mistakes when using exceptions in Java and how to deal with them.
