---
layout: single
title: "Creating a custom serializer/deserializer in Java"
date: 2020-10-31 13:45:53 +0200
categories: development
comments: true
lang: en
tags: json, serializer, java
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/serialization-in-java.png)
{: refdef}


In this post we are going to see how we can use serialization using a Java library called Jackson to be able to send Java objects using JSON in the context of a Java REST API.

Why do we need serialization
---------------------------------------------
Serializers convert a Java object into a stream of bytes which can be persisted into a filesystem or shared between two different servers through a network connection.

Deserializers allow us to do the opposite process, translating from a stream of bytes that has been easy to transfer into the original Java Object.

With this process we can transfer data in a more efficient way rather that transfering the original structure of the data object.

Serialization example
-----------------------------------------------
In the following example we can see how serialization works. Given a class `Employee` 

```java
@JsonPropertyOrder({ "email", "name", "id", "yearsOfExperience" })
public class Employee {
    private long id;
    private String name;
    private String email;
    private int yearsOfExperience;
}
```
serializing an object will output a JSON with the following structure:

```json
{
    "email":"contact@alexmanrique.com",
    "name":"Alex",
    "yearsOfExperience":"10",
    "id":1
}
```
This is the default serialization that we got for the class `Car` but what if we have a field that is not possible to serialize? Here is when we need to create a custom serializer for this field. 

Java libraries to serialize and deserialize
--------------------------------------------------
There are some Java libraries out there, that you can use for serialization purposes. I choosed `Jackson` some time ago because this library its shipped with <a href="https://www.wildfly.org/">JBoss application server</a> and I can use it using the <a href="{{ site.baseurl }}{% post_url 2018-01-24-managing-maven-dependencies %}"> provided</a> scope when importing it using Maven. 

Jackson is a mature JSON serialization/deserialization library that is built into all JAX-RS implementations and has an extensive annotation support, however there are other alternatives out there.

|   Lib name | URL         | Github stars | Forks |
| Jackson| <a href="https://github.com/FasterXML/jackson">github.com/FasterXML/jackson</a> | 6K | 1k |
| GSON | <a href="https://github.com/google/gson">github.com/google/gson</a> |   18,7K | 3,6k  |
| Fastjson | <a href="https://github.com/alibaba/fastjson">github.com/alibaba/fastjson</a> | 22,5K | 6k |
| Moshi | <a href="https://github.com/square/moshi">github.com/square/moshi</a> | 6,7K | 536 |
| Jsoniter | <a href="https://github.com/json-iterator/java">github.com/json-iterator/java</a> | 1,3K | 424 |

According to the numbers of stars and forks done `Fastjson` from Alibaba is the library that right now has more support in the open source community.

Using Jackson in our Maven Java application
----------------------------------------------- 

To be able to use Jackson we need to import in your `pom.xml` file if we are using Maven:

```xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>[2.6.0]</version>
</dependency>
<dependency>
    <groupId>org.jboss.resteasy</groupId>
    <artifactId>resteasy-jackson-provider</artifactId>
    <version>[2.3.10.Final]</version>
</dependency>
```

Java code example to serialize and deserialize
----------------------------------------------- 

In the following example we can see the class `Employee` that is using a serializer and deserializer for the attribute `creationDate`.
We use the annotation `@JsonDeserialize` and `@JsonSerialize` to bind the usage of the serializer and deserializer to the attribute.

```java
import org.codehaus.jackson.map.annotate.JsonSerialize;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@ApiModel(value = "Class that defines a Employee", subTypes = {Developer.class, ProductManager.class, MarketingExecutive.class})
public class Employee {

    private long id;
    @NotNull
    private String name;
    @NotNull
    private String email;
    @NotNull
    private int yearsOfExperience;
    @NotNull
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime creationDate;
    
    public Employee(){
        //needed for jackson serialization purposes
    }
    ...
}
```

Note that you need a default no args-constructor in your bean class otherwise we will receive an error similar to this.

```java
org.codehaus.jackson.map.JsonMappingException: No suitable constructor found for type [simple type, class Employee]: can not instantiate from JSON object (need to add/enable type information?) at [Source: employee.json; line: 1, column: 2] at org.codehaus.jackson.map.JsonMappingException.from(JsonMappingException.java:163) at org.codehaus.jackson.map.deser.BeanDeserializer.deserializeFromObjectUsingNonDefault(BeanDeserializer.java:746) at org.codehaus.jackson.map.deser.BeanDeserializer.deserializeFromObject(BeanDeserializer.java:683) at org.codehaus.jackson.map.deser.BeanDeserializer.deserialize(BeanDeserializer.java:580) at org.codehaus.jackson.map.ObjectMapper._readMapAndClose(ObjectMapper.java:2732) at org.codehaus.jackson.map.ObjectMapper.readValue(ObjectMapper.java:1817)
```


In the following code we can see a `LocalDateTimeSerializer` where we serialize a `LocalDateTime` using the pattern `"yyyy-MM-dd HH:mm:ss"`

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

In the following code we do the opposite operation, from an string with the format `"yyyy-MM-dd HH:mm:ss"` we parse it into a `LocalDateTime` again 

```java

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
In this post we have seen how to create a serializer and a deserializer in Java using the Jackson library. We have seen also that there are alternatives out there to be able for serialization purposes. 

