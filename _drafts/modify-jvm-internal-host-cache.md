---
layout: single
title: "Modify the JVM internal host cache"
date: 2019-12-29 00:13:53 +0200
categories: development
comments: true
lang: en
tags: java, jvm
---

Java has an internal host cache system, in addition, by default it is usually with an infinite value which implies that it will only be consulted via DNS or `/etc/hosts` the first time, then, until the JVM is restarted it will be served from the internal Java cache.

The key is these two security properties:

```java
networkaddress.cache.ttl
```

> Specified in java.security to indicate the caching policy for successful name lookups from the name service.. The value is specified as integer to indicate the number of seconds to cache the successful lookup.

> A value of -1 indicates «cache forever». The default behavior is to cache forever when a security manager is installed, and to cache for an implementation specific period of time, when a security manager is not installed.

```java
-#networkaddress.cache.ttl=-1
+networkaddress.cache.ttl=30
```

And the other security property is the following:

```java
networkaddress.cache.negative.ttl
```

> Specified in java.security to indicate the caching policy for un-successful name lookups from the name service.. The value is specified as integer to indicate the number of seconds to cache the failure for un-successful lookups.

> A value of 0 indicates «never cache». A value of -1 indicates «cache forever».


```java
-networkaddress.cache.negative.ttl=10
+networkaddress.cache.negative.ttl=0
```

If we modify this value, the running JVM must be reset to apply the changes.


 















  












