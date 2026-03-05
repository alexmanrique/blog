---
categories: backend streaming kafka
date: 2026-03-05
layout: post
tags:
- kafka
- event-streaming
- distributed-systems
- backend
title: "Kafka Explained: Architecture, Producers, Consumers and Best
  Practices"
---

# 🎯 What is Kafka?

Official definition:

A **distributed streaming platform** for publishing, subscribing to,
storing, and processing streams of events in real time.

In practical terms:

Kafka is a **distributed messaging system** that:

-   Handles **millions of events per second**
-   Stores events **durably**
-   Allows **multiple independent consumers**
-   Guarantees **ordering within partitions**
-   Scales **horizontally**

------------------------------------------------------------------------

# 📐 Core Architecture

## Main Components

    ┌─────────────────────────────────────────────────┐
    │                  Kafka Cluster                  │
    │                                                 │
    │  ┌──────────┐  ┌──────────┐  ┌──────────┐       │
    │  │ Broker 1 │  │ Broker 2 │  │ Broker 3 │       │
    │  └──────────┘  └──────────┘  └──────────┘       │
    │                                                 │
    │  Topic: flight-bookings                         │
    │  ┌────────────┬────────────┬────────────┐       │
    │  │Partition 0 │Partition 1 │Partition 2 │       │
    │  │  Leader:B1 │  Leader:B2 │  Leader:B3 │       │
    │  │Replicas:   │Replicas:   │Replicas:   │       │
    │  │  B1,B2,B3  │  B2,B3,B1  │  B3,B1,B2  │       │
    │  └────────────┴────────────┴────────────┘       │
    └─────────────────────────────────────────────────┘
             ↑                           ↓
        Producers                   Consumers
         (publish)                   (consume)

------------------------------------------------------------------------

# Topics and Partitions

A **topic** is a category or feed of messages.

Example:

``` java
Topic: "flight-bookings"

├── Partition 0: [msg0, msg3, msg6, msg9]
├── Partition 1: [msg1, msg4, msg7, msg10]
└── Partition 2: [msg2, msg5, msg8, msg11]
```

Characteristics:

-   A topic is divided into **partitions**
-   Each partition is an **immutable ordered sequence**
-   Messages are appended to the end (**append-only log**)
-   Each message has a **unique offset**

------------------------------------------------------------------------

## Partitioning Key

The producer decides the partition using a **key**.

``` java
producer.send(new ProducerRecord<>(
    "flight-bookings",
    bookingId,
    bookingData
));
```

Important rule:

**Messages with the same key → same partition → ordering guaranteed**

Example:

    booking-123 → Partition 0
    booking-456 → Partition 1
    booking-123 → Partition 0

------------------------------------------------------------------------

# Replication

Kafka replicates data for fault tolerance.

    Topic: payments (replication-factor: 3)

    Partition 0

    Broker 1 (LEADER)
    [msg0, msg1, msg2]

    Broker 2 (FOLLOWER - ISR)
    [msg0, msg1, msg2]

    Broker 3 (FOLLOWER - ISR)
    [msg0, msg1, msg2]

Key concepts:

### Leader

-   Handles **all reads and writes**
-   Only **one leader per partition**

### Followers

-   Replicate data from the leader
-   Can become leader if the current one fails

### ISR (In-Sync Replicas)

Set of replicas that are fully synchronized.

------------------------------------------------------------------------

## Durability with acks

``` java
props.put("acks", "all");
props.put("acks", "1");
props.put("acks", "0");
```

------------------------------------------------------------------------

# Producers

## Basic Configuration

``` java
Properties props = new Properties();

props.put("bootstrap.servers", "kafka1:9092,kafka2:9092");
props.put("key.serializer",
    "org.apache.kafka.common.serialization.StringSerializer");
props.put("value.serializer",
    "org.apache.kafka.common.serialization.StringSerializer");

props.put("acks", "all");
props.put("retries", 3);
props.put("compression.type", "snappy");

KafkaProducer<String, String> producer =
    new KafkaProducer<>(props);
```

------------------------------------------------------------------------

## Asynchronous Send

``` java
producer.send(record, (metadata, exception) -> {

    if (exception != null) {
        logger.error("Error sending message", exception);
    } else {
        logger.info(
            "partition={} offset={}",
            metadata.partition(),
            metadata.offset()
        );
    }

});
```

------------------------------------------------------------------------

## Synchronous Send

``` java
RecordMetadata metadata = producer.send(record).get();
```

------------------------------------------------------------------------

# Consumers

## Basic Configuration

``` java
Properties props = new Properties();

props.put("bootstrap.servers", "kafka1:9092");
props.put("group.id", "booking-processors");

props.put("key.deserializer",
    "org.apache.kafka.common.serialization.StringDeserializer");

props.put("value.deserializer",
    "org.apache.kafka.common.serialization.StringDeserializer");

props.put("enable.auto.commit", "false");
props.put("auto.offset.reset", "earliest");

KafkaConsumer<String, String> consumer =
    new KafkaConsumer<>(props);
```

------------------------------------------------------------------------

## Poll Loop

``` java
while (true) {

    ConsumerRecords<String,String> records =
        consumer.poll(Duration.ofMillis(100));

    for (ConsumerRecord record : records) {

        process(record.value());

    }

    consumer.commitSync();
}
```

------------------------------------------------------------------------

# Consumer Groups

Example with three partitions:

    Topic: flight-bookings

    Consumer Group: booking-processors

    Consumer 1 → Partition 0
    Consumer 2 → Partition 1
    Consumer 3 → Partition 2

------------------------------------------------------------------------

# Offset Management

Manual commit example:

``` java
enable.auto.commit=false

consumer.commitSync();
```

------------------------------------------------------------------------

# Monitoring

## Producer Metrics

    record-send-rate
    record-error-rate
    request-latency-avg
    buffer-available-bytes

## Consumer Metrics

    records-consumed-rate
    fetch-latency-avg
    commit-latency-avg
    records-lag-max

------------------------------------------------------------------------

# Most Important Metric: Consumer Lag

    Lag = Latest offset - Current offset

Example:

    GROUP              TOPIC           PARTITION  CURRENT  LOG-END  LAG
    booking-processors flight-bookings 0          150      150      0
    booking-processors flight-bookings 1          200      250      50

------------------------------------------------------------------------

# Conclusion

Kafka is a core building block of modern event-driven architectures.

Key strengths:

-   Horizontal scalability
-   High durability
-   Massive throughput
-   Strong ecosystem

Used heavily in:

-   fintech
-   ecommerce
-   streaming platforms
-   data platforms
