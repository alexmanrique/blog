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
A class in a object oriented language like Java is the definition of a concept from a particular domain, and an object it's an instance of this abstraction. Also we can talk about classes as object constructors or a "blueprint" for creating objects. Immutability applies to classes and objects created from this definitions. 

Plain old Java objects - POJO
---------------------------------
Plain old Java object it's an instance of a domain class which has only fields and without any business logic. Only attributes that should be encapsulated.

The attributes of this POJO should be only modified in the creation of an object of the class and should not be modified after the creation of it. 

What's an Immutable Object
--------------------
An immutable object, it's an object that once it has been created cannot be modified after it's creation. In Java we have examples of inmutable classes like String or Wrapper classes like Float, Integer, Boolean, Short, Integer, Long, Float, Double, Byte or Char.

Benefits of Inmutable Objects
---------------------------------
If we allow that the state of an object is modified during the lifetime of it we open the door to situations like <a href="https://stackoverflow.com/questions/34510/what-is-a-race-condition">race conditions</a> in case that we have multiple threads that read and modify the state of this object. 

If an inmutable object remains constant in time we can share it safely among multiple threads. 

> We can say that immutable objects are side-effects free. 

So immutable objects are a must for multithread applications, because multiple threads can try to modify a shared resource (i.e: instance variables)

How to create an inmutable class in Java
------------------------------------------

### 1 - Remove setter methods

In the following class we have setter methods. That is one of the reasons why this class is mutable. Having a setter allows to change the state of the object after being created. 

```java
public class Player {
    
    // :-( attributes are not final
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

In the following class we have two constructors, one that provides all the arguments and another that has one missing argument. This forces to have a setter from the missing argument that we have not provided in the constructor. 

```java
public class Player {

    // :-( attributes are not final
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

Having all the fields of the class as final makes that we are not allowed to change the state of this fields and make that we have to define all the arguments in the constructor and if we have setters we cannot change the value of them, otherwise we will have a compilation error. 

```java
public class Player {

    //  :-)
    private final int age;
    private final String name;
    private final int height;
 
}
```

### 4 - Use deep clone for mutable fields that you receive in the constructor.
In this case in the class we have a `Map` that is mutable. In the constructor we make a copy of this `Map` that we receive in the constructor because this data structure can be changed from outside the `Player` and we want to keep the class immutable.   

```java
public class Player {

    private final int age;
    private final String name;
    private final int height;
    private final Map<String, String> metadata;

    public Player(int age, String name, int height, Address address){
        this.age = age;
        this.name = name;
        this.height = height;
        //  :-)
        Map<String, String> tempMap = new HashMap<>();
        for (Map.Entry<String, String> entry :
             metadata.entrySet()) {
            tempMap.put(entry.getKey(), entry.getValue());
        }
        this.metadata = tempMap;
    }
 
}
```


### 5 - Return deep cloned object of mutable fields. 

In the get method of the metadata `Map` we create a copy also because the moment that we return it, a client  can change it from outside the `Player` class and we want to avoid the modification of the state of our `Player` class. 

```java
public class Player {

    private final int age;
    private final String name;
    private final int height;
    private final Map<String, String> metadata;

    public Player(int age, String name, int height, Address address){
        this.age = age;
        this.name = name;
        this.height = height;
        Map<String, String> tempMap = new HashMap<>();
        for (Map.Entry<String, String> entry :
             metadata.entrySet()) {
            tempMap.put(entry.getKey(), entry.getValue());
        }
        this.metadata = tempMap;
    }
    ...
    //  :-)
     public Map<String, String> getMetadata(){
        Map<String, String> tempMap = new HashMap<>();
        for (Map.Entry<String, String> entry :
             this.metadata.entrySet()) {
            tempMap.put(entry.getKey(), entry.getValue());
        }
        return tempMap;
    }
}
```

Conclusion 
-----------------
In this post we have seen the concepts of clases and objects, what is a POJO, immutability in Java, benefits of immutable classes and how to create immutable classes in the Java programming language.









