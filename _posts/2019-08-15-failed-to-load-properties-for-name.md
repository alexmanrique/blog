---
layout: single
title: "Failed to load properties for name - understanding Java class loaders"
date: 2019-08-15 00:13:53 +0200
categories: development
comments: true
lang: en
tags: data 
---

Adding a cache
-------------------------
One of the last tasks that I have been involved has been to reduce the <a href="https://en.wikipedia.org/wiki/Technical_debt">technical debt</a> of a tool that was using <a href="https://backbonejs.org/">backbone</a> and <a href="https://getbootstrap.com/">bootstrap</a> in the frontend, and Java in the backend. 

The backend part was using different <a href="https://en.wikipedia.org/wiki/Representational_state_transfer">REST</a> <a href="https://en.wikipedia.org/wiki/Application_programming_interface">API</a>'s that were returning information that had to be displayed in the user interface <a href="https://en.wikipedia.org/wiki/User_interface">(UI)</a>. 

Those API’s provided data that didn’t change in time, so this was a good scenario to use a <a href="https://en.wikipedia.org/wiki/Cache_(computing)">cache</a> to avoid calling to those services every time that a page of the UI was rendered. 

Java cache system
--------------------------
The cache used was one provided by <a href="https://commons.apache.org/proper/commons-jcs/">Java cache system</a> (JCS), an <a href="https://www.apache.org/">open source apache</a> library that provides cache functionalities. To configure a cache you need to have a `cache.ccf` properties file where you configure the different aspects of your desired cache. 

The first call to the service that used the cache was trying to initialize the cache using the following call:

```java
JCS.getInstance(this.getStorageSpaceName() + "-missed");
```

This method was calling `ensureCacheManager()` of `JCS.java` that it called `cacheMgr.configure` method:

`JCS.java`

```java
protected static synchronized void ensureCacheManager()
{
   if ( cacheMgr == null )
   {
       if ( configFilename == null )
       {
           cacheMgr = CompositeCacheManager.getInstance();
       }
       else
       {
           cacheMgr = CompositeCacheManager.getUnconfiguredInstance();

           cacheMgr.configure( configFilename );
       }
   }
}
```

If we look at the code from `CompositeCacheManager.java` method `configure`

`CompositeCacheManager.java`

```java
/**
* Configure from specific properties file.
*
* @param propFile
*            Path <u>within classpath </u> to load configuration from
*/
public void configure( String propFile )
{
   log.info( "Creating cache manager from config file: " + propFile );

   Properties props = new Properties();

   InputStream is = getClass().getResourceAsStream( propFile );

   if ( is != null )
   {
       try
       {
           props.load( is );

           if ( log.isDebugEnabled() )
           {
               log.debug( "File [" + propFile + "] contained " + props.size() + " properties" );
           }
       }
       catch ( IOException ex )
       {
           log.error( "Failed to load properties for name [" + propFile + "]", ex );
           throw new IllegalStateException( ex.getMessage() );
       }
       finally
       {
           try
           {
               is.close();
           }
           catch ( Exception ignore )
           {
               // Ignored
           }
       }
   }
   else
   {
       log.error( "Failed to load properties for name [" + propFile + "]" );
       throw new IllegalStateException( "Failed to load properties for name [" + propFile + "]" );
   }

   configure( props );
}

```

Returned error
----------------------------

The error that was returning was `Failed to load properties for name` . When calling the following method:

```java
InputStream is = getClass().getResourceAsStream( “cache.ccf” ); 
```

It was returning `null` because it was not finding the `cache.ccf` file in the classpath althought it was inside services.jar inside the `WEB-INF/lib` 

This was the content inside the `Application.ear`:

```console
war/WEB-INF/lib/services.jar (cache.ccf)
lib/jcs_1.3.jar 
```

Javadoc of getResourceAsStream method
-------------------------------------

To understand why was failing let’s look at the <a href="https://en.wikipedia.org/wiki/Javadoc">javadoc</a> method definition of method <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/Class.html#getResourceAsStream-java.lang.String-">`getResourceAsStream`</a> of class `Class`

> Finds a resource with a given name. The rules for searching resources associated with a given class are implemented by the defining class loader of the class. This method delegates to this object's class loader. If this object was loaded by the bootstrap class loader, the method delegates to ClassLoader.getSystemResourceAsStream(java.lang.String).

To understant this definition we have to look at documentation of class loaders in Java.

Class loaders in Java
-------------------------------------

The class loader of `CompositeCacheManager` was the `Web class loader` because it was inside WEB-INF/lib folder 

<a href="https://docs.oracle.com/cd/E19501-01/819-3659/beadf/index.html">class loaders</a> follows a delegation methodology, if a class loader is not able to load a class it delegates the task to it’s parent class loader in the hierarchy:

{:refdef: style="text-align: center;"}
![Bad request]({{ site.baseurl }}/images/classloaders.png)
{: refdef}

jar files inside `lib/` are using the `Application Class Loader`, so `jcs_1.3.jar` was not able to find `cache.ccf` file because it was only available using the `Web class loader`. 

Note that this is not a Java inheritance hierarchy, but a delegation hierarchy. In the delegation design, a class loader delegates classloading to its parent before attempting to load a class itself. 

> A class loader parent can be either the System class loader or another custom class loader. If the parent class loader cannot load a class, the class loader attempts to load the class itself. In effect, a class loader is responsible for loading only the classes not available to the parent.

The solution
----------------------------
Changing the `maven-ear-plugin` configuration in maven moved `services.jar` outside the `war/WEB-INF/lib/` folder and set it in root of the ear file:

{% highlight xml %}
<plugin>
   <artifactId>maven-ear-plugin</artifactId>
   <configuration>
       <finalName>application</finalName>
       <modules>
           <webModule>
               <groupId>${project.groupId}</groupId>
               <artifactId>web-layer</artifactId>
               <contextRoot>/application-context-root</contextRoot>
               <bundleFileName>application.war</bundleFileName>
           </webModule>
           <ejbModule>
               <groupId>${project.groupId}</groupId>
               <artifactId>services</artifactId>
               <bundleFileName>services.jar</bundleFileName>
           </ejbModule>
       </modules>
       <earSourceDirectory>${basedir}/src/main/application</earSourceDirectory>
      </configuration>
</plugin>
{% endhighlight %}

Inside the Application.ear after doing the change in the pom.xml :

```console
/war/WEB-INF/lib/
/lib/jcs_1.3.jar     
/services.jar (cache.ccf)
```

With this change the `jcs_1.3.jar` was able to read the properties fine using the following call: 

```java
InputStream is = getClass().getResourceAsStream( propFile ); 
```

After moving `services.jar` to the root directory the content of this jar was available using the `Application Class Loader`, so when a class from `lib/jcs_1.3.jar` requests `cache.ccf` it’s available using a parent class loader that in this case is the `Application class Loader`.

Conclusion
-----------------------
Visibility of properties (or other resources) inside a Java EE application depend on where those files are placed and it's important to understand how class loaders work if you are using a method like `getResourceAsStream`.

Also, reviewing the code of third party library that you are using is a good way to spot any problem that occurs during the development of your application.












  












