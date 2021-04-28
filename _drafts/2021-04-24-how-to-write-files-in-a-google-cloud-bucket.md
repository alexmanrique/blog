---
layout: single
title: "How to write files in a Google Cloud bucket"
date: 2021-04-24 10:55:53 +0200
categories: development
comments: true
lang: en
tags: java, backend, gcs
image: 
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/bucket.jpg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@sixteenmilesout?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Sixteen Miles Out</a> on <a href="https://unsplash.com/s/photos/bucket?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef}  

In this post we are going to see how to write files into Google Cloud bucket from a Java Maven application. 

## Google cloud storage

The first thing to know is that a `bucket` in Google Cloud is like a directory in a OS filesystem.  

The Google Cloud storage API allows us to interact with the Google Cloud ecosystem. In the following link we can find documentation of the <a href="https://cloud.google.com/storage/docs/apis?hl=en">API</a>. 

## Adding dependency in the pom.xml file

To use Google Cloud storage API we have to add in the `pom.xml` file the Maven artifact corresponding to the client version that we want to use.

We need to add the following lines in the `pom.xml` file of our Java project. This way we will be able to use the Java classes to use Google Cloud Storage. 

```xml
 <dependency>
    <groupId>com.google.cloud</groupId>
    <artifactId>google-cloud-storage</artifactId>
    <version>[1.113.4]</version>
</dependency>
```

If Intellij IDE is not importing automatically the dependencies we can refresh them in the maven tab, pressing the refresh icon.

## Creating a configuration class 

We need to have a Java file where we set the configuration to be able to connect with Google cloud storage system. We need two things to configure a connection: a bucket name and the credentials.

```java

import com.google.inject.Singleton;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Singleton
@Getter
@Setter
@ToString
public class BucketConfiguration {

    private String bucketName;
    private String googleCloudStorageCredentials;
}

```
and then a properties like `BucketConfiguration.properties`

```java
bucketName = <bucket-name>
googleCloudStorageCredentials = <store-credentials>
```

Typically you will store those credentials in some place like <a href="https://www.vaultproject.io/">vault</a> and not in the code of the application. Then our application should replace the properties placements from the properties file.

> Storing secrets in a repository of software is a bad practise. Don't do it.

## Creating a Google Guice module

Here in this Google Guice module we are going to create a module to provide a `Storage` class to the code that interacts with Google cloud storage. Creating an `Storage` is a detail that our code doesn't need to know and it's a good candidate to be injected. 

If you want to learn more about dependency injection you can read a post around this that I wrote some time <a href="{{ site.baseurl }}{% post_url 2018-02-23-dependency-injection-in-code %}"> ago. </a>

```java

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import com.google.inject.Singleton;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;

public class StorageModule extends AbstractModule {

    private static final String GOOGLE_API_SCOPE = "https://www.googleapis.com/auth/cloud-platform";

    @Override
    protected void configure() {
        //nothing to do here
    }

    @Provides
    @Singleton
    public Storage getStorageConnection(BucketConfiguration googleCloudStorageConfiguration) throws IOException {
        InputStream inputStream = new ByteArrayInputStream(googleCloudStorageConfiguration.getGoogleCloudStorageCredentials().getBytes(Charset.defaultCharset()));
        GoogleCredentials credentials = GoogleCredentials.fromStream(inputStream).createScoped(GOOGLE_API_SCOPE);
        return StorageOptions.newBuilder().setCredentials(credentials).build().getService();
    }
}

```

## Creating a class to interact with Google cloud storage API

In the next class is where we use the `BucketConfiguration` where we have the config, and the `Storage` that both have been injected using Guice. 

```java
@Singleton
public class BucketService {

    private static final String CONTENT_TYPE = "text/plain";
    private final BucketConfiguration bucketConfiguration;
    private final Storage storage;

    @Inject
    public Bucket(BucketConfiguration bucketConfiguration, Storage storage) {
        this.bucketConfiguration = bucketConfiguration;
        this.storage = storage;
    }

    public Blob createFile(String blobName, byte[] fileContent) {
        BlobId blobId = BlobId.of(bucketConfiguration.getBucketName(), blobName);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType(CONTENT_TYPE).build();
        return storage.create(blobInfo, fileContent);
    }
```
In the API documentation we can see that they refer to the logic that we have implemented in previous class as <a href="https://cloud.google.com/storage/docs/uploading-objects?hl=en#storage-upload-object-java">uploading</a> objects.

## Conclusion

In this post we have seen how to write files into Google cloud storage using Java. Hope that this is helpful and that you have learn how to do it if you have to write files in Google Cloud Storage.
