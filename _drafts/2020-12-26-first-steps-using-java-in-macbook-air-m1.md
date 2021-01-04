---
layout: single
title: "First steps using Java in a Macbook Air M1"
date: 2020-12-26 09:45:53 +0200
categories: development
comments: true
lang: en
tags: mac, apple, m1, java
image: images/apache_maven.png
---

In this post we are going to see how to use Java in a Macbook M1 with the new Apple processors. *Disclaimer*: This post has been written in early 2021, so all this maybe has changed at the time you are reading this.

Intel(x86) vs ARM 
-------------------------------------------
Apple has changed Intel x86 for the ARM chips in their new Macbooks released in late 2020. ARM has been used by Apple and Android manufacturers in their phone devices whereas Intel has been used mainly in computers. 

Intel processors use complex instruction set computing (CISC) while ARM uses reduced instruction set computing (RISC) which leads to a the ARM processors to execute instructions in one cycle and Intel processors to need several cycles.  

Options to install Java in an ARM processor
--------------------------------------------
To install a JDK in your Macbook M1 we have to look for a version compatible with ARM. In this case we have two alternatives. One option is Azul distribution that you can check out in their website:

<a href="https://www.azul.com/downloads/zulu-community/?os=macos&architecture=arm-64-bit&package=jdk">https://www.azul.com/downloads/zulu-community/?os=macos&architecture=arm-64-bit&package=jdk</a>

and the other is from the guys of Microsoft (yes Microsoft) that have a version of the JDK developed for ARM processors available in Github.

<a href="https://github.com/microsoft/openjdk-aarch64/releases/tag/16-ea%2B10-macos">https://github.com/microsoft/openjdk-aarch64/releases/tag/16-ea%2B10-macos</a>


Add Java to the JAVA_HOME environment variable
-----------------------------------------------------
When we install the JDK using the `.dmg` file, it installs the JDK in the following directory:

```java
/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home/jre
```
Then to have the java commands available in the command line you should add this directory into your `.zhsrc` file (in case you are using zsh) or `.bashrc` (in case you are using bash) 

Content of the file .zhsrc

```java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home/jre
```

Installing Maven
----------------------------
To install Maven in your Macbook Air M1 you just have to download it from the Apache Maven page <a href="https://maven.apache.org/download.cgi">https://maven.apache.org/download.cgi</a> and unzip into your favourite directory. 

I like placing this kind of software at `/opt` folder because according to the <a href="https://www.pathname.com/fhs/pub/fhs-2.3.html#OPTADDONAPPLICATIONSOFTWAREPACKAGES">Filesystem Hierarchy Standard</a>, `/opt` is for “the installation of add-on application software packages. 

Then we have to add it also in the `.zhsrc` file to have the maven commands available. 

```java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/home/jre
export PATH=/opt/apache-maven-3.6.3/bin:$PATH
```

Macos M1 vs Windows 10 Intel i7 vs Macos Intel i5 2011 
--------------------------------------------------------
To compare the performance of the new Macbook Air M1 I used my spring-boot-application-example that I have on Github <a href="https://github.com/alexmanrique/spring-boot-application-example">https://github.com/alexmanrique/spring-boot-application-example</a>. The test that I did in all the computers is to start the application locally in each one of the computers.

Here are the results:

### Imac 2011 execution with Intel i5 4GB RAM 

In 9,8 seconds the spring-boot application starts

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-mac-2011-intel-i5.png)
{: refdef}

### Windows execution with Intel i7 12GB RAM

In 12.953 seconds the spring boot application starts

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-windows-10-intel-i7.png)
{: refdef}

### Macbook AIR M1 execution with 8GB RAM

In 3,97 seconds the spring-boot application starts  

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-macbook-air-m1.png)
{: refdef}

In the following table we can see a summary of the numbers in the difference of cost in time using a M1 laptop, deploying 30 times 

|Processor |	JDK version	|Total RAM|	OS system|	Total time seconds|	% decrease|	Number times per day |	1 day time cost |	1 month time cost |	1 year time cost|	days per year cost |
| ----------- | ----------- |----------- | ------ | ----------- | ----------- |----------- | ------ |----------- | ----------- |----------- | 
|Intel i5	|Java 8 |	12GB|	Macosx|	9,8	|59,48979592|	30	|294|	5880	|70560	|19,6|
|Intel i7|	Java 8 |4G|	Windows 10	|12,953|	69,35072956	|30	|388,59	|7771,8|	93261,6	|25,906|
|M1|	Azul Java 8	|8GB|	Macosx|	3,97|	-	|30	|119,1|	2382|	28584|	7,94|

Using Android studio in the new Macbook air
-------------------------------------------
When you install Android Studio you will get the following warning: 

```
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

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/your_processor_doesn_allow_virtualization.png)
{: refdef}


Don't panic the only thing that you have to do is to download the last available emulator for Apple silicon processors from Github <a href="https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2">https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2</a>

Once you have downloaded you have to right click to the .dmg file and click open to skip the developer verification.

### Using the virtual emulator

After opening it you will see `Virtual emulator` in Android studio available to use to deploy your android application. Make sure to have the developer tools available. 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/using_the_android_emulator.png)
{: refdef}

More details about this emulator you can check out the following url <a href="https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html">https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html</a>

Conclusion
--------------
In this post we have seen how to use Java in a new Macbook Air M1 and how the new processors of Apple outperform the old intel ones that I was using in other computers.

https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html

https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2

https://stackoverflow.com/questions/64907154/android-studio-emulator-on-macos-with-arm-cpu

https://stackoverflow.com/questions/64788005/java-jdk-for-apple-m1-chip