---
layout: single
title: "8 new available features in Java 11"
date: 2021-01-17 09:08:53 +0200
categories: development
comments: true
lang: en
tags: java8, java9, java11
image: images/java11.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/java11.jpg)
{: refdef}

In this blog post we are going to see the most important features that are available in Java 11 for programmers using Java programming language. 

There are a lot of Java developers that are <a href="https://snyk.io/blog/developers-dont-want-to-leave-java-8-as-64-hold-firm-on-their-preferred-release/">still</a> working with Java 8. From 2000 developers that participated in the <a href="https://snyk.io/wp-content/uploads/jvm_2020.pdf">2020 JVM ecosystem report</a>, 64% were still using Java 8.

According to this support <a href="https://www.oracle.com/java/technologies/java-se-support-roadmap.html">roadmap</a> Java SE 8 has gone throught the end of public updates for legacy releases and Oracle will provide only premium support until March 2022. 

1 - Type inference
------------------
This is the main change in Java 10, from now on we can use `var` to create objects without having to define the type. Although as we know, we don't have to go crazy putting `var` on all objects and losing understanding of the code either.

In Java 10 we can see code like:

```java
var list = List.of(4,6,7);
var example = "example";
var team = new Team();
```

Also, with Java 11, the use of `var` in lambdas has been added allowing annotations in these parameters, although you cannot mix the use of `var` with types, nor of `var` and an empty type.

```java

Function<String, String> toLowerCase = (var input) -> input.toLowerCase();
String name = "ALEX";
System.out.println(toLowerCase.apply(name)); 
// alex
Map<Integer, Integer> map = Map.of(1, 2, 3, 4, 5, 6);
map.forEach((x, y) -> System.out.println(x + y));  
// 3 7 11
map.forEach((Integer x, Integer y) -> System.out.println(x + y)); 
// 3 7 11 
map.forEach((var x, var y) -> System.out.println(x + y)); 
// 3 7 11 
map.forEach((x, var y) -> System.out.println(x + y)); // Doesn't compile
map.forEach((int x, var y) -> System.out.println(x + y)); // Doesn't compile
```

2 - New methods in collections
---------------------------------
With the Java 9 JDK, we will have more facilities to create already initialized collections. We can use the static `of()` method of `List`,` Set`, `Stream` or` Map`. Remember that these collections are immutable and if we try to do an `add` we will have an` UnsupportedOperationException`. An example of each can be:

```java
List<Integer> list = List.of(1, 2, 3);
Set<String> set = Set.of("a", "b", "c");
Stream<String> stream = Stream.of("a", "b", "c");
Map<String, String> map = Map.of("key 1", "value 1", "key 2",  "value 2");
```

On the other hand, with Java 10, the `copyOf()` methods have been introduced to create immutable copies of `List`,` Set` and `Map`. As with the `of()` method, we will get an `UnsupportedOperationException` if we try to add elements. Adding the code to the previous example we see how to make copies.

```java
List<Integer> listCopyOf = List.copyOf(list);
Set<String> setCopyOf = Set.copyOf(set);
Map<String, String> mapCopyOf = Map.copyOf(map)
```

3 - New methods in Streams
------------------------------
With Java 9, we can use the `takeWhile()`, `dropWhile()`, `iterate()` and `ofNullable()` methods on streams. The first two are used to remove or pick the first elements while a condition is met, the `iterate()` method generates an iteration of values ​​and `ofNullable()` method generates a `Stream` with an element if the element is not `null` or empty. 

```java
var list = List.of(4,6,7,8,9);
Stream<Integer> stream = list.stream().takeWhile(value -> value < 10);
stream.forEach(System.out::print);
System.out.println();
stream = list.stream().dropWhile(value -> value < 4);
stream.forEach(System.out::print);
//46789
//46789
```

4 - Terminal jshell command
-----------------------------
In Java 9 we have a new command available in our terminal, the `jshell` command. With this command we can directly test any java sentence through the console without the need for an IDE. 

```java
jshell> var map = Map.of("key",4,"key2",5)
map ==> {key2=5, key=4}

jshell> map.get("key")
$3 ==> 4

jshell> map.put("anotherKey", 9)
|  Exception java.lang.UnsupportedOperationException
|        at ImmutableCollections.uoe (ImmutableCollections.java:73)
|        at ImmutableCollections$AbstractImmutableMap.put (ImmutableCollections.java:866)
|        at (#4:1)
```
Notice the `UnsupportedOperationException` when we try to put a new entry in the `Map` created previously. Inmutability is great you should embrace it :-)

5 - Terminal Java command
----------------------------
In addition to the already included jshell, with Java 11, we can execute java files from the console. If we create the HelloWorld.java file.

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello world");
    }
}
```
With Java until now before executing a class with a `main` method we needed to compile the class with the `javac` command:  

```java
javac HelloWorld.java
```
and then:

```java
java HelloWorld
```

Now with the terminal we can skip the compiling step and execute directly with the `java` command:

```java
java HelloWorld.java
```
We will see at the exit through the terminal:

```java
Hello world
```

6 - New methods in String class
----------------------------

- New `repeat`,` strip`, `stripLeading`,` stripTrailing`, `isBlank` and `lines` methods in the `String` class. (Java 11)

```java
jshell> "Alex".repeat(3).equals("AlexAlexAlex")
$5 ==> true

jshell> " Alex ".strip().equals("Alex")
$6 ==> true

jshell> " Alex".stripLeading().equals("Alex")
$7 ==> true

jshell> "Alex ".stripTrailing().equals("Alex")
$8 ==> true

jshell> "".isBlank()
$9 ==> true

```

7 - New garbage collector
----------------------
On the other hand, with Java 11, a garbage collector that does not reclaim memory, the `Epsilon` garbage collector and experimentally the` ZGC` garbage collector is added.

8 - Reactive-streams
-----------------------
New classes `Flow.Processor`,` Flow.Subscriber`, `Flow.Publisher` and` Flow` that allow reactive publish-subscribe scheduling. You can read more in the `Flow` Javadoc <a href="https://docs.oracle.com/javase/9/docs/api/java/util/concurrent/Flow.html">page</a> (Java 9)

Conclusion
-----------------
In this post we have seen some of the available features for Java developers in Java 11. Are you still using Java 8? why not migrating? If you want to learn more about the new features available in Java 9 like Jigsaw or the new HttpClient read a previous <a href="{{ site.baseurl }}{% post_url 2020-08-28-what-is-new-in-java-9 %}">post</a> that I wrote some time ago.  
