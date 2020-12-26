---
layout: single
title: "How to use Java in Macbook air M1"
date: 2020-12-26 09:45:53 +0200
categories: development
comments: true
lang: en
tags: mac, apple, m1, java
image: images/apache_maven.png
---

In this post we are going to see how to use Java in a Macbook M1 with the new Apple processors.

Options to install Java
--------------------------
https://www.azul.com/downloads/zulu-community/?os=macos&architecture=arm-64-bit&package=jdk

https://github.com/microsoft/openjdk-aarch64/releases/tag/16-ea%2B10-macos

Add Java home to the JAVA_HOME environment variable
-----------------------------------------------------
Content of the file .zhsrc

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home/jre

Installing Maven
----------------------------
To install maven in your Macbook Air sillicon

export PATH=/opt/apache-maven-3.6.3/bin:$PATH

https://stackoverflow.com/questions/64788005/java-jdk-for-apple-m1-chip

MacOs M1 vs Windows 10 Intel i7 vs MacOs Intel i5 2011 
--------------------------------------------------------

Ejecución en MacOs 2011 con Intel i5

In 9,8 seconds the spring-boot application starts

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-mac-2011-intel-i5.png)
{: refdef}

In the new Macbook AIR the spring-boot application starts in 3,97 seconds using azul jdk 8

Ejecución en Windows con Intel i7

Conclusion
--------------
