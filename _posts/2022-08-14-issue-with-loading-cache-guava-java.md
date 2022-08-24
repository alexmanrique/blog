---
layout: single
title: "Issue with Loading cache Guava"
date: 2022-08-14 09:08:53 +0200
categories: development
comments: true
lang: en
tags: cache
image: images/layer.jpeg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/layer.jpeg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Foto de <a href="https://unsplash.com/@hasanalmasi?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Hasan Almasi</a> en <a href="https://unsplash.com/es/s/fotos/capa?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef} 
  
In this post we are going to talk about a bug that I found after making a release to production. Like all releases, it is recommended and necessary to have a way to verify that what we have released to production does not break the old functionality.

The thing is that in this delivery to production the release consisted of an optimization to reduce the response time of an endpoint of a rest api. It turns out that this endpoint had a response time of 10 seconds.

The problem was that in each request the application made a query to the database to fetch the same data. The request always returned the same values ​​from a database table, as did a `select * from ...`

The records of that table where the `select * from` was done were rarely modified compared to the number of reads, so in the code that is executed in the application to return the data it made sense to put a cache to avoid going each time to the database and thus reduce the response time.

To do this I used a Guava `LoadingCache` and a `CacheLoader` that refreshes the cache data every 30 minutes by doing a database query. When starting the application, the data of that cache is filled to prevent the first request from taking longer than necessary.

```java

    CacheLoader<String, String> loader;
    loader = new CacheLoader<String, String>() {
        @Override
        public String load(String key) {
            return key.toUpperCase();
        }
    };

    LoadingCache<String, String> cache;
    cache = CacheBuilder.newBuilder().build(loader);
```

When releasing the changes to Canary and making a request to the stable pod balancer I saw that the request returned 3982 elements and that the request to Canary returned 3982-24. In other words, 24 elements less than what should be returned to me.

After spending 1 day of work investigating what was happening, it turned out that the problem was the maximum size with which the cache was configured.

It was configured with a maximum of 4000 elements. This caused that when trying to return all the elements of the cache, it returned all the elements added except the last 24.

```java
   CacheLoader<String, String> loader;
    loader = new CacheLoader<String, String>() {
        @Override
        public String load(String key) {
            return key.toUpperCase();
        }
    };
    LoadingCache<String, String> cache;
    cache = CacheBuilder.newBuilder().maximumSize(3).build(loader);

    cache.getUnchecked("first");
    cache.getUnchecked("second");
    cache.getUnchecked("third");
    cache.getUnchecked("forth");
```

In the previous code the first key will be evicted.

The solution was to increase the number of cache elements to 5000.

After finding the bug I did a unit test to ensure that if someone changed the cache settings a test would fail.

Conclusion
------------
In this post we have seen how a configuration problem in a cache can cause a bug that is difficult to detect in the development phase.



