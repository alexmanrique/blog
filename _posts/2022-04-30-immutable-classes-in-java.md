---
layout: single
title: "Immutable classes in Java"
date: 2022-04-30 09:08:53 +0200
categories: development
comments: true
lang: en
tags: inmutability, java
image: images/inmutable.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/inmutable.jpg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@jjying?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">JJ Ying</a> on <a href="https://unsplash.com/s/photos/tech?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef} 

In this post we are going to talk about the importance of writing inmutable classes in Java. There are developers that don't know the concept of immutability and why this is important when programming in Java. 

Classes and Objects in Java
-----------------------------
A class in a object oriented language like Java is the definition of a concept from a particular domain, and an object it's an instance of this abstraction. Also we can talk about classes as object constructors or a "blueprint" for creating objects. Inmutability applies to classes and objects created from this definitions. 

Plain old Java objects - POJO
---------------------------------
Plain old Java object it's an instance of a domain class which has only fields and without any business logic. Only attributes that should be encapsulated.

The attributes of this POJO should be only modified in the creation of an object of the class and should not be modified after the creation of it. 

What's an Immutable Object
--------------------
An inmutable object, it's an object that once it has been created cannot be modified after it's creation. In Java we have examples of inmutable classes like String or Wrapper classes like Float, Integer, Boolean, Short, Integer, Long, Float, Double, Byte or Char.

Benefits of Inmutable Objects
---------------------------------
If we allow that the state of an object is modified during the lifetime of it we open the door to situations like <a href="https://stackoverflow.com/questions/34510/what-is-a-race-condition">race conditions</a> in case that we have multiple threads that read and modify the state of this object. 

If an inmutable object remains constant in time and we can share it safely among multiple threads. 

> We can say that immutable objects are side-effects free. 

So immutable objects are a must for multithread applications, because multiple threads can try to modify a shared resource (i.e: instance variables)

How to create an inmutable class in Java
------------------------------------------

### 1 - Remove setter methods

```java
public class Player {

    private int age;
    private String name;
    private int height;

    //  :-( Don't have this method
    public void setAge(int age){
     
    }
    //  :-( Don't have this method
    public void setName(String name){
        
    }
    //  :-( Don't have this method
    public void setHeight(int name){
        
    }
    
}
```

### 2 - Provide all-argument in constructor.

```java
public class Player {

    private int age;
    private String name;
    private int height;

    //  :-( One missing argument
    public Player(int age, String name){

    }

    // :-) Good constructor
    public Player(int age, String name, int height){

    }
    
}
```

### 3 - Set class fields final.

```java
public class Player {

    //  :-)
    private final int age;
    private final String name;
    private final int height;
 
}
```

### 4 - Use deep clone for mutable fields that you receive in the constructor.
```java
public class Player {

    private final int age;
    private final String name;
    private final int height;
    private final Adress address;

    public Player(int age, String name, int height, Address address){
        this.age = age;
        this.name = name;
        this.height = height;
        //  :-)
        this.address = new Address(address.getStreetName(), address.getCityName(), adress.getPostalCode(), adress.getCountry());
    }
 
}
```


### 5 - Return deep cloned object of mutable fields. 
```java
public class Player {

    private final int age;
    private final String name;
    private final int height;
    private final Adress address;

    public Player(int age, String name, int height, Address address){
        this.age = age;
        this.name = name;
        this.height = height;
        this.address = new Address(address.getStreetName(), address.getCityName(), adress.getPostalCode(), adress.getCountry());
    }
    ...
    //  :-)
    public Address getAddress(){
        return new Address(address.getStreetName(), address.getCityName(), adress.getPostalCode(), adress.getCountry());
    }
}
```

Conclusion 
-----------------
In this post we have seen the concepts of clases and objects, what is a POJO, immutability in Java, benefits of immutable classes and how to create immutable classes in the Java programming language.









