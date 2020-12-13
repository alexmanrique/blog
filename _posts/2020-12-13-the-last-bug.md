---
layout: single
title: "The last bug"
date: 2020-12-13 12:08:53 +0200
categories: development
comments: true
lang: en
tags: mocks, testing
image: images/bug.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/bug.jpg)
<span>Photo by <a href="https://unsplash.com/@adamgman?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Adam Gman</a> on <a href="https://unsplash.com/s/photos/bug?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>
{: refdef}

In this article, I am going to explain a bug that I had to solve in an application that is responsible for saving data in a non-relational database.

The problem
------------
This API is responsible for processing data sent by a third party and stores it in a non-relational database. This third party sends the information to this REST API through <a href="https://en.wikipedia.org/wiki/Webhook">webhooks</a> that periodically send statistical data.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/bug_request.png)
{: refdef}

Well, one of the fields that this third party sends is a numeric value that was bigger than the value that the API expects (that in this case was an `Integer`). This implies that when receiving the data at the endpoint it would give the following error: 

```java
com.fasterxml.jackson.databind.JsonMappingException: Numeric value (1657567761206) out of range of int
```

The solution
-------------
The solution to the problem was to change the data type from `Integer` to `Long`. This way the error disappeared and the API could save the data back to the non-relational database.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/bug_request_fixed.png)
{: refdef}

This happened because this third party sent the data using an `Integer` and then without prior notice, they changed the data type to a `Long`.

How did I catch the error
--------------------------
I realized that there was an error in the application logs using <a href="https://www.elastic.co/es/kibana">Kibana</a>. Also, because there was no data in the metrics as previously and this triggered an alarm that it's configured by Grafana (read this <a href="{{ site.baseurl }}{% post_url 2018-01-15-metrics-in-your-java-application %}">post</a> that I wrote some time ago if you want to know more) that sends a warning to a Slack channel.

Conclusion
----------------
In this article we have seen a bug that was in production and how when doing the fix in the API it was possible to process the data as before.