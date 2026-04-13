---
layout: single
title: "Migrating an A/B Testing API to Google Cloud: Zero Downtime and a Non-Blocking Cache"
date: 2026-04-13 14:00:00 +0200
categories: architecture backend
comments: true
lang: en
tags: java guava google-cloud oracle datadog migration caching ab-testing
image: https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1200&h=600&fit=crop
---

{:refdef: style="text-align: center;"}
![Global connectivity and infrastructure](https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1200&h=600&fit=crop)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@nasa?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">NASA</a> on <a href="https://unsplash.com/s/photos/network?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef}

In 2019 I led the migration and performance work for our company-wide **A/B testing platform** — the system product teams use to run experiments and read assignment in production. This post is a concise case study: why downtime was unacceptable, what we found in pre-migration review, how we fixed blocking cache refreshes with **Java** and **Guava**, and how we rolled out to **Google Cloud** without taking the API offline.

## Product context

The platform has two main pieces:

- **REST API** — on the order of **112 million requests per day** from product teams across the company.
- **Admin tool** — where product managers configure experiments, set traffic splits (for example 50% / 50%), and manage rollouts and rollbacks.

If the API is unavailable, teams cannot run experiments or trust measurement in production. That set a high bar for the migration.

## The challenge

We needed to move this API from **on-premise** infrastructure to **Google Cloud** with **zero tolerance for downtime**: a hard outage blocks experimentation and reporting for everyone.

During **pre-migration code review**, I found a serious performance problem tied to our cache policy. Every **30 minutes** the service refreshed configuration from **Oracle** with **blocking** queries. During those windows, servers could become **unresponsive**, latency spiked, and we occasionally **failed to return** experiment configuration to callers. That behavior was incompatible with a safe cloud cutover at scale.

## Technical solution

I implemented a **Guava**-based asynchronous cache loader with three ideas:

1. **Stale-while-revalidate** — Serve cached data immediately (it may be slightly stale) while a **background** refresh runs against the database.
2. **Non-blocking requests** — Incoming traffic never waits on the refresh; only the async loader pays the Oracle cost.
3. **Local cache per instance** — Each node held its own cache. We discussed **Redis** as a shared layer, but roadmap and delivery pressure pointed to local caching first.

This aligns with the pattern I wrote about earlier on [avoiding blocking calls when loading a cache in Java]({{ site.baseurl }}{% post_url 2020-05-10-avoid-blocking-calls-in-a-cache-using-java %}) — here it was not theoretical; it was a prerequisite for a reliable migration.

## Migration strategy

We used an **incremental rollout** over about a week:

- **Day 1:** **10%** of traffic to Google Cloud, **90%** still on-premise.
- **Deployments** at **6:00 AM** in the lowest-traffic window.
- **Daily** increases in the cloud share, with **Datadog** dashboards as the gate for the next step.
- Close work with **DevOps**, who owned the Google Cloud footprint, so networking, capacity, and runbooks stayed aligned.

We did not advance the percentage until metrics looked healthy at the current slice.

## Trade-offs

**Redis vs. local cache** — A shared Redis cache would have been a clean central abstraction. We chose **local Guava caches** because the team was product-led, time was tight, and we wanted **less operational surface** during a risky migration. We still got a large win: **no blocking refresh** and predictable request paths.

**Stale data** — Experiment configuration could tolerate a **~30 minute** freshness window (our policy already implied that). Trading a bounded staleness for **no blocking** and **better availability** was the right call for this use case.

## Org context

This was **technical debt** inside a product org: the PM was rightly focused on customer-facing roadmap. I had to **negotiate** explicit time for infrastructure work so we did not ship the migration on top of a known performance foot-gun.

## Impact

- **Zero downtime** across the migration.
- **Removed** the refresh-induced stalls that had been hurting the fleet.
- **Migrated** the full **112M requests/day** workload to Google Cloud.
- **Sustained availability** for teams running experiments (our bar was no customer-visible regression from the migration itself).
- A **repeatable pattern** for later high-traffic API moves: review before cutover, fix the hot path, then ramp traffic with observability gates.

## Stack

| Area | Technologies |
|------|----------------|
| Backend | Java, Guava Cache |
| Database | Oracle |
| Cloud | Google Cloud |
| Monitoring | Datadog |
| Delivery | Incremental rollout with DevOps |

---

*This post is based on a real migration and optimization effort; figures and timelines reflect the project as I remember it.*
