---
layout: single
title: "Dealing with Maven in your Java project"
date: 2020-12-20 09:45:53 +0200
categories: development
comments: true
lang: en
tags: maven, java
image: images/serialization-in-java.png
---

In this blog post we are going to talk about how to deal with Maven transitive dependencies and some other tips when you are using Maven in your Java project. 

Why using Maven in your Java project?
---------------------------------------
Maven is a build system to manage dependencies in your Java project that has also other interesting plugins that you can use in your project. 

It’s been around for more than <a href="https://maven.apache.org/background/history-of-maven.html#:~:text=History%20of%20Maven%20by%20Jason,sources%20happened%20in%20August%202001.">15 years</a> and it's not going away anytime soon. 

It became the de-facto standard for building Java projects, so a good strategy to became a productive Java developer would be to embrace it :-)

Transitive dependencies
-----------------------------
When you add a dependency in your project object model (POM) file, you are not only importing this dependency in your project. You are importing also the dependencies that this dependency needs to work. 

There's no limit to the number of levels that you can have in your tree dependency. Because of that, the graph of included libraries can quickly grow quite large and we can have many levels of dependencies.

Cyclic dependencies
----------------------------
One problem that you might have is when a cyclic dependency is discovered. Maven does not allow cyclic dependencies between projects, because otherwise it is not clear which project to build first. So you need to get rid of this cycle. 

One thing to break this cycle is to create an interface module and, an implementation module, which gets rid of most cycles (Review the concept of <a href="https://en.wikipedia.org/wiki/Dependency_inversion_principle">dependency inversion principle</a> if you are not familiar with it). 

Declare all the dependencies used 
----------------------------------
Including ONLY what you need in your project is a really good practice. You can take advantage of the maven dependency plugin, that has a goal called analyze that you can execute running the following command:

~~~ java
$> mvn dependency:analyze
~~~

Running the previous command in <a href="https://github.com/google/guava">Google guava library</a> we got some warnings because there are dependencies that are used in the project that are undeclared in the project:

```java
[INFO] --- maven-dependency-plugin:3.1.1:analyze (default-cli) @ guava-testlib ---
[WARNING] Unused declared dependencies found:
[WARNING]    com.google.j2objc:j2objc-annotations:jar:1.3:compile
```

To achieve the goal of adding the missing dependencies you can use dependency management to declare which dependencies your project is using.

~~~ java
<dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>com.google.code.findbugs</groupId>
        <artifactId>jsr305</artifactId>
        <version>3.0.2</version>
    </dependency>
    <dependency>
        <groupId>org.checkerframework</groupId>
        <artifactId>checker-qual</artifactId>
        <version>3.8.0</version>
    </dependency>
    <dependency>
        <groupId>com.google.errorprone</groupId>
        <artifactId>error_prone_annotations</artifactId>
        <version>2.4.0</version>
    </dependency>
</dependencyManagement>
~~~

> If you are relying on a transitive dependency in your project, if you update a dependency that removes the transitive dependency that you are using then your project will break.

Excluding dependencies
----------------------
In the previous paragraph we talked about including what you want to use, but what if there's a dependency that we want to exclude from our dependencies? 

Unwanted dependencies included in your project can be excluded within the tags of dependency tag in an artifact in the POM file. In the following <a href="https://github.com/google/guava/blob/master/pom.xml">example</a> of Google Guava pom file we can see the exclusion of an artifact when including the dependency of Google Truth.

~~~ java
<dependency>
    <groupId>com.google.truth</groupId>
    <artifactId>truth</artifactId>
    <version>${truth.version}</version>
    <scope>test</scope>
    <exclusions>
        <exclusion>
            <!-- use the guava we're building. -->
            <groupId>com.google.guava</groupId>
            <artifactId>guava</artifactId>
        </exclusion>
    </exclusions>
</dependency>
~~~

On exclusion the artifact will not be added to the final war/ear after the build process.

Dependency scopes
---------------------------
They are used to calculate the various classpaths used for compilation, testing, and so on.
They help determining which artifacts to include in a distribution of the project. Each one of the scopes affects transitive dependencies in different ways: 
- Compile (default scope used, you need the jar to compile)
- Runtime (you don't need the jar to compile but yes in runtime)
- Provided (the JDK or the application server will provide the jar)
- Test (jar only for test)
- System (similar to provided but you have to provide explicitly the dependency)
- Import (only for dependencies of type pom)

More info about the different scopes you can find <a href="https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html#dependency-scope">here</a> 

A JAR is not being included
----------------------------
What if there's a particular jar that is not included in the war/ear file? Usually the issue can be related with Dependency Scopes, i.e: the dependency is set as `provided` or `test` (In those cases the dependency is not included)

Another possibility is that as we explained before this dependency that is not included, might be excluded in some pom file (in case you are working in a multi-module project)

> That's why it's a good practise adding all the exclusions (or inclusions) and versions in the parent pom file using dependency management tags.

In those cases that the jar is not included it may cause a `ClassNotFoundException` when you run the application, because the class that is being used is not defined.

Dependency mediation
--------------------------------
In the case of a conflict, Maven uses the “nearest dependency” technique.
- Nearest Definition: means that the version used will be the closest one to your project in the tree of dependencies.
- If two dependency versions are at the same depth in the dependency tree, it's the order in the declaration that counts.
- You could explicitly add a dependency to D1 in A to force the use of D1… or just exclude D2.

Debug commands
----------------------
Some useful commands that you can use to debug problems are the following:

~~~ java
$> mvn dependency:list
~~~
~~~ java
$> mvn dependency:tree
~~~
~~~ java
$> mvn help:effective-pom
~~~
~~~ java
$> mvn help:effective-settings
~~~
~~~ java
$> mvn -Dmaven.repo.local=/temp/.m2
~~~
~~~ java
$> mvn versions:display-dependency-updates
~~~

Conclusion
--------------
In this post we have seen some usefull tips when we are working with Maven in our Java project.

