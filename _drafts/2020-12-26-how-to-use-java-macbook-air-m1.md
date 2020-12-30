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

Add Java to the JAVA_HOME environment variable
-----------------------------------------------------
Content of the file .zhsrc

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home/jre

Installing Maven
----------------------------
To install maven in your Macbook Air M1

export PATH=/opt/apache-maven-3.6.3/bin:$PATH

https://stackoverflow.com/questions/64788005/java-jdk-for-apple-m1-chip

MacOs M1 vs Windows 10 Intel i7 vs MacOs Intel i5 2011 
--------------------------------------------------------

Ejecución en Imac 2011 con Intel i5 4GB RAM 

In 9,8 seconds the spring-boot application starts

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-mac-2011-intel-i5.png)
{: refdef}

Ejecución en Windows con Intel i7 12GB RAM

In 12.953 seconds the spring boot application starts

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-windows-10-intel-i7.png)
{: refdef}

Ejecución en Macbook AIR M1 8GB RAM

In 3,97 seconds the spring-boot application starts  

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-macbook-air-m1.png)
{: refdef}

new Macbook AIR the spring-boot application starts in using azul jdk 8

Using Android studio in the new Macbook air
-------------------------------------------

When you install Android Studio you will get the following warning: 

```java
Unable to install Intel® HAXM
Your CPU does not support VT-x.
Unfortunately, your computer does not support hardware accelerated virtualization.
Here are some of your options:
 1) Use a physical device for testing
 2) Develop on a Windows/OSX computer with an Intel processor that supports VT-x and NX
 3) Develop on a Linux computer that supports VT-x or SVM
 4) Use an Android Virtual Device based on an ARM system image
   (This is 10x slower than hardware accelerated virtualization)
Creating Android virtual device
Android virtual device Pixel_3a_API_30_x86 was successfully created
```

Don't panic the only thing that you have to do is to download the last available emulator for apple silicon processors from github https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2.

Once you have downloaded you have to right click to the .dmg file and click open to skip the developer verification.

After opening it you will see `Virtual emulator` in Android studio available to use to deploy your android application. Make sure to have the developer tools available. More details about this emulator you can check out the following <a href="https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html"> link</a>

Conclusion
--------------
In this post we have seen how to use Java in a new Macbook air M1 and how the new processors of Apple outperform the old intel ones that I was using in other computers.


https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html

https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2

https://stackoverflow.com/questions/64907154/android-studio-emulator-on-macos-with-arm-cpu