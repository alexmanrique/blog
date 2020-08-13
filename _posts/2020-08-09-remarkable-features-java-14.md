---
layout: single
title: "Remarkable features in Java 14"
date: 2020-08-09 22:00:53 +0200
categories: development
comments: true
lang: en
tags: java, development, java14 
---

![coffee]({{ site.baseurl }}/images/coffee.png)

In this post we are going to talk about the new features in <a href="https://docs.oracle.com/en/java/javase/14/">Java SE 14</a> and its open source Java Development kit (<a href="https://openjdk.java.net/projects/jdk/14/">JDK 14</a>) that was released on March 17th 2020 (yes during the covid-19 lockdown) and we will see also how we can take advantage of this new features to develop. 

JEP-305: Pattern matching for instanceof
---------------------------------
To reduce the number of casts in the Java applications a new feature has been introduced in this version. It's called `Pattern matching for instanceof` and to understand it we will use an example:

In older versions of Java when we don't know if an object is an instance of a class we have to do something like this:

```java

if(s instanceof String){
	String value = (String)s;
	value.contains ...
}

```
Now with this new feature we will be able to do this:

```java

if(s instanceof String s){
	s.contains ...
}

```
Notice that we don't have to do the cast like in previous versions. This will reduce the bolierplate code that we had to do everytime that we were using an instanceof. 

My personal opinion here is that Java code that is using `instanceof` has poor design and is not using <a href="https://www.w3schools.com/java/java_polymorphism.asp">polimorphism</a> the right way. However, If you have to deal with instanceof in your legacy code you can take advantage of this new feature ;)

More info in <a href="https://openjdk.java.net/jeps/305">JEP 305</a> link.

JEP-358: Detailed message in NullPointerExceptions
--------------------------------------------
This can be really useful because when encountering a null pointer, the JVM analyses the program to determine which reference was `null` and provide more details in the `NullPointerException.getMessage()`. Also the method, filename and line number are returned. 

This option by default is disabled, to active it we need to use `-XX:+ShowCodeDetailsInExceptionMessages`. If you want to know how to configure it I share with this <a href="https://jlefebure.com/blog/detailed-nullpointerexception-messages-in-jdk-14">post</a> where you can see how to do the configuration.

More info can be found in the <a href="https://openjdk.java.net/jeps/358">JEP 358</a>

JEP-359: Records 
--------------------------
Records is a new kind of declaration in Java programming language. Like an <a href="https://docs.oracle.com/javase/7/docs/api/java/lang/Enum.html">enum</a> a `record` is a restricted form of class. Java has been critized for being a verbose programming language and this goes in the direction to reduce the boilerplate code. 

Classes that only have state without any logic that have constructor, getters, setters, equals, hashcode and toString. All this methods have to be created everytime that we want to create a class that just carries data. For example 

```java
record Point(int x, int y) { }
```
A `record` acquires many standard members automatically.
- a private final field for each component declared.
- a public read accessor for each member.
- a public constructor
- implementatons of equals and hashcode
- an implementation of toString()

All components are final by default, so this new way to define a data carrier in Java embraces inmutability by default policy. 

What if we need to control the input arguments that we receive? In the following code snippet we can see how to do it. 

```java
record Appartment(int squareMeters) {
  public Appartment {
    if (squareMeters<=0)  /* referring here to the implicit constructor parameters */
      throw new IllegalArgumentException(String.format("(%d)", squareMeters));
  }
}
```

More info can be found in <a href="https://openjdk.java.net/jeps/359">JEP 359</a>

JEP-361: Switch expressions
-------------------
How many times we had to deal with switch case expressions? Are you familiar with the usage of `break` if you don't remember, here is a java code snipped. 

```java
switch (month) {
    case JANUARY:
    case FEBRUARY:
    case MARCH:
        System.out.println(6);
        break;
    case APRIL:
        System.out.println(7);
        break;
    case :
    case MAY:
        System.out.println(8);
        break;
    case JUNE:
        System.out.println(9);
        break;
}
```
A new form of switch label, "case L ->", has been added to this new version and now only the code to the right of the label is going to be executed if the label is matched. Also, multiple constants per case are allowed, separated by commas. The previous code can now be written like this:

```java
switch (month) {
    case JANUARY, FEBRUARY, MARCH -> System.out.println(6);
    case APRIL  -> System.out.println(7);
    case MAY -> System.out.println(8);
    case JUNE   -> System.out.println(9);
}
```
More info can be found in <a href="https://openjdk.java.net/jeps/361">JEP 361</a>

JEP-368: Text blocks
------------------------
In this new feature we will be able to print a multi-line string literal that avoids the need to scape sequences.

Using "one-dimensional" string literals

```java
String query = "SELECT `EMPLOYEE_ID`, `SUR_NAME` FROM `EMPLOYEE_TB`\n" +
               "WHERE `CITY` = 'BARCELONA'\n" +
               "ORDER BY `EMPLOYEE_ID`, `SUR_NAME`;\n";
```
Using a "two-dimensional" block of text

```java
String query = """
               SELECT `EMPLOYEE_ID`, `SUR_NAME` FROM `EMPLOYEE_TB`
               WHERE `CITY` = 'BARCELONA'
               ORDER BY `EMPLOYEE_ID`, `SUR_NAME`;
               """;
```

From now on embedding a snippet of HTML, XML, SQL, or JSON in a string literal will be easier than before. 

For more information about this feature you can read <a href="https://openjdk.java.net/jeps/368">JEP 368</a>

Conclusion
------------------------
In this post we have seen the more remarkable features in Java 14. Which is your favourite new feature? 



