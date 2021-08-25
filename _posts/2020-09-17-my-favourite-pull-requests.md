---
layout: single
title: "Removing code without removing functionality"
date: 2020-09-17 02:00:53 +0200
categories: development
comments: true
lang: en
tags: developer, code, job
image: images/pull-requests.jpg 
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/pull-requests.jpg)
{: refdef}

In this post we are going to talk about removing code. Removing code means maintaining less code and the less code that you have, the fewer bugs in your codebase. 

Remove code without removing functionality
---------------------------------------------
Removing code is good if you don't remove functionality, unless you have been asked to do so or that you detect that some functionality is not used. 

To know if something is used or not, using data helps. Imagine that you have a tool that allows you to create different kinds of promo codes. 

You have different kinds of promo codes and you see in the data storage that only one kind of promo codes is created. Here you have a good candidate to remove the code that allows you to create the other kinds of promo codes. Before doing it you should double check with your business partner that this functionality is not used.

> Don't be afraid to do that and don't be attached to that piece of code. Just remove it. 

The magic of removing code
--------------------------------
When you remove code your <a href="{{ site.baseurl }}{% post_url 2020-04-26-increase-coverage-in-your-java-code %}"> code coverage</a> which is the number of lines of code covered by unit tests will increase (in case that the code that you are removing was not covered by unit tests) and that's positive too. 

It's better to have good unit tests and good functional tests rather than having really high code coverage testing "getters" and "setters", I talk about this in this <a href="{{ site.baseurl }}{% post_url 2020-04-26-increase-coverage-in-your-java-code %}">post</a> that I wrote some time ago.

As I said in a previous post, we are <a href="{{ site.baseurl }}{% post_url 2020-09-09-you-are-not-paid-to-code %}"> not paid to write code</a> and if we can keep the same functionalities with less code it means that our codebase is simpler with fewer dependencies and simpler to read, comprehend and maintain.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">My favorite kind of programming 😍 <a href="https://t.co/bnpzh2kUPU">pic.twitter.com/bnpzh2kUPU</a></p>&mdash; DHH (@dhh) <a href="https://twitter.com/dhh/status/1265448226804518912?ref_src=twsrc%5Etfw">May 27, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

In my experience developers agree about deleting code, it can happen that they didn't know about the code that will be deleted, but then the <a href="{{ site.baseurl }}{% post_url 2018-01-31-the-importance-of-code-reviews %}">code review</a> it's a good way to share that this code is not needed anymore. 
 
Sources of dead code
---------------------------------------
- Legacy product features: We have talked about this in the previous paragraph. When we detect that some feature is not used we can get rid of it. No matter if this was requested by some product owner guru or some important person in your company. Just remove it.
- Wizard generated UI code: There are tools that allow you to do some starter code. This can be a source of code to be considered to remove. 
- Return values of functions not used: This is an example of a code that is not used. Return values if are not used by the caller it means that the lines of code that calculate/process this value can be considered to get removed. 

How to remove code
--------------------------------------------
The first thing that you need to do is to create a <a href="https://en.wikipedia.org/wiki/Branching_(version_control)">branch</a> of the repository that you want to remove code. Quite helpful to do this removal are grey colors in methods or attributes in <a href="https://www.jetbrains.com/idea/">Intellij</a>. If there's a method that is not used the IDE warns you with this color and encourages you to take some action on that.

There's an option also in Intellij that allows you to inspect your code. You have to go to Analyze > Inspect Code

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/inspect_code.png)
{: refdef}

With this option, you can find code smells, warnings, potential bugs that you can have in your code and that you should be aware of. Some of them you will have to fix it, some code will be elegible to be removed and some other will be necessary to refactor. 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/inspect_code_results.png)
{: refdef}

Conclusion
----------------------------
In this post, we have talked about the importance of removing code, this way we reduce the number of lines of code without decreasing the functionality of our product/service, that will lead to fewer bugs and we will have more time to do other things because the time of maintenance is lower.








