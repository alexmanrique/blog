---
layout: single
title: "Issue with Loading Cache Guava"
date: 2022-08-14 09:08:53 +0200
categories: development
comments: true
lang: en
tags: cache, guava, java, performance, debugging
image: images/layer.jpeg
---

{:refdef: style="text-align: center;"}
![Cache Layer Architecture]({{ site.baseurl }}/images/layer.jpeg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Foto de <a href="https://unsplash.com/@hasanalmasi?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Hasan Almasi</a> en <a href="https://unsplash.com/es/s/fotos/capa?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef}

In this post, I'll share a critical bug I discovered after deploying to production. This incident highlights the importance of thorough testing and understanding cache configurations when implementing performance optimizations.

## The Problem: Slow API Response Times

We had a REST API endpoint that was taking **10 seconds** to respond. After investigation, I found that the endpoint was making a database query on every request, even though the data rarely changed. The application was executing a `SELECT * FROM ...` query for the same data repeatedly.

Since the records in this table were rarely modified compared to the number of reads, implementing a cache made perfect sense to avoid hitting the database on every request.

## The Solution: Implementing Guava LoadingCache

I decided to use Google Guava's `LoadingCache` with a `CacheLoader` that would refresh the cache data every 30 minutes. The cache would be pre-populated on application startup to prevent the first request from taking longer than necessary.

Here's the basic implementation:

```java
CacheLoader<String, String> loader = new CacheLoader<String, String>() {
    @Override
    public String load(String key) {
        return key.toUpperCase();
    }
};

LoadingCache<String, String> cache = CacheBuilder.newBuilder()
    .refreshAfterWrite(30, TimeUnit.MINUTES)
    .build(loader);
```

## The Bug: Cache Size Limitation

After deploying the changes to our Canary environment and testing against the stable Pod balancer, I noticed a discrepancy:

- **Stable environment**: 3,982 elements returned
- **Canary environment**: 3,958 elements returned (24 elements missing)

After spending an entire day investigating this issue, I discovered the root cause: **the cache was configured with a maximum size of 4,000 elements**.

When the cache reached its maximum capacity, it started evicting the oldest entries, which caused the missing 24 elements in the response.

## Understanding Cache Eviction

Here's a simple example to demonstrate how cache eviction works:

```java
CacheLoader<String, String> loader = new CacheLoader<String, String>() {
    @Override
    public String load(String key) {
        return key.toUpperCase();
    }
};

LoadingCache<String, String> cache = CacheBuilder.newBuilder()
    .maximumSize(3)  // Only 3 elements allowed
    .build(loader);

cache.getUnchecked("first");
cache.getUnchecked("second");
cache.getUnchecked("third");
cache.getUnchecked("fourth");  // This will evict "first"
```

In this example, when the fourth element is added, the first element gets evicted due to the size limitation.

## The Fix: Increasing Cache Size

The solution was straightforward: **increase the cache size from 4,000 to 5,000 elements**.

```java
LoadingCache<String, String> cache = CacheBuilder.newBuilder()
    .maximumSize(5000)  // Increased from 4000
    .refreshAfterWrite(30, TimeUnit.MINUTES)
    .build(loader);
```

## Prevention: Adding Unit Tests

After fixing the bug, I created a unit test to ensure that if someone changes the cache settings in the future, the test will fail and catch the issue before it reaches production:

```java
@Test
public void testCacheSizeIsSufficient() {
    // Load all expected data into cache
    for (int i = 0; i < expectedDataSize; i++) {
        cache.getUnchecked("key" + i);
    }

    // Verify all data is still in cache
    assertEquals(expectedDataSize, cache.size());

    // Verify we can retrieve all elements
    for (int i = 0; i < expectedDataSize; i++) {
        assertNotNull(cache.getIfPresent("key" + i));
    }
}
```

## Key Lessons Learned

### 1. Cache Size Planning

Always calculate the maximum number of elements your cache might hold and set the size accordingly. Consider:

- Current data size
- Future growth
- Memory constraints
- Performance requirements

### 2. Testing Cache Behavior

Implement tests that verify:

- Cache size limits
- Eviction policies
- Data consistency
- Performance under load

### 3. Monitoring Cache Metrics

Monitor cache statistics to detect issues early:

- Hit/miss ratios
- Eviction counts
- Memory usage
- Response times

### 4. Gradual Rollouts

Use Canary deployments to catch issues before they affect all users. The discrepancy between environments helped identify the problem quickly.

## Best Practices for Guava Cache

### Size Configuration

```java
// For bounded caches, always set appropriate limits
LoadingCache<String, Data> cache = CacheBuilder.newBuilder()
    .maximumSize(10000)
    .maximumWeight(1000000)  // Alternative to size
    .build(loader);
```

### Time-based Expiration

```java
// Set appropriate expiration times
LoadingCache<String, Data> cache = CacheBuilder.newBuilder()
    .expireAfterWrite(30, TimeUnit.MINUTES)
    .expireAfterAccess(10, TimeUnit.MINUTES)
    .build(loader);
```

### Monitoring and Statistics

```java
// Enable statistics for monitoring
LoadingCache<String, Data> cache = CacheBuilder.newBuilder()
    .recordStats()
    .build(loader);

// Later, check statistics
CacheStats stats = cache.stats();
System.out.println("Hit rate: " + stats.hitRate());
System.out.println("Eviction count: " + stats.evictionCount());
```

## Conclusion

This incident taught us several important lessons about cache implementation:

1. **Always plan cache size carefully** - Consider current and future data volumes
2. **Test cache behavior thoroughly** - Include edge cases and load testing
3. **Monitor cache performance** - Use metrics to detect issues early
4. **Implement proper testing** - Unit tests can prevent similar issues
5. **Use gradual deployments** - Canary deployments help catch issues quickly

The bug was ultimately caused by underestimating the cache size requirements. By increasing the cache size and adding proper monitoring, we not only fixed the immediate issue but also prevented similar problems in the future.

Cache implementations can be tricky, and small configuration mistakes can lead to significant production issues. Always test thoroughly and monitor your cache behavior in production environments.

Have you encountered similar cache-related issues? Share your experiences in the comments below!
