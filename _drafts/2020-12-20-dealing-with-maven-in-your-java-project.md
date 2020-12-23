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
---------------------------------
When you add a dependency in your project object model (POM) file, you are not only importing this dependency in your project. You are importing also the dependencies that this dependency needs to work. 

There's no limit to the number of levels that you can have in your tree dependency. Because of that the graph of included libraries can quickly grow quite large and we can have many levels of dependencies.

One problem that you might have is when a cyclic dependency is discovered.

Why is this Jar in my build?
---------------------------------------
Including ONLY what you need in your project is a really good practice. You can take advantage of the maven dependency plugin, that has a goal called analyze that you can execute running the following command:

~~~ java
$> mvn dependency:analyze
~~~

Running the previous command in google guava library we got some warnings:

```java
[INFO] --- maven-dependency-plugin:3.1.1:analyze (default-cli) @ guava-testlib ---
[WARNING] Unused declared dependencies found:
[WARNING]    com.google.j2objc:j2objc-annotations:jar:1.3:compile
```

To achieve the goal of adding the missing dependencies you can use dependency management to declare which dependencies your project is using. 

Some trial and error will be involved in this process because is possible that you import the wrong dependency or you get a dependency conflict at the time of declaring which dependencies you are using in your Java project.

Dependency exclusions
------------------------------
In the previous paragraph we talked about including what you want to use, but what if there's a dependency that we want to exclude from our dependencies? 

Unwanted dependencies included in your project can be excluded within the tags of dependency tag in an artifact in the POM file. In the following <a href="https://github.com/google/guava/blob/master/pom.xml">example</a> of Google Guava pom file we can see the exclusion of an artifact when including the dependency of Google Truth.

```java
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
```

On exclusion the artifact will not be added to your project.

A JAR is not being included
-----------------------------------
What if there's a particular jar that is not included? Usually the issue can be related with Dependency Scopes, i.e: the dependency is set as provided or test. In those cases the dependency is not included.
Might be excluded in some pom file. 

Maybe you are dealing with a multimodule project, with multiple pom files and some of them has excluded the dependency. 

> That's why it's a good practise add all the exclusions and versions in the parent pom file using dependency management tags.

In those cases that the jar is not included it may cause a `ClassNotFoundException` when you run the application.

Some useful commands to address the situation are the following:

~~~ java
$> mvn dependency:list
~~~
~~~ java
$> mvn dependency:tree
~~~

- Change dependencies to use the appropriate scope

Dependency mediation
--------------------------------
In the case of a conflict, Maven uses the “nearest dependency” technique.
- Nearest Definition: means that the version used will be the closest one to your project in the tree of dependencies.
- If two dependency versions are at the same depth in the dependency tree, it's the order in the declaration that counts.
- You could explicitly add a dependency to D1 in A to force the use of D1… or just exclude D2.

I can't find the Artifact
-------------------------------
- Artifacts get renamed all the time
- The artifact might be in another remote repo
- POM parent might not be the latest

Debug commands
----------------------
Some useful commands that you can use to debug problems are the following:

~~~ java
mvn help:effective-pom
~~~
~~~ java
mvn help:effective-settings
~~~
~~~ java
mvn -Dmaven.repo.local=/temp/.m2
~~~
~~~ java
mvn versions:display-dependency-updates
~~~

Conclusion
--------------
In this post we have seen some usefull tips when we are working with Maven in our Java project.

