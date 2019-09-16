---
layout: single
title: "Release on Friday"
date: 2019-09-16 00:13:53 +0200
categories: development
comments: true
lang: en
tags: release, software, 
---

Release software to production is the action to deliver software to your customers. From the moment that somebody thinks of a good idea until we release it, there are several steps in the process but to do it quickly and do it at the right time is not always easy.  

Monitor the release
----------------------------------------------------------------
You need to have in place metrics that allow you to decide whether you should rollback the release or you should promote the release to full site if you have not deployed it in all your platform. The metrics can be related to business (sales, leads, conversions, searches …) or technical (response times, number of bad requests...)

Release on friday?
-----------------------------------------------------------------
Maybe you are the owner of a service, where you do changes daily and you release often to production. It’s Friday and you have a new feature that you want to try in an A/B test. Is it a good moment of the week to do it?

When not to release software?
------------------------------------------------------------------
If you release on Friday and there’s a problem your week will become a 12 day week because you will have to work in the weekend monitoring the software that you have uploaded to production. You won't be able to rest and disconnect.

Rollback - everyone can do mistakes
-------------------------------------------------------------------
Sells are failing and you are out of the office, then someone calls you because you are the owner of the service and you are the one that can fix the issue. Then you realize that there is a bug in the code because you see it in the logs of your system. The decision that you take is doing a rollback to the previous version that was working fine but without the new feature and when you come back to the office on Monday you will do the fix.

Postmortem - a good tool
----------------------------------
Doing a post-mortem meeting is a good way to asses what was the root cause of the problem. Maybe a corner case that was not considered, and because of that, there was not any functional test (or a unit test) related to this. Maybe a bad configuration somewhere, maybe a dependency that was down... A lot of things can happen when we release software, our job is to reduce the probability to fail before doing the release.

Scope change should be small
--------------------------------------------------------------------
If you release one feature in every release is better to do it than all in a single release with let's say 100 new features. If you do one feature per release you will be able to control better each new feature if it's good or not for your customers, and get feedback and take actions according to it. If you do a rollback you will do a rollback of a single feature and not a collection of features. Why doing a rollback of 99 features that are good because there is one that is failing?

Conclusion
--------------------------------------------------
Release software with small scope and don't do it on Friday before leaving the office. It's better to release often with few changes than few times with a lot of changes. If you have to rollback a postmortem is a good tool to improve and avoid mistakes for the future.

















  












