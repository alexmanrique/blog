---
layout: single
title: "What was new in Java 9"
date: 2020-08-28 02:00:53 +0200
categories: development
comments: true
lang: en
tags: java9, jdk
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/java9.jpg)
{: refdef}


In this post, we are going to see the most relevant features for developers introduced in Java 9. The percentage of companies still using Java 8 is <a href="https://snyk.io/blog/jvm-ecosystem-report-2018/"> high </a> taking into account that this version was generally available on 21 September 2017. 

Note that this version is not a long term support version (LTS) and it's recommended to migrate to Java 11. However, features that we are covering in this post are in Java 11. 

In the following link you can see the complete list of features of <a href="https://openjdk.java.net/projects/jdk9/">Java 9</a>. 

1 - Jigsaw project - Modular system  
-------------------------------------------
The idea of this project is to provide an standard module system for the developers and for the platform itself. With this modularization, we can scale down our applications to use in small computing devices. JDK modules will be used according to the application needs. Also, new modules can be created by developers.  

Here is the simplest declaration of a module in Java 9:

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

2 - A new HTTP 2 client
---------------------------------------------------
If you are using Java 8 and you need to call an API you could use <a href="https://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html">`HttpURLConnection`</a> as explained in this <a href="https://stackoverflow.com/questions/2793150/how-to-use-java-net-urlconnection-to-fire-and-handle-http-requests">Stackoverflow thread</a> or using <a href="https://hc.apache.org/httpcomponents-client-ga/">Apache httpComponents</a>. The good news is that from Java 9 you can use an Http client without using any external library.

```java
import jdk.incubator.http.HttpClient;
import jdk.incubator.http.HttpRequest;
import jdk.incubator.http.HttpResponse;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

public class HttpClientExample {

    public static void main(String[] args) throws IOException, InterruptedException, URISyntaxException {

        HttpClient client = HttpClient.newBuilder()
                .version(HttpClient.Version.HTTP_1_1)
                .build();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI("http://postman-echo.com/get"))
                .GET()
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandler.asString());
        System.out.println(response.statusCode());
        System.out.println(response.body());
    }
}
```
In Java 9 these classes were in package `jdk.incubator.http` and you need to import the module `jdk.incubator.httpclient` otherwise, you received the following error:

```console
Error:(1, 21) java: package jdk.incubator.http is not visible
  (package jdk.incubator.http is declared in module jdk.incubator.httpclient, which is not in the module graph)
```

To avoid this error we need to execute the main adding to the VM option that we want to use the incubator module. We go to edit

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/intellij-edit-execution.png)
{: refdef}

And we add the following VM option:

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/intellij-add-vm-option.png)
{: refdef}



Since Java 11 you can find these classes in `java.net.http` package.

3 - Process API
---------------------------------------------------------
To manage and control the operating system processes this API has been improved. 

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

4 - Try-with-resources improvement
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

7 - JShell command-line tool
------------------------------------------------------------
In `<JAVA_HOME>/bin` we can find a new executable with the brand new JShell command-line tool. With this tool, we can read, evaluate, print, and loop (REPL). In the past, we had always need to create a main in a Java class. Now we can execute code snippets more easily.

```java
Welcome to JShell -- Version 9
For an introduction type: /help intro

jshell> "Hello Java 9"
$2 ==> "Hello Java 9"

jshell> $2.substring(1,4);
$3 ==> "ell"

jshell> $2.substring(1,8);
$4 ==> "ello Ja"
```

8 - Immutable set 
--------------------------------------

We have a new operation `Set.of` that creates in a single line of code an immutable `Set`. If we try to add something to this immutable `Set` we receive an `UnsupportedOperationException` exception.

```java
Set<String> set = Set.of("firstkey", "secondkey", "thirdkey");
```

9 - Optional to stream
-----------------------------

`java.util.Optional.stream()` allows using Streams on Optional elements:

```java
List<String> list = optionals.stream()
  .flatMap(Optional::stream)
  .collect(Collectors.toList());
```

10 - Unified JVM logging
-------------------------------

The goal of this improvement is to provide a unified logging system for all the componenents of the JVM .

When running our Java application if we add the new command line option `-Xlog` we will be able to use this new logging system.

i.e: 

```
-Xlog:gc=debug:file=gc.txt:none
    - log messages tagged with 'gc' tag using 'debug' level to
    a file called 'gc.txt' with no decorations
```

More information of this in <a href="https://openjdk.java.net/jeps/158">https://openjdk.java.net/jeps/158</a>


Conclusion
------------------------
Java 9 came in 2017 as a new version of the well known Java programming language with modular characteristics and new features for developers to write better software with less effort using better tools.