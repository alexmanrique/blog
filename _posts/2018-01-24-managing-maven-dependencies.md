---
title:  "How to manage Maven dependencies"
date:   2018-01-24 20:13:53 +0200
categories: development
comments: true
lang: en
ref: maven1
tags: java maven code 
---

When you create a Java project using Maven as a dependency management you can include all the dependencies that you want in your repository. A possible structure for your maven project can be a multi-module project where you have a <a href="https://maven.apache.org/guides/introduction/introduction-to-the-pom.html">pom</a> parent and then you have a module for each layer that has your application. 

- parent 
- web-layer (servlets) 
- service-layer (services, ejbs)
- model-layer (domain classes)
- store-layer (persistence classes)
- packaging (place to define how you package your ear) 

Each one of this modules has its own pom.xml where you can define which dependencies you need for this module. You can end up adding in each module different dependencies that you need for each module, but maybe you are not aware of the transitive dependencies of each jar. 

Problem - NoSuchMethodError in runtime
----------------------------
While you run your application in an application server like JBoss, Tomcat or Glassfish you get an exception because there’s a dependency conflict. You have more than one jar with the same class and it generates an exception while you run it that says `NoSuchMethodError`:

{% highlight json %}
exception":{"class":"java.lang.NoSuchMethodError","message":"com.MetricsManager.getInstance()Lcom/MetricsManager;","stacktrace":"java.lang.NoSuchMethodError: com.MetricsManager.getInstance()Lcom/MetricsManager
{% endhighlight %}

How can we fix this problem? This is because we have added dependencies in the poms of our application and we have not excluded the transitive dependencies that conflict with transitive dependencies of other jars.

Option 1 - Resolving conflicts with intellij-idea
------------------------------------------
<a href="https://www.jetbrains.com/idea/">Intellij</a> has an option to see all the dependency tree of a module in a diagram with boxes and arrows. 

![Show dependencies]({{ site.baseurl }}/images/diagram_show_dependencies.png)

Each box is a dependency that is connected with his dependencies. When there is a dependency conflict a red arrow appears. So what you have to do is to find the red arrows in the dependency tree and see which libraries are importing the same library.

![Dependency diagram]({{ site.baseurl }}/images/dependency_diagram.png) 

To exclude transitive dependencies you can right click in the library and select exclude if you want to exclude a dependency.

![Exclude dependency]({{ site.baseurl }}/images/exclude_dependency.png)

And then you get in the pom.xml the dependency excluded. 

![Dependency excluded]({{ site.baseurl }}/images/dependency_excluded.png) 

Option 2 - Resolving conflicts using dependency plugin
-----------------------------------
The second option is to use this <a href="https://maven.apache.org/plugins/maven-dependency-plugin/examples/resolving-conflicts-using-the-dependency-tree.html">apache maven dependency plugin</a> that allows you to check which are the conflictive versions inside of your ear. The plugin finds: 

- Dependencies that are directly used but are not declared. (The project still compiles because it gets the dependencies transitively.)
- Dependencies that are declared but are unused.

{% highlight xml %}
mvn dependency:tree -Dverbose -Dincludes=commons-codec > output.txt
{% endhighlight %}

{% highlight json %}

[INFO] |  |  +- commons-httpclient:commons-httpclient:jar:3.0.1:compile
[INFO] |  |  |  \- (commons-codec:commons-codec:jar:1.4:compile - omitted for duplicate)
[INFO] |  |  \- (commons-codec:commons-codec:jar:1.4:compile - omitted for duplicate)
[INFO] |   \- org.jboss.resteasy:resteasy-jaxrs:jar:2.3.4.Final:compile
[INFO] |     \- org.apache.httpcomponents:httpclient:jar:4.1.2:compile
[INFO] |         \- (commons-codec:commons-codec:jar:1.4:compile - omitted for duplicate)

{% endhighlight %}


Option 3 - Resolving conflicts checking jars in the ear file
-------------------------------------
Another option can be to check manually the libs that you have inside the ear file. You should check the lib folders and review visually if you have equal jar names with different versions.

Good practice - using dependency management
-----------------------------------------
A good practice is to define in the pom parent the dependencies that you will use in your maven project and the version numbers. This way if you use a dependency in more than one module of your repository you will use the same version in all the modules.

This is the parent pom.xml

{% highlight xml %}
<dependencyManagement>
   <dependencies>
       <dependency>
<dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>[3.1.0]</version>
      <scope>provided</scope>
</dependency>
     <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>[1.2.17]</version>
</dependency>
   </dependencies>
</dependencyManagement>
{% endhighlight %}

This is the pom.xml of the web-layer. Notice that you are not defining the version number of the dependency because is defined in the parent pom.

{% highlight xml %}
<dependencies>
       <dependency>
<dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
</dependency>
   </dependencies>
{% endhighlight %}


Conclusion
-----------------
The dependencies of your Java application should be managed carefully because you can get surprises while running your application. We have seen three ways to approach this problem and a good practice to organize your pom files with `dependencyManagement` in your parent pom.









