---
layout: single
title: "Dealing with Maven in your Java project"
date: 2020-12-20 09:45:53 +0200
categories: development
comments: true
lang: en
tags: maven, java
image: images/apache_maven.png
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/apache_maven.png)
{: refdef}

In this blog post, we are going to talk about how to deal with Maven transitive dependencies and some other tips when you are using Maven in your Java project. 

Why using Maven in your Java project?
---------------------------------------
Maven is a build system to manage dependencies in your Java project that has also other interesting plugins that you can use in your project. 

It’s been around for more than <a href="https://maven.apache.org/background/history-of-maven.html#:~:text=History%20of%20Maven%20by%20Jason,sources%20happened%20in%20August%202001.">15 years</a> and it's not going away anytime soon. 

It became the de-facto standard for building Java projects, so a good strategy to became a productive Java developer would be to become familiar with it :-)

Transitive dependencies
-----------------------------
When you add a dependency in your project object model (POM) file, you are not only importing this dependency in your project. You are importing also the dependencies that this dependency needs to work. In the following example if we are importing dependency A, we are importing also dependency C.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/transitive_dependencies.png)
{: refdef}

There's no limit to the number of levels that you can have in your tree dependency. Because of that, the graph of included libraries can quickly grow quite large and we can have many levels of dependencies.

Cyclic dependencies
----------------------------
One problem that you might have is when a cyclic dependency is discovered. Maven does not allow cyclic dependencies between projects, because otherwise, it is not clear which project to build first. So you need to get rid of this cycle. 

In the following example we have `Entities` that depends on `Authorizer` that it's in another file, that depends on `Interactors` and this one dependends on `Entities`. 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/cycle_dependency.png)
{: refdef}

One way to break this cycle is to create an interface module and, an implementation module, which gets rid of most cycles (Review the concept of <a href="https://en.wikipedia.org/wiki/Dependency_inversion_principle">dependency inversion principle</a> if you are not familiar with it). 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/breaking_cycle_dependency.png)
{: refdef}

As you can see we have introduced the interface `Permissions` to break the cycle that we had in the first picture :-) 

Declare all the dependencies used 
----------------------------------
Including ONLY what you need in your project is a really good practice. You can take advantage of the maven dependency plugin, which has a goal called `analyze` that you can execute running the following command:

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
        <groupId>com.google.j2objc</groupId>
        <artifactId>j2objc-annotations</artifactId>
        <version>1.3</version>
    </dependency>
</dependencyManagement>
~~~

If you are relying on a transitive dependency in your project, if you update a dependency that removes the transitive dependency that you are using then your project will break.

> Declare all the dependencies that your project is using to avoid problems when updating your artifacts to newer versions.

Excluding dependencies
----------------------
In the previous paragraph, we talked about including what you want to use, but what if there's a dependency that you want to exclude? 

Unwanted dependencies included in your project can be excluded within the tags of dependency tag in an artifact in the POM file. In the following <a href="https://github.com/google/guava/blob/master/pom.xml">example</a> of Google Guava pom file, we can see the exclusion of an artifact when including the dependency of Google Truth.

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

On exclusion, the artifact will not be added to the final war/ear after the build process.

Dependency scopes
---------------------------
They are used to calculate the various classpaths used for compilation, testing, and so on.
They help to determine which artifacts to include in the distribution of the project. Each one of the scopes affects transitive dependencies in different ways: 
- Compile (default scope used, you need the jar to compile)
- Runtime (you don't need the jar to compile but yes in runtime)
- Provided (the JDK or the application server will provide the jar)
- Test (jar only for test)
- System (similar to provided but you have to provide explicitly the dependency)
- Import (only for dependencies of type pom)

More info about the different scopes can be found <a href="https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html#dependency-scope">here</a> 

A JAR is not being included
----------------------------
What if there's a particular jar that is not included in the war/ear file? Usually, the issue can be related to Dependency Scopes, i.e: the dependency is set as `provided` or `test` (In those cases the dependency is not included)

Another possibility is that as we explained before this dependency that is not included, might be excluded in some pom file (in case you are working in a multi-module project)

> That's why it's a good practice adding all the exclusions (or inclusions) and versions in the parent pom file using dependency management tags.

In those cases that the jar is not included, it may cause a `ClassNotFoundException` when you run the application because the class that is being used is not defined.

Dependency mediation
--------------------------------
In the case of a conflict, Maven uses the “nearest dependency” technique.
- Nearest dependency: means that the version used will be the closest one to your project in the tree of dependencies.
- If two dependency versions are at the same depth in the dependency tree, it's the order in the declaration that counts.
- You could explicitly add a dependency to Dv1 in A to force the use of Dv1… or just exclude Dv2.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/transitive_dependencies_1.png)
{: refdef}

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
In this post, we have seen some tips when we are working with Maven in our Java projects. Hope you know more about this important Java tool. If you want to read more about this topic I recommend you to check out the Apache Maven official page where you will find more <a href="https://maven.apache.org/articles.html">resources</a> 