---
layout: single
title: "Increase coverage in your Java code"
date: 2020-04-26 22:00:53 +0200
categories: development
comments: true
lang: en
tags: increase coverage unit test 
---

In this post we are going to talk about code coverage in your Java code. It's important to have a high coverage but we have to consider other things a part from this metric.

![Code coverage API plugin jenkins]({{ site.baseurl }}/images/summary-chart.gif)
GIF source : <a href = "https://www.jenkins.io/blog/2018/08/17/code-coverage-api-plugin-1/"> Code coverage api plugin for jenkins</a>

Unit testing
-------------------
In software development when you are developing an application and you are using Java the first level of code protection is unit testing. I'm talking about code protection because unit testing is like a shield for your code. It protects the code to suffer modifications from future developers that don't know what your intentions were when you developed that piece of functionality. 

Unit tests avoid that your code breaks and stops doing what was doing initially. In java there are different libraries to do unit tests like <a href="https://junit.org/junit5/">junit</a> or <a href="https://testng.org/doc/">testng</a>. We have also <a href="https://github.com/mockito/mockito">mockito</a> to be able <a href="http://jmock.org/oopsla2004.pdf">mock</a> roles and <a href="https://github.com/powermock/powermock">powermockito</a> that allows you to do more things mockito doesn't allow you to do. 

Apart from unit testing there are other kinds of tests like integration tests, functional tests, stress tests, load tests but those types of testing are out of the scope of this post. 

All code has to be unit tested?
--------------------
There's code that is not worth it to test like Java <a href="https://en.wikipedia.org/wiki/Plain_old_Java_object">POJO</a>s. This kind of classes have only fields, getters, setters and constructor/s. We need to test how the different objects of our system interact between them and test behavoir rather than implementation. Unit testing a Java POJO is testing implementation rather than behavoir. 

It's more meaningful to test a `Controller` class that interacts with different services and that has some logic related with your algorithm than testing Java POJO's.

If you do a test for a class of your model because your objective is to increase the coverage of your code is better that you invest this time in testing the core parts of your application. 
  
More tests mean more quality?
--------------------
Having more tests doesn't mean more quality. Tests are code and they have to be mantainable and they have to have a purpose. The same concept of single responsability principle applies to a test method. It has to test one thing and do it well. 

You can have 90% of code coverage and your tests are difficult to read and they are brittle. If you have to do a change in your codebase and you have to change all the unit tests it means that something is wrong with your code. 

> Do meaningful tests easy to read, that have a purpose and that test behavoir and not implementation

If your code has no tests it's a very bad sign because you don't have any guarantee that if you change some part of the code you will not break anything. 

Reading the tests you should understand what is doing your application
--------------------------------------------------
If you remove all the code and you only keep tests you should be able to rewrite all the application from scratch. This is what we should strive for when we write unit tests when we are developing. 

> The next developer that will read your code should understand you application reading your tests. 

As a rule of thumb you should have a low number of asserts per test. I'm not saying one single assert per test because sometimes is not possible, but if you have a lot of asserts is becuase your test is validating more than one thing at the same time.   


Test driven development
--------------------
This technique is key when you are developing. First you write a test that fails, then you write the code to make that test pass, and you do it in an iterative way. 

Sometimes we can be pressured to rush because of a deadline in our project, but our job is to do things with quality and thinking about how to test the code that you are going to write is a good starting point. 

Introducing a unit test in some legacy code can be challenging because there is no structure, the code is not <a href="http://www.catb.org/~esr/writings/taoup/html/ch04s02.html#orthogonality">orthogonal</a> - two or more things are orthogonal if changes in one do not affect any of the others- but the effort is worth it. 


JaCoCo Java code coverage library
----------------------
<a href="https://www.jacoco.org/jacoco/index.html">Jacoco</a> is a free code coverage library that allows you to set the thresholds of code coverage for your Java project. You can define the percentage code coverage per line of code or per branches. Once you set the threshold you (and your team) should always strive for increasing this coverage rather than decreasing it. 

You can have a <a href="https://maven.apache.org/guides/introduction/introduction-to-profiles.html">maven profile</a> that as one of the possible code checks can run jacoco checks, this way every time that you run this maven profile you can check that the coverage expected has been met. 

You should have the coverage threshold to the level that your code is covering this way when you create a new Java class you will be forced to create a new unit test to avoid failing the Jacoco rule previously set. If you delete some class because you are doing some refactor or you add more tests to classes that were not covered you will be able to increase the coverage of the project. 

In the following lines we can see how to set a maven profile in our java project with the jacoco plugin to force at least 60% of coverage.

```xml
<profile>
<id>run-code-checks</id>
<build>
<plugins>
<plugin>
 <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.2</version>
    <executions>
        <execution>
            <id>prepare-agent</id>
            <goals>
                <goal>prepare-agent</goal>
            </goals>
        </execution>
        <execution>
            <id>check</id>
            <goals>
                <goal>check</goal>
            </goals>
            <configuration>
                <haltOnFailure>true</haltOnFailure>
                <rules>
                    <rule>
                        <element>BUNDLE</element>
                        <limits>
                            <limit>
                                <counter>LINE</counter>
                                <value>COVEREDRATIO</value>
                                <minimum>0.6</minimum>
                            </limit>
                            <limit>
                                <counter>BRANCH</counter>
                                <value>COVEREDRATIO</value>
                                <minimum>0.6</minimum>
                            </limit>
                        </limits>
                    </rule>
                    <rule>
                        <element>PACKAGE</element>
                        <limits>
                            <limit>
                                <counter>LINE</counter>
                                <value>COVEREDRATIO</value>
                                <minimum>0.6</minimum>
                            </limit>
                            <limit>
                                <counter>BRANCH</counter>
                                <value>COVEREDRATIO</value>
                                <minimum>0.6</minimum>
                            </limit>
                        </limits>
                    </rule>
                </rules>
            </configuration>
        </execution>
        <execution>
            <id>report</id>
            <phase>prepare-package</phase>
            <goals>
                <goal>report</goal>
            </goals>
        </execution>
    </executions>
</plugin>
</plugins>

```

Conclusion
------------------------
We have seen in this post the importance of unit testing our code, different concepts related with the code coverage and how to introduce a plugin in our java project called Jacoco to be able to force a threshold of code coverage in our code. I would recommend you if you are interested in this topic that you read <a href="https://www.amazon.es/gp/product/0321503627/ref=as_li_tl?ie=UTF8&camp=3638&creative=24630&creativeASIN=0321503627&linkCode=as2&tag=almanbl01-21&linkId=ec276f2f1f676815f2ef4b92501b557b">Growing object oriented software guided by tests</a> if you want to go deeper into this topic.


