---
layout: single
title: "Java 21 features"
date: 2024-01-06 09:08:53 +0200
categories: development
comments: true
lang: en
tags: slack
image: images/java21.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/java21.jpg)
{: refdef}
{:refdef: style="text-align: center;font-size:9px"}


Foto de <a href="https://unsplash.com/es/@merlenegoulet?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Merlene Goulet</a> en <a href="https://unsplash.com/es/fotos/taza-de-ceramica-blanca-en-la-parte-superior-del-platillo-de-ceramica-blanca-rodeado-de-granos-de-cafe-ISFopTz7sBo?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
{: refdef}

Java latest version was released on 19 September 2023 and it has been some time since this new <a href="https://www.oracle.com/es/java/technologies/java-se-support-roadmap.html">LTS</a> was made available in production. 

In this blog post, we are going to talk about which are the new features of this new Java JDK. 

There are features that are in <a href="https://openjdk.org/jeps/12">preview</a> status in this Java JDK release and are not permanent, waiting for developer feedback in real-world usage. If you want to use them you need to do the following:

Compile your app:
```
$> javac --release 21 --enable-preview MyApp.java
```

Run it:
``` 
java --enable-preview MyApp
``` 

## 1 - String Templates (Preview)

Syntactically, a template expression resembles a string literal with a prefix. There is a template expression on the second line of this code:

```java
String name = "Alex";
String info = STR."My name is \{name}";
assert info.equals("My name is Alex");   // true
```

The template expression `STR."My name is \{name}"` consists of:

- A template processor (STR);
- A dot character (U+002E), as seen in other kinds of expressions;
- A template `("My name is \{name}")` which contains an embedded expression `(\{name})``.

More info of this feature in this <a href="https://openjdk.org/jeps/430">link</a>


## 2 - Sequenced Collections

A SequencedCollection is a Collection whose elements have a defined encounter order. This type of collection has first and last elements, and the elements between them have successors and predecessors. 

A <a href="https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/SequencedCollection.html">SequencedCollection</a> supports common operations at either end, and it supports processing the elements from first to last and from last to first (i.e., forward and reverse).  

```java
interface SequencedCollection<E> extends Collection<E> {
   // new method
   SequencedCollection<E> reversed();
   // methods promoted from Deque
   void addFirst(E);
   void addLast(E);
   E getFirst();
   E getLast();
   E removeFirst();
   E removeLast();
}
```

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/SequencedCollectionDiagram.png)
{: refdef}
{:refdef: style="text-align: center;font-size:9px"}

From the previous picture we can see the following points:

- `List` now has SequencedCollection as its immediate superinterface,
- `Deque` now has SequencedCollection as its immediate superinterface,
- `LinkedHashSet` additionally implements <a href="https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/SequencedSet.html">SequencedSet</a>,
- `SortedSet` now has SequencedSet as its immediate superinterface,
- `LinkedHashMap` additionally implements <a href="https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/SequencedMap.html">SequencedMap</a>, and
- `SortedMap` now has SequencedMap as its immediate superinterface


Foto de <a href="https://unsplash.com/es/@merlenegoulet?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Merlene Goulet</a> en <a href="https://unsplash.com/es/fotos/taza-de-ceramica-blanca-en-la-parte-superior-del-platillo-de-ceramica-blanca-rodeado-de-granos-de-cafe-ISFopTz7sBo?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
{: refdef}

More info of this feature in this <a href="https://openjdk.org/jeps/431">link</a>

## 3 - Generational ZGC

The purpose of this feature is to improve application performance by extending the Z Garbage Collector (ZGC) to maintain separate generations for young and old objects. This will allow ZGC to collect young objects — which tend to die young — more frequently.

More info of this feature in this <a href="https://openjdk.org/jeps/439">link</a>

## 4 - Record Patterns

First, we need to recall the concept of <a href="https://openjdk.org/jeps/395">`Record`</a> which are classes that act as transparent carriers for immutable data.  

In the following code, it would be better if the pattern could not only test whether a value is an instance of `Point` but also extract the x and y components from the value directly, invoking the accessor methods on our behalf.

```java
// As of Java 16

record Point(int x, int y) {}

