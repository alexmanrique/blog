---
layout: single
title: "Experiment, measure and learn"
date: 2019-06-01 00:13:53 +0200
categories: development
comments: true
lang: en
tags: data 
---

Experiment instead of investigating
----------------------------------------
Nowadays it’s more important than ever to use data in order to take decisions to evolve your product/service to be customer oriented. 

Sometimes you don’t know if a button with a color will be more attractive to customers, or if a <a href="https://en.wikipedia.org/wiki/Landing_page">landing page</a> would generate more interactions with your website. 

> Instead of spending a lot of time investigating if some change is better than what we currently have is better to test changes in a small scope and get feedback on your ideas.

{:refdef: style="text-align: center;"}
![Traditional approach]({{ site.baseurl }}/images/measure.png)
{: refdef} 

Collect data
---------------------------------
The first thing that you should do is to collect data about how your customers are interacting with your product/service. In the following list, you have my favorite ones.

- Google analytics
- Elasticsearch
- Other data sources (Mysql, Oracle, Postgresql)

Metrics
----------------------------------
> Measure what matters and what you can have an impact on it. 

If you measure something that you can’t have an impact it will demotivate you and your team. When you can’t impact the metrics that you are monitoring it means that these metrics are not the right ones to monitor and measure.

In the following list, we have the metrics that I particularly like to monitor in the websites that I'm involved in.

- Bounce rate
- Click rate
- Time in the page
- Pages per session
- Conversions
- Offline sales
 
Visualize data and check metrics
---------------------------------
If you don’t have a place where you can check visually that your metrics are fine you are not really in control of them.

> Choose the right visualization tool that helps you to monitor your key performance indicators according to your needs. 

- Google analytics dashboards
- Grafana
- MicroStrategy 
- Kibana dashboards

In the following Google analytics dashboard we can see that two campaigns of Google Ads are generating a bounce rate of 70% which means that the customers don't interact with the website to navigate to other pages of the website. 

{:refdef: style="text-align: center;"}
![Traditional approach]({{ site.baseurl }}/images/bounce_rate.png)
{: refdef} 

This leads us to think that an improvement should be done in the 2 campaigns to avoid this high bounce rate.

Compare to take decisions 
----------------------------------
Apart from collecting data, you have to compare features, changes in your product in order to decide which feature will be the one that you keep in your system/application/website.

I.e: We want to redesing our landing page and we want to do it more attractive. We have to redirect customers 50% to the old landing page and 50% to the new one. 

The outcome expected from this change will be more clicks done in the page, more time spent in the page or less bounce rate. 

A/B testing
----------------------------------

This concept is called <a href="https://en.wikipedia.org/wiki/A/B_testing">A/B testing</a> and is oftenly used in the industry to run experiments and it's a good technique to compare features, designs ...

If you have a website and you want to test if small changes in your website work better for your clients you can use <a href="http://optimize.google.com">Google Optimize</a> to run A/B's and take decisions about what is the best user experience. 

Including a Javascript snipped in the page that you want to run an experiment will enable you to modify (from Google Optimize) texts, pictures of the page that is under test.

{:refdef: style="text-align: center;"}
![Traditional approach]({{ site.baseurl }}/images/a_b_Testing.png)
{: refdef} 


Conclusion
-----------------------------------
All this concepts are important nowadays to be able to evolve your products or services in a customer oriented way. Sometimes you don't know how a feature or a design change will impact your metrics. 

For that, you need to measure things, learn from your experiments and build (or discard) according to your learnings.









  












