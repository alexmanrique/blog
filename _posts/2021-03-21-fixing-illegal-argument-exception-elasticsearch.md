---
layout: single
title: "Fixing IllegalArgumentException in elasticsearch"
date: 2021-03-21 09:08:53 +0200
categories: development
comments: true
lang: en
tags: elasticsearch
image: images/elasticsearch_half_float.png
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/elasticsearch_error.png)
{: refdef}

In the following post, we are going to see how to solve an error that I found in an application that is using Elasticsearch as storage.

What is Elasticsearch?
-----------------------------
Elasticsearch is a non-relational database that is powerful for doing searches by text. The definition from <a href="https://en.wikipedia.org/wiki/Elasticsearch">wikipedia</a>:

> Elasticsearch is a search engine based on the Lucene library. It provides a distributed, multitenant-capable full-text search engine with an HTTP web interface and schema-free JSON documents

I have used it to store millions of documents for things like storing prices searched. 

Error found in the logs
-----------------------------
Some days ago I found the following error in the logs of the application that I was working on:

> Caused by: ElasticsearchException[Elasticsearch exception [type=illegal_argument_exception, reason=[half_float] supports only finite values, but got [94433.46]]]

According to the elasticsearch <a href="https://www.elastic.co/guide/en/elasticsearch/reference/6.8/number.html">documentation</a> the maximum value that can have a `half_float` is `65500`, so if we try to insert a document with a value higher than the maximum allowed we will receive the previous error. 

Index with the wrong mapping 
--------------------------------------

Looking at the mappings of the existing index I could see that there were fields with this `half_float`

```java
"opnl_flights_ow_v2": {
    "mappings": {
      "_doc": {
        "properties": {
          "prices": {
            "properties": {
              "PRICE": {
                "properties": {
                  "amount": {
                    "type": "half_float",
                    "index": false
                  },
                  "currency": {
                    "type": "keyword",
                    "index": false
                  }
                }
              }
```

How to fix the error
-----------------------------

We can update an index template of an existing index.  With the execution of the following command, we can update the property `amount` setting his type to `float` instead of the `half_float` that was generating the error. 

```console
curl -XPUT 'http://localhost:9200/{name_of_the_index}/_doc/_mapping' -H 'Content-Type: application/json'  -d '
{
    "_doc" : {
        "properties" : {
            "amount" : {"type" : "float", "store" : true}
        }
    }
}
```

In our case, we don't need to reindex the documents into a new index because we are only setting a type that is larger than the previous one. It would be different that we change i.e: from String to date, that would need <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html">
reindexing.</a> of the data from the old index to the new index.

## Conclusion

In this post, we have seen how to fix a `half_float` problem that we had in our Elasticsearch index where we were storing prices that were higher than the `half_float` maximum value.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/elasticsearch_ok.png)
{: refdef}