static void printSum(Object obj) {
   if (obj instanceof Point p) {
       int x = p.x();
       int y = p.y();
       System.out.println(x+y);
   }
}
```
Let's see how this has been improved in Java 21:


```java
// As of Java 21

static void printSum(Object obj) {
   if (obj instanceof Point(int x, int y)) {
       System.out.println(x+y);
   }
}
```
`Point(int x, int y)` is a record pattern. It lifts the declaration of local variables for extracted components into the pattern itself and initializes those variables by invoking the accessor methods when a value is matched against the pattern

More info of this feature in this <a href="https://openjdk.org/jeps/440">link</a>

## 5 - Pattern Matching for switch (Fourth preview)

This feature is related to improving pattern matching for switch expressions and statements. Let's check the following code:

```java

// Prior to Java 21
static String formatter(Object obj) {
    String formatted = "unknown";
    if (obj instanceof Integer i) {
        formatted = String.format("int %d", i);
    } else if (obj instanceof Long l) {
        formatted = String.format("long %d", l);
    } else if (obj instanceof Double d) {
        formatted = String.format("double %f", d);
    } else if (obj instanceof String s) {
        formatted = String.format("String %s", s);
    }
    return formatted;
}

// As of Java 21
static String formatterPatternSwitch(Object obj) {
    return switch (obj) {
        case Integer i -> String.format("int %d", i);
        case Long l    -> String.format("long %d", l);
        case Double d  -> String.format("double %f", d);
        case String s  -> String.format("String %s", s);
        default        -> obj.toString();
    };
}
```
A case label with a pattern applies if the value of the selector expression obj matches the pattern.
The intent of this code is clearer because we are using the right control construct: We are saying, "the parameter obj matches at most one of the following conditions, figure it out and evaluate the corresponding arm."

More info of this feature in this <a href="https://openjdk.org/jeps/433">link</a>

## 6 - Foreign Function & Memory API (Third Preview)

With this feature the idea is to have an API to interoperate with code and data on the same machine as the JVM, but outside the Java runtime. This API will allow Java programs to interoperate with code and data outside of the Java runtime.

Invoking foreign functions (i.e., code outside the JVM), and by safely accessing foreign memory (i.e., memory not managed by the JVM), the API enables Java programs to call native libraries and process native data without the brittleness and danger of JNI (Java Native interface)

More info about this new Java 21 feature can be found <a href="https://openjdk.org/jeps/442">here</a>

## 7 - Unnamed Patterns and Variables (Preview)

In the following code we are using `Record pattern` feature previously described, but note that we are not using `Color` inside the if expression.

```java
if (r instanceof ColoredPoint(Point p, Color c)) {
    ... p.x() ... p.y() ...
}
```
with unnamed patterns we could do something like the following code snippet. Note the underscore that we are using for `Color c`

```java
if (r instanceof ColoredPoint(Point(int x, int y), _)) { ... x ... y ... }

```

In the following example, the `order` variable is not used:

```java
int total = 0;
for (Order order : orders) {
    if (total < LIMIT) { 
        ... total++ ...
    }
}
```

The corresponding unnamed variable would be with `_`

```java
int acc = 0;
for (Order _ : orders) {
    if (acc < LIMIT) { 
        ... acc++ ...
    }
}

