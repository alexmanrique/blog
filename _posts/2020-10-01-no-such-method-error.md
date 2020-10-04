---
layout: single
title: "NoSuchMethodError thrown at runtime"
date: 2020-10-01 13:45:53 +0200
categories: development
comments: true
lang: en
tags: java, maven, dependencies, jars
image: images/jars.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/jars.jpg)
{: refdef}

In this post, we are going to see the `NoSuchMethodError` error that we get at runtime when there's a dependency conflict in our Java Maven application and we will see how can we overcome this error by fixing the dependency in our `pom.xml` file.

Why we get this error?
--------------------------
When we have two different `jars` of the same library that have the same class in different packages and one method of this class is called by the application in execution time the <a href="https://en.wikipedia.org/wiki/Java_virtual_machine">JVM</a> throws a `NoSuchMethodError`.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/header_no_such_method_error.png)
{: refdef}

In the picture above we have two different versions of Guava (16 and 25.1-android) that have the same class `PreConditions`. 

According to the Oracle <a href="https://docs.oracle.com/javase/7/docs/api/java/lang/NoSuchMethodError.html">documentation</a>, this error may occur at runtime if a class has been incompatibly changed. 

In the following example we will see a problem that I had with transitive dependencies (the ones that we import into our application indirectly from other dependencies)

A real example
--------------------------
In the following image we can see that the call to the method `checkArgument` of the class `PreConditions` of <a href="https://github.com/google/guava">Guava</a> library threw `NoSuchMethodError` 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/nosuchmethoderror.png)
{: refdef}

If we look for the class `PreConditions` in Intellij Idea typing `PreConditions.class` in the search menu (if we don't write .class in Intellij we won't find the <a href="https://docs.oracle.com/javase/tutorial/java/concepts/class.html">class</a>) we will see that it's present in three different `jars`:

- Guava version 25.1-android
- Guava version 16.0
- rt.jar 1.8

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/nosuchmethoderror2.png)
{: refdef}

Looking at the dependencies
------------------------------
We can check the maven dependencies tree using the <a href="https://maven.apache.org/plugins/maven-dependency-plugin/">maven dependency plugin</a> in the command line 

```
$> mvn dependency:tree 
```
or using the dependency view diagram with the Intellij Idea:

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/diagram_show_dependencies.png)
{: refdef}

we get the tree diagram. In this case, we can see the red lines that indicate we have a dependency conflict.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/nosuchmethoderror3.png)
{: refdef}

How to fix it 
------------------------------
We need to set up one of the two versions in the `dependency management` section in our `pom.xml` (parent if we have a multi-module project) 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/nosuchmethoderror4.png)
{: refdef}

If we come back to the dependency tree we won't see red lines anymore, neither with the maven dependency plugin. 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/nosuchmethoderror5.png)
{: refdef}


Conclusion
----------------------------
In this post, we have seen how to fix the `NoSuchMethodError` and the reason why it's thrown in our Java Maven application.
If you want more information regarding how to manage Maven dependencies you can read this <a href="{{ site.baseurl }}{% post_url 2018-01-24-managing-maven-dependencies %}">post</a> that I wrote some time ago.




