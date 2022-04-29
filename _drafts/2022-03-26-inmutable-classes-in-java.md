---
layout: single
title: "Inmutable classes in Java"
date: 2022-03-26 09:08:53 +0200
categories: development
comments: true
lang: en
tags: microservices
image: images/microservices.jpg
---

In this post we are going to talk about the importance of writing inmutable classes in Java.

Plain old java object - POJO
---------------------------------
Plain old Java object is a domain class, a class that has only fields and without any special business logic. Only attributes that should be encapsulated.

The attributes of this POJO should be only modified in the creation of an object of the class and should not be modified after the creation of the object. 

Race condition
---------------------------------
If we allow that the state of this object is modified during the lifetime of it we open the door to situations like race conditions in case that we have multiple threads that read and modify the state of this object. A race conditions can happen when a reader of the state of the object reads the state 










