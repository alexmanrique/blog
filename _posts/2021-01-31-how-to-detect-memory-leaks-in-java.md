---
layout: single
title: "How to detect and fix memory leaks in your Java application"
date: 2021-01-31 19:08:53 +0200
categories: development
comments: true
lang: en
tags: developer, leak, java, 2021
image: images/memory-leak.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/memory-leak.jpg)
{: refdef}

In this post we are going to talk about how to find memory leaks in Java and some strategies to fix them. 

You don’t look actively into memory leaks in your Java code if there are no symptoms that lead you to think that you have a memory leak. However, you have to be aware that:

> A small leak will sink a great ship
> ~ Benjamin Franklin

It’s a common unknown unknown between Java developers that are starting their career in software development. 

## 1. Memory leak symptoms

Some of the related symptoms to a memory leaks could be that: 
- your application is not behaving as expected 
- it stops without a particular reason
- you need to restart everyday this application cause the memory usage increases without limit. 
- you detect out-of-memory heap error in the logs.

## 2. Visualizing memory leaks when running the application

You should use a tool like VisualVM to visualize the memory usage of your application. You can download it from the following link <a href="https://visualvm.github.io/">https://visualvm.github.io/</a> 

Once you have downloaded it you can open the application and attach VisualVM to your application.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/visual-vm.png)
{: refdef}

Next step is to perform the operation that causes the bad performance. Inspect the Monitor and the visual gc tab. The objects leaked will be in the old gen pool.

In the next screenshot we can see the old gen memory thanks to the `visual-gc` plugin that we have to install using the plugins menu `Tools > Plugins`

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/visual-vm-visual-gc.png)
{: refdef}

In the next section we are going to see some of the common mistakes in code that can lead to a memory leak.

## 3. Common memory leak sources.

### 3.1. Connection not closed.

Opening a connection with the database from our backend code can cause a memory leak.

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
*Solution* : A way to solve this memory leak will be using the try with resources that closes the `PreparedStatement` 

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
Make sure to use properly code that has `Autoclosable` if you are using Java 7 or newer version of Java, opening the resource with the try catch with resources capability this way you will not need to close it explicitly.

### 3.2. A reference to an object is not released

In this particular case we have an static field that has a reference to an object that is using a lot of memory:

```java
private static final List<Double> list = new ArrayList<>(1000000);

@Test
public void memoryLeakWhenWeHaveLotsOfOperationsInAStaticField() throws InterruptedException {
    for (int i = 0; i < 1000000; i++) {
        list.add(Double.valueOf(i));
    }
    Thread.sleep(8000); // to allow GC do its job
}

```
*Solution* : Don't keep references to large objects into static fields unless they don't grow like in the previous example, otherwise it will cause an `OutOfMemoryError`.

### 3.3. Equals and hashcode are not implemented 

If we are using objects that don't have implemented the `equals` and `hashcode` and we had them into a `Set` it will grow, and it will ignore duplicates. We will not be able to remove these objects after adding them into this data structure. 

```java
public class MyObject{
   
   private final String field;
   
   public MyObject(String field){
       this.field = field; 
   }
   // equals and hashcode are not implemented
}

@Test(expected = OutOfMemoryError.class)
public void shouldThrowOutOfMemoryError(){
    Set<MyObject> set = new HashSet<>();
    while (true) {
        set.add(new MyObject("MyField"));
    }
}

```
*solution*: Implement `equals` and `hashcode` always, but especially if you are going to use them in a datastructure. You can use <a href="https://projectlombok.org/">Lombok</a> that has <a href="https://projectlombok.org/features/EqualsAndHashCode">EqualsAndHashCode</a> annotation that save you time writing those methods and reducing the boilerplate code.

### 3.4. Inner classes that reference outer classes can leak. 

Each instance of an anoymous inner class always keeps a reference to the outer class. This is not a problem unless: 

- you don’t keep a lot of data in the Outer instance or
- the lifetime of the Result object is short
- if you won’t create a lot of results anyways.

Let's see an example where we cause a memory leak. 

```java
interface MyInterface{}
class Outer {
    private final int[] data;
    public Outer(int size) { this.data = new int[size]; }
    MyInterface getResult() { return new MyInterface(){}; }
}

@Test(expected = OutOfMemoryError.class)
public void shouldThrowOutOfMemoryError() {
   List<MyInterface> list = new ArrayList<>();
   int i = 0;
   while(true){
       list.add(new Outer(10000).getResult());
       System.out.println(i++);
   }
}

```
*Solution*: If you don't need access to the Outer class make the inner class static to avoid this reference to the Outer class. On the other hand use a non-static nested class (or inner class) 

If you require access to an enclosing instance's fields but make sure that there are no references to the outer class neither the inner class to allow the GC to free the memory.

## Conclusion
That's it for now! we have seen what is a memory leak and some ways to generate and fix memory leaks in our Java application.


 

