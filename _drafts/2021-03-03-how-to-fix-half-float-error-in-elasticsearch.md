---
layout: single
title: "How to fix half float error in elasticsearch"
date: 2021-02-12 09:08:53 +0200
categories: development
comments: true
lang: en
tags: elasticsearch
image: images/set-zeroes-matrix.png
---

Caused by: ElasticsearchException[Elasticsearch exception [type=illegal_argument_exception, reason=[half_float] supports only finite values, but got [94433.46]]]

https://www.elastic.co/guide/en/elasticsearch/reference/6.8/number.html

According to the elasticsearch documentation the maximum value that can have a half float is 65500, so if we try to insert a document with a value higher that the maximum allowed we will receive the previous error. 

## Conclusion

This problem has time complexity O(MxN) because we have to interate over all the matrix, and O(1) space complexity because we are not allocating extra space.