```

More info of this feature in this <a href="https://openjdk.org/jeps/443">link</a>

## 8 - Virtual Threads

This might be the most interesting feature of this JDK release.  Until now the number of available threads is limited because the JDK implements threads as wrappers around operating system (OS) threads.

OS threads are costly, so we cannot have too many of them. Threads until now have become the limiting factor long before other resources, such as CPU or network connections, are
exhausted.

Now is possible with virtual threads to scale with near-optimal hardware utilization.

Virtual threads are simply threads that are cheap to create and almost infinitely plentiful. Hardware utilization is close to optimal, allowing a high level of concurrency and, as a result, high throughput.

```java
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
   IntStream.range(0, 10_000).forEach(i -> {
       executor.submit(() -> {
           Thread.sleep(Duration.ofSeconds(1));
           return i;
       });
   });
}  // executor.close() is called implicitly, and waits
```

More info in the following <a href="https://openjdk.org/jeps/444">link</a>

## 9 - Unnamed Classes and Instance Main Methods (Preview)

The idea of this feature is that students can write their first programs without needing to understand language features designed for large programs. When you create your first Java program you need to obviate some concepts like `class`, `static`, or the `String []`. With this preview feature instead of doing this code: 

```java
public class HelloWorld {
   public static void main(String[] args) {
       System.out.println("Hello, World!");
   }
}
```
Students will write the following code: 

```java
void main() {
   System.out.println("Hello, World!");
}
```

More info in the following <a href="https://openjdk.org/jeps/445">link</a>

## 10 - Scoped Values (Preview)

<a href="https://docs.oracle.com/javase%2F7%2Fdocs%2Fapi%2F%2F/java/lang/ThreadLocal.html">Thread-local</a> variables have more complexity than is usually needed for sharing data, and significant costs that cannot be avoided.

The idea behind scoped values is to maintain inheritable per-thread data for thousands or millions of virtual threads.

These per-thread variables are immutable, their data can be shared by child threads efficiently.

Further, the lifetime of these per-thread variables will be bounded: Any data shared via a per-thread variable will become unusable once the method that initially shared the data is finished.


```java
private static final ScopedValue<String> X = ScopedValue.newInstance();

void foo() {
   ScopedValue.where(X, "hello").run(() -> bar());
}

void bar() {
   System.out.println(X.get()); // prints hello
   ScopedValue.where(X, "goodbye").run(() -> baz());
   System.out.println(X.get()); // prints hello
}

void baz() {
   System.out.println(X.get()); // prints goodbye
}
```
More info in this <a href="https://openjdk.org/jeps/446">link</a>


## 11 - Vector API (Sixth Incubator)

With this feature, the intention is to introduce an <a href="https://docs.oracle.com/en/java/javase/21/docs/api/jdk.incubator.vector/jdk/incubator/vector/Vector.html">API</a> to express vector computations that reliably compile at runtime to optimal vector instructions on supported CPU architectures, thus achieving performance superior to equivalent scalar computations.

More info in this <a href="https://openjdk.org/jeps/448">link</a>

## 12 - Deprecate the Windows 32-bit x86 Port for Removal

Windows 10, the last Windows operating system to support 32-bit operation, will reach End of Life in <a href="https://learn.microsoft.com/es-es/lifecycle/products/windows-10-home-and-pro">October 2025</a> the idea is to deprecate the Windows 32-bit x86 port, with the intent to remove it in a future release.

More info in this <a href="https://openjdk.org/jeps/449">link</a>

## 13 - Prepare to Disallow the Dynamic Loading of Agents

An agent is a component that can alter the code of an application while the application is running. Agents were introduced by the <a href="https://jcp.org/en/jsr/detail?id=163">Java Platform Profiling Architecture</a> in JDK 5 as a way for tools, notably profilers, to instrument classes. If the agents are loaded at startup will not cause warnings as if they were loaded into a running JVM.
All this in order <a href="https://openjdk.org/jeps/8305968">to improve integrity by default.</a>

More info in this <a href="https://openjdk.org/jeps/451">link</a>

## 14 - Key Encapsulation Mechanism API

KEMs will be an important tool for defending against quantum attacks. None of the existing cryptographic APIs in the Java Platform is capable of representing KEMs naturally. 

Implementors of third-party security providers have already expressed a need for a standard KEM API. 

With this new Java JDK we will be able to use an API for key encapsulation mechanisms (KEMs), an encryption technique for securing symmetric keys using public key cryptography.

More info in this <a href="https://openjdk.org/jeps/452">link</a>

## 15 - Structured Concurrency (Preview)

Simplify concurrent programming by introducing an API for structured concurrency. Structured concurrency treats groups of related tasks running in different threads as a single unit of work, thereby streamlining error handling and cancellation, improving reliability, and enhancing observability.

More info in this <a href="https://openjdk.org/jeps/453">link</a>

**Conclusion:**

In this post we have seen a short explanation of each one of the new Java 21 features. Which is the feature that surprised you more? are you planning to migrate to Java 21? 
