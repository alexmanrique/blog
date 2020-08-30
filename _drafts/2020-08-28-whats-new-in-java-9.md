---
layout: single
title: "What's new in Java 9"
date: 2020-08-28 02:00:53 +0200
categories: development
comments: true
lang: en
tags: java9, jdk
---

In this post we are going to see the most relevant features for developers introduced in Java 9. The percentage of companies still using Java 8 is really  <a href="https://snyk.io/blog/jvm-ecosystem-report-2018/"> high </a> taking into account that this version was generaly available on 21 September 2017. 

Note that this version is not a long term support version (LTS) and it's recommended to migrate to Java 11. However, features that we are covering in this post are in Java 11. 

In the following link you can see the complete list of features of <a href="https://openjdk.java.net/projects/jdk9/">Java 9</a>. 

1 - Jigsaw project - Modular system  
-------------------------------------------
The basic idea of this project is to allow developers to maintain libraries and large applications. With this modularization we can scale down our applications to use in small computing devices, because applications will use only the needed modules. 

Here is the simplest declaration of a module in Java 9

```java
module com.foo.bar { }
```

In the following declaration we declare that `org.baz.qux` module is required by `com.foo.bar`
```java
module com.foo.bar {
    requires org.baz.qux;
}
```

More info can be found in this <a href="https://openjdk.java.net/projects/jigsaw/quick-start">jigsaw quickstart</a> project.

2 - Http 2 client
---------------------------------------------------
If you are using Java 8 and you need to call an api you could use `HttpURLConnection` class or use <a href="https://hc.apache.org/httpcomponents-client-ga/">Apache httpComponents</a>. The good news is that from Java 9 you can use a Http client without using any external library.

```java
import java.io.IOException;

import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class HttpClientExample {

    public static void main(String[] args) throws IOException, InterruptedException, URISyntaxException {

        HttpClient client = HttpClient.newBuilder()
                .version(HttpClient.Version.HTTP_1_1)
                .build();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI("https://www.coinspot.com.au/pubapi/latest"))
                .GET()
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        System.out.println(response.statusCode());
        System.out.println(response.body());
    }
}
```
Since Java 11 you can find these classes in `java.net.http` package. In Java 9 these classes were in package `jdk.incubator.http` and you need to import the module `jdk.incubator.httpclient`otherwise you received the following error:

```console
Error:(1, 21) java: package jdk.incubator.http is not visible
  (package jdk.incubator.http is declared in module jdk.incubator.httpclient, which is not in the module graph)
```

3 - Process API
---------------------------------------------------------
To manage and control operating system processes this api has been improved. 

```java

public class ProcessAPIExample {

    public static void main(String[] args) {

        ProcessHandle process = ProcessHandle.current();
        System.out.println(process.isAlive());
        System.out.println(process.info().user().isPresent() ? process.info().user().get() : null);
        System.out.println(process.info().totalCpuDuration().isPresent() ? process.info().totalCpuDuration().get() : null);
    }

}
```

All these classes are in `java.lang` that's why you don't see any import in the previous class.s

4 - Try with resources improvement
---------------------------------------------------
In Java 7 we needed to declare a variable for each resource managed by the statement. In Java 9 if the variable is final or effectively final variable we don't need to create a new variable.

```java
BestAutoCloseable bac = new BestAutoCloseable();
try (bac) {
    // do some stuff with bac
}
 
try (new BestAutoCloseable() { }.finalWrapper.finalCloseable) {
   // do some stuff with finalCloseable
} catch (Exception ex) { }

```

5 - Diamond operation extension
--------------------------------------------------
We can create anonymous classes with diamond operator 

```java

FooClass<?> fc1 = new FooClass<>(1) { 
    // anonymous inner class
};

```


6 - Private methods in interfaces
------------------------------------------------------------------ 
This can be used to split default long methods that we have in an interface.

```java
interface InterfaceWithPrivateMethods {
    
    default void execute() {
        String result = aStaticPrivateMethod();
        InterfaceWithPrivateMethods pvt = new InterfaceWithPrivateMethods() {
            // anonymous class
        };
        result = pvt.anInstancePrivateMethod();
    }

    private static String aStaticPrivateMethod() {
        return "static private";
    }
    
    private String anInstancePrivateMethod() {
        return "instance private";
    }
}}

```

7 - JShell command line tool
------------------------------------------------------------
In `<JAVA_HOME>/bin`we can find a new executable with the brand new JShell command line tool. With this tool we can read, evaluate, print, and loop (REPL)


Conclusion
------------------------





