---
layout: single
title: "Spring boot helloworld example"
date: 2020-09-04 02:00:53 +0200
categories: development
comments: true
lang: en
tags: springboot, java, swagger, postman
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot.jpg)
{: refdef}

<a href="https://spring.io/projects/spring-boot">Spring boot</a> is a Java framework to build backend Java applications. I decided to write this blog post because I saw <a href="https://github.com/alexmanrique/spring-boot-application-example/network/members">7 forks</a> in my Github repository where I wrote a spring boot helloworld application some time ago and I thought could be interesting to share.

Where is the repository
-----------------------------------
Here's the link to the Github repository : <a href="https://github.com/alexmanrique/spring-boot-application-example">https://github.com/alexmanrique/spring-boot-application-example</a>

If you want to try it you just need to clone the repository in your local environment using:

```java
git clone https://github.com/alexmanrique/spring-boot-application-example.git
```

Prerequisites
---------------------------
To run the app you need to have <a href="https://maven.apache.org/">Maven</a> installed in your local environment to be able to download all the dependencies of the project. You need to have also installed Java 8.  

Once you have cloned the repository you can open the repository in Intellij IDEA or your favorite IDE.

How to start the app
----------------------------
If you go to the class <a href="https://github.com/alexmanrique/spring-boot-application-example/blob/master/src/main/java/com/myapp/MyappServer.java">MyappServer.java</a> then you can run the spring boot application, as simple as that.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-run.png)
{: refdef}

If everything is right you will see the Spring logo in console 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-started.png)
{: refdef}

And a message that the application is up and running:

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/spring-boot-started-ok.png)
{: refdef}

Swagger UI
-------------------------
The app uses <a href="https://swagger.io/">Swagger</a> to display useful documentation of the different endpoints and it's easier to start playing doing calls to the API.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/swagger.png)
{: refdef}

Postman calls
-------------------------

If you prefer to use <a href="https://www.postman.com/">Postman</a> I share with you a <a href="https://www.postman.com/collection/">Postman collection</a> to test the Spring boot api that we have just started:

<a href="https://www.getpostman.com/collections/6e45d359bad60ea7b588">https://www.getpostman.com/collections/6e45d359bad60ea7b588</a>

Here we can see a call to get all the cars that we have in the API.


{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/postman-call.png)
{: refdef}


Here you can see a call to find all drivers that are with status `ONLINE`

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/postman-call-select.png)
{: refdef}

You can use the calls that are in Swagger page and add them to the Postman collection.

Conclusion
------------------------
In this post, we have seen how to start a Spring boot application and how to do some calls using Swagger and Postman. 