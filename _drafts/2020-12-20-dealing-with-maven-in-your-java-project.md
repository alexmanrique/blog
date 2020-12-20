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
Maven is a build system to manage dependencies in your Java project that has also other interesting plugins that you can use in your project. It’s been around for more than <a href="https://maven.apache.org/background/history-of-maven.html#:~:text=History%20of%20Maven%20by%20Jason,sources%20happened%20in%20August%202001.">15 years</a> and it's not going away anytime soon. It became the de-facto standard for building Java projects, so a good strategy to became a productive Java developer would be to embrace it :-)

Transitive dependencies
---------------------------------
When you add a dependency in your POM file 
- Discover libraries that your own dependencies require
- No limit to the number of levels
- The graph of included libraries can quickly grow quite large
- May cause a problems if a cyclic dependency is discovered

Why is this Jar in my build ?
---------------------------------------
- Include ONLY what you need!
- Use mvn dependency:analyze
- Add used dependencies
- Some trial and error involved

Dependency exclusions
------------------------------
- Unwanted dependencies included in your project
- Exclude specific dependencies
- On exclusion the artifact will not be added to your project

A JAR is not being included
-----------------------------------
- Usually related with Dependency Scopes
- Might also be excluded somewhere
- May cause ClassNotFoundException

- Use mvn dependency:list
- Use mvn dependency:tree
- Change dependencies to use the appropriate scope

Managing dependencies
---------------------------------
- Many dependencies to manage
- Number of dependencies only increases over time
- Combine the power of project inheritance with specific
dependency management elements in the POM
- Manage, or align, versions of dependencies across
several projects

In the case of a conflict, Maven uses the “nearest dependency” technique.

Dependency mediation
--------------------------------
- Nearest Definition: means that the version used will be the
closest one to your project in the tree of dependencies.
- If two dependency versions are at the same depth in the
dependency tree, it's the order in the declaration that
counts.
- You could explicitly add a dependency to D1 in A to force
the use of D1… or just exclude D2.

I can't find the Artifact
-------------------------------
- Artifacts get renamed all the time
- The artifact might be in another remote repo
- POM parent might not be the latest

Debug commands
----------------------
- mvn help:effective-pom
- mvn help:effective-settings
- mvn -Dmaven.repo.local=/temp/.m2
- mvn versions:display-dependency-updates

Conclusion
--------------
In this post we have seen how to create a serializer and a deserializer in Java using the Jackson library. We have seen also that there are alternatives out there for serialization purposes. 

