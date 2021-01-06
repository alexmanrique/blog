---
layout: single
title: "First steps using Java in Macbook Air M1"
date: 2021-01-05 09:45:53 +0200
categories: development
comments: true
lang: en
tags: mac, apple, m1, java
image: images/m1-java.png
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/m1-java.png)
{: refdef}

In this post we are going to see how to use Java in a Macbook M1 with the new Apple processors. *Disclaimer*: This post has been written in early 2021, so all this maybe has changed at the time you are reading this.

Intel(x86) to ARM transition 
-------------------------------------------
Apple has replaced Intel x86 for the ARM-based processor chips in their new Macbooks released in late 2020. ARM has been used by Apple and Android manufacturers in their phone devices whereas Intel has been used mainly in computers. 

Intel processors use complex instruction set computing (CISC) while ARM uses reduced instruction set computing (RISC) which leads to ARM processors to execute instructions in one cycle and Intel processors to need several cycles. 

This change doesn't mean only a boost in performance. It opens the door to buy Mac apps that are working through all Apple platforms (macOS, iOS, iPadOS) 

Now begins a transition period to adapt apps to the new architecture like when Apple <a href="https://en.wikipedia.org/wiki/Mac_transition_to_Intel_processors">moved</a> from PowerPC to Intel in 2006. Thanks to <a href="https://developer.apple.com/documentation/apple_silicon/about_the_rosetta_translation_environment">Rosetta 2</a> the transition for the end-users should be smooth and apps that work with Intel should still work fine using Rosetta 2.

You can read more info about the transition in this article <a href="https://en.wikipedia.org/wiki/Mac_transition_to_Apple_Silicon">https://en.wikipedia.org/wiki/Mac_transition_to_Apple_Silicon</a>

Current options to install Java in an ARM processor
--------------------------------------------
To install a JDK in your Macbook M1 we have to look for a version compatible with ARM. In this case, we have two alternatives. One option is Azul distribution that you can check out on their website:

<a href="https://www.azul.com/downloads/zulu-community/?os=macos&architecture=arm-64-bit&package=jdk">https://www.azul.com/downloads/zulu-community/?os=macos&architecture=arm-64-bit&package=jdk</a>

and the other is from the guys of Microsoft (yes Microsoft) that have a version of the JDK developed for ARM processors available in Github.

<a href="https://github.com/microsoft/openjdk-aarch64/releases/tag/16-ea%2B10-macos">https://github.com/microsoft/openjdk-aarch64/releases/tag/16-ea%2B10-macos</a>


Add Java to the JAVA_HOME environment variable
-----------------------------------------------------
When we install the JDK using the `.dmg` file, it installs the JDK in the following directory:

```java
/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home/jre
```
Then to have the Java commands available in the command line you should add this directory into your `.zhsrc` file (in case you are using zsh) or `.bashrc` (in case you are using bash) 

Content of the file `.zhsrc`

```java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home/jre
```

Installing Maven
----------------------------
To install Maven in your Macbook Air M1 you just have to download it from the Apache Maven page <a href="https://maven.apache.org/download.cgi">https://maven.apache.org/download.cgi</a> and unzip into your favorite directory. 

I like placing this kind of software at `/opt` folder because according to the <a href="https://www.pathname.com/fhs/pub/fhs-2.3.html#OPTADDONAPPLICATIONSOFTWAREPACKAGES">Filesystem Hierarchy Standard</a>, `/opt` is for “the installation of add-on application software packages. 

Then we have to add it also in the `.zhsrc` file to have the maven commands available. 

```java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home/jre
export PATH=/opt/apache-maven-3.6.3/bin:$PATH
```

macOS M1 vs Windows 10 Intel i7 vs macOS Intel i5 2011 
--------------------------------------------------------
To compare the performance of the new Macbook Air M1 I used my spring-boot-application-example that I have on Github <a href="https://github.com/alexmanrique/spring-boot-application-example">https://github.com/alexmanrique/spring-boot-application-example</a>. The test that I did on all the computers is to start the application locally in each one of the computers.

Here are the results:

### Execution with Imac 2011 Intel i5 4GB RAM on Macosx

In 9,8 seconds the spring-boot application starts

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-mac-2011-intel-i5.png)
{: refdef}

### Execution with Intel i7 12GB RAM on Windows 

In 12.953 seconds the spring boot application starts

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-windows-10-intel-i7.png)
{: refdef}

### Execution with Macbook Air M1 8GB RAM on Macosx

In 3,97 seconds the spring-boot application starts  

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-macbook-air-m1.png)
{: refdef}

In the following table, we can see a summary of the numbers and the difference in cost in time using an M1 laptop. 

|Processor |    JDK version |Total RAM| OS system|  Total time seconds| % decrease| Number times per day |  1 day time cost |   1 month time cost | 1 year time cost|   days per year cost |
| ----------- | ----------- |----------- | ------ | ----------- | ----------- |----------- | ------ |----------- | ----------- |----------- | 
|Intel i5   |Java 8 |   4GB|    Macosx| 9,8 |59,48979592|   15  |147|   2940    |35280  |9,8|
|Intel i7|  Java 8 |12GB|   Windows 10  |12,953|    69,35072956 |15 |194,295    |3885,9|    46630,8 |12,953|
|M1|    Azul Java 8 |8GB|   Macosx| 3,97|   -   |15 |59,55| 1191|   14292|  3,97|

The cost time per deployment is much better with the M1 than in the other computers.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/seconds_per_deploy_cost.png)
{: refdef}

The cost in seconds per day deploying 15 times per day 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/seconds_per_day_cost.png)
{: refdef}

The cost in days per year deploying 15 times per day 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/days_per_year_cost.png)
{: refdef}

It's said that time is money, so if you work with Java and you deploy many times a day your app you should consider an upgrade :-)

Conclusion
--------------
In this post, we have seen how to use Java in a new Macbook Air M1 and how the new processors of Apple outperform the old Intel ones that I was using in other computers. I leave you some references if you want to learn more.

<a href="https://www.wired.com/story/apple-will-put-its-own-chips-into-macs/">https://www.wired.com/story/apple-will-put-its-own-chips-into-macs/</a>

<a href="https://stackoverflow.com/questions/64788005/java-jdk-for-apple-m1-chip">https://stackoverflow.com/questions/64788005/java-jdk-for-apple-m1-chip</a>
