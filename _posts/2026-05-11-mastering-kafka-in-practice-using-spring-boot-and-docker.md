---
layout: single
title: "Kafka in Practice: Encoding Production Knowledge into Tests"
date: 2026-05-11
categories: kafka java spring-boot
comments: true
lang: en
tags: kafka spring-boot avro schema-registry integration-tests
image: https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=1200&h=600&fit=crop
---

{:refdef: style="text-align: center;"}
![Data streaming and pipelines](https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=1200&h=600&fit=crop)
{: refdef}

Knowing Kafka theory is one thing — demonstrating it with working code is another. In this post, I walk through a project I built to capture the most important Kafka concepts in executable tests, using Spring Boot and an embedded broker. Each test encodes a specific behavior that I've dealt with in production and wanted to have as a reference.

The full source code is available on [GitHub](https://github.com/alexmanrique/kafka-tests).

## The Setup

The project is intentionally simple: a Spring Boot application with a REST endpoint to produce messages, and a set of integration tests that demonstrate different Kafka behaviors. No mocks — real Kafka (embedded) running in the tests.

```yaml
# docker-compose.yml — for local experimentation
services:
  kafka:
    image: apache/kafka:3.9.0
    ports:
      - "9092:9092"
    environment:
      KAFKA_NODE_ID: 1
      KAFKA_PROCESS_ROLES: broker,controller
      KAFKA_LISTENERS: PLAINTEXT://:9092,CONTROLLER://:9093
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:9092
      # ... KRaft mode, no Zookeeper needed

  schema-registry:
    image: confluentinc/cp-schema-registry:7.6.0
    ports:
      - "8081:8081"
```

For tests, I use `@EmbeddedKafka` from Spring Kafka Test, which spins up a real broker in-process. No Docker needed to run the test suite.

---

## 1. Producer Acknowledgments (acks)

The `acks` setting controls how many brokers must confirm a write before the producer considers it successful.

```java
@Test
@DisplayName("acks=all - Waits for leader + all in-sync replicas acknowledgment")
void acksAll_fullReplication() throws Exception {
    KafkaProducer<String, String> producer = createProducer("all");

    for (int i = 0; i < 100; i++) {
        ProducerRecord<String, String> record =
                new ProducerRecord<>("test-acks", "key-" + i, "msg-" + i);
        RecordMetadata metadata = producer.send(record).get(5, TimeUnit.SECONDS);
    }
    producer.close();
}
```

**Worth noting:** With a single broker, `acks=1` and `acks=all` behave identically because there's only one replica. The real difference appears in multi-broker clusters. Also, JVM warmup effects can mislead benchmark results — always do a warmup run first.

| acks  | Behavior                 | Risk                                            |
| ----- | ------------------------ | ----------------------------------------------- |
| `0`   | Fire and forget          | High (message may be lost)                      |
| `1`   | Leader confirms          | Medium (lost if leader dies before replication) |
| `all` | All ISR replicas confirm | Minimal                                         |

---

## 2. Batching: Trading Latency for Throughput

Kafka producers don't send messages one by one. They batch them. Two key parameters control this:

- **`linger.ms`**: How long to wait for more messages before sending a batch.
- **`batch.size`**: Maximum batch size in bytes.

```java
private KafkaProducer<String, String> createProducer(int lingerMs, int batchSize) {
    Properties props = new Properties();
    props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, broker.getBrokersAsString());
    props.put(ProducerConfig.LINGER_MS_CONFIG, lingerMs);
    props.put(ProducerConfig.BATCH_SIZE_CONFIG, batchSize);
    // ...
    return new KafkaProducer<>(props);
}
```

The test sends 5000 messages with different configurations and measures throughput. The results speak for themselves:

```
==========================================================================
  BATCHING COMPARISON (5000 messages)
==========================================================================
  Configuration                              Time   Throughput  Batches  Msg/Batch
  linger=0ms,  batch=0 (no batch)           1200 ms    4167/s     5000       1.0
  linger=5ms,  batch=16KB                    180 ms   27778/s      210      23.8
  linger=50ms, batch=64KB                    130 ms   38462/s       45     111.1
==========================================================================
```

**Key tradeoff:** Increasing `linger.ms` adds milliseconds of latency per message but can multiply throughput by 10x. In high-volume pipelines, this is a critical tuning parameter.

---

## 3. Idempotent Producer: Exactly-Once Per Partition

With `enable.idempotence=true`, Kafka assigns a Producer ID (PID) and sequence number to each message. If a network retry causes a duplicate send, the broker detects it and discards the duplicate.

```java
props.put(ProducerConfig.ENABLE_IDEMPOTENCE_CONFIG, true);
// Forces: acks=all, retries=MAX_VALUE, max.in.flight<=5
```

**Critical nuance:** Idempotence protects against _network-level_ retries (the Kafka client automatically resends). It does NOT protect against _application-level_ retries (your code calling `send()` twice). Each explicit `send()` gets a new sequence number. The test makes this distinction explicit.

---

## 4. Failure Handling: delivery.timeout.ms

In modern Kafka, you don't tune `retries` directly. Instead, you set `delivery.timeout.ms` — the total time budget for delivering a message, including all retries and backoffs.

```java
props.put(ProducerConfig.DELIVERY_TIMEOUT_MS_CONFIG, 5000);  // 5s total
props.put(ProducerConfig.REQUEST_TIMEOUT_MS_CONFIG, 1500);   // 1.5s per attempt
props.put(ProducerConfig.RETRY_BACKOFF_MS_CONFIG, 300);      // 300ms between retries
```

The test points the producer at a non-existent broker and measures how long it takes to give up. The results confirm that `delivery.timeout.ms` is the controlling factor:

```
  delivery.timeout=3s  → failed after 3012 ms
  delivery.timeout=5s  → failed after 5008 ms
```

---

## 5. Consumer Offset Management

This is where senior-level understanding really matters. The project covers five strategies:

### The Robust Pattern:

```java
try {
    while (running) {
        ConsumerRecords records = consumer.poll(Duration.ofMillis(100));
        process(records);
        consumer.commitAsync();  // Non-blocking, best throughput
    }
} finally {
    consumer.commitSync();  // Guarantees last offset on shutdown
    consumer.close();
}
```

Why this works:

- `commitAsync()` in the loop: if one commit fails, the next one (with a higher offset) corrects it.
- `commitSync()` in finally: on shutdown (SIGTERM, rebalance), you need the guarantee that the last offset is persisted.

---

## 6. Rebalancing and ConsumerRebalanceListener

When a consumer joins or leaves a group, Kafka redistributes partitions. The `ConsumerRebalanceListener` is your hook to react:

```java
consumer.subscribe(List.of(topic), new ConsumerRebalanceListener() {
    @Override
    public void onPartitionsRevoked(Collection<TopicPartition> partitions) {
        // Last chance to save offsets before losing partitions
        consumer.commitSync(currentOffsets);
    }

    @Override
    public void onPartitionsAssigned(Collection<TopicPartition> partitions) {
        // Initialize state for newly assigned partitions
    }
});
```

**Important:** Without `commitSync()` in `onPartitionsRevoked`, the next consumer to receive the partition starts from the last committed offset (potentially stale), causing message reprocessing.

---

## 7. Zombie Consumers: max.poll.interval.ms

This is a production incident waiting to happen. If your processing takes longer than `max.poll.interval.ms` (default: 5 minutes), Kafka expels the consumer from the group. But the consumer doesn't know — it becomes a **zombie**, processing messages that already belong to someone else.

```java
// Trigger zombie behavior
props.put(ConsumerConfig.MAX_POLL_INTERVAL_MS_CONFIG, 3000); // 3s

consumer.poll(Duration.ofMillis(2000));
Thread.sleep(5000); // Exceeds max.poll.interval.ms
// Next poll() triggers rebalance — partitions revoked
```

**Mitigation:** Use `max.poll.records` to limit batch size so processing stays within the interval:

```java
props.put(ConsumerConfig.MAX_POLL_INTERVAL_MS_CONFIG, 4000);
props.put(ConsumerConfig.MAX_POLL_RECORDS_CONFIG, 2); // Small batches
```

---

## 8. Schema Registry and Avro

Plain JSON in Kafka topics is a ticking time bomb. Schema Registry + Avro gives you:

- **Contracts** between producers and consumers
- **Compatibility checks** on write (fail fast)
- **Schema evolution** without breaking consumers

```java
Schema schemaV2 = SchemaBuilder.record("Order")
        .fields()
        .requiredString("orderId")
        .requiredString("product")
        .requiredInt("quantity")
        .name("status").type().stringType().stringDefault("PENDING") // New field with default
        .endRecord();
```

Adding a field with a default value is BACKWARD compatible: new consumers can read old messages (the default fills in the missing field). Adding a required field without a default is incompatible — the registry rejects it.

---

## Running the Project

Everything runs with a single command:

```bash
cd producer && mvn test
```

No Docker, no external dependencies. The embedded Kafka broker makes the tests self-contained and CI-friendly. The GitHub Action runs on every push:

```yaml
- name: Build and test
  run: mvn -B verify --file pom.xml
```

---

## Final Thoughts

The goal of this project was to have a living reference — code that captures the behaviors I've encountered working with Kafka, not just documentation I've read. A few points worth highlighting:

1. **acks benchmarks are misleading** on a single broker — warmup effects dominate.
2. **Idempotence has a boundary** — it's per-partition, per-session, network-level only.
3. **Zombie consumers are subtle** — the heartbeat thread keeps running even when the consumer is expelled.
4. **Schema evolution rules** are straightforward once internalized: new fields need defaults for backward compatibility.

If you work with Kafka regularly, I recommend building something similar. Having executable tests that demonstrate each behavior is far more useful than bookmarking documentation pages — especially when you need to explain a design decision to your team or debug a production issue.
