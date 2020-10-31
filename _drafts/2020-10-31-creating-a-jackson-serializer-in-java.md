---
layout: single
title: "Creating a custom serializer/deserializer in Java"
date: 2020-10-31 13:45:53 +0200
categories: development
comments: true
lang: en
tags: json,serializer,java
---

In this post we are going to see how to create a Jackson Serializer and also a deserializer to be able to send Java objects using JSON in the context of a Java REST API.

Why do we need serializers and deserializers
---------------------------------------------
Serializers help us to create a representation of an object that is in memory with a particular structure translating it into a different one that allows us to send the data that is inside this object in a way that it's easier to transfer from one system to another. This system can be from one server to another, from memory into the filesystem.

Deserializers allow us to do the opposite process, translating from a representation that has been easy to transfer the data of the object into the original object.

With this process we can transfer data in a more efficient way rather that transfering the original structure of the data object.

Jackson Java library to serialize and deserialize
----------------------------------------------



Java code example to serialize and deserialize
----------------------------------------------- 

```java
import org.codehaus.jackson.map.annotate.JsonSerialize;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@ApiModel(value = "Class that defines a Employee", subTypes = {Developer.class, ProductManager.class, MarketingExecutive.class})
public class Employee {

    @NotNull
    private String name;
    @NotNull
    private String email;
    @NotNull
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime creationDate;
```

```java
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

public class LocalDateTimeSerializer extends JsonSerializer<LocalDateTime> {

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public void serialize(LocalDateTime localDateTime, JsonGenerator jsonGenerator,
                          SerializerProvider serializerProvider) throws IOException {
        jsonGenerator.writeString(localDateTime.format(formatter));
    }
}
```


```java

package com.odigeo.marketing.promo.campaigns.v3.serialize;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.map.DeserializationContext;
import org.codehaus.jackson.map.JsonDeserializer;

public class LocalDateTimeDeserializer extends JsonDeserializer<LocalDateTime> {

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public LocalDateTime deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException {
        return LocalDateTime.parse(jsonParser.getText(), formatter);
    }
}

```


Conclusion
--------------







