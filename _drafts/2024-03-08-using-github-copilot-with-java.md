---
layout: single
title: "Using Github Copilot with Java"
date: 2024-03-08 09:08:53 +0200
categories: development
comments: true
lang: en
tags: slack
image: images/
---

In this blog post I will talk about my experience using Github Copilot with Java inside Intellij IDE. 

Something that we need to remember is that developers spend much more time reading code than writing code. According to uncle Bob the ratio of time spent reading vs writing is 10 to 1. 

> <a href="https://www.goodreads.com/quotes/835238-indeed-the-ratio-of-time-spent-reading-versus-writing-is"> Indeed, the ratio of time spent reading versus writing is well over 10 to 1. We are constantly reading old code as part of the effort to write new code. ...[Therefore,] making it easy to read makes it easier to write. </a>

Then, let's see how using Copilot can help writing code that is easier to read. 

It's good help when you need to write a loop that iterates over some data structure that you need to traverse. Also when you start typing an String or any other type you don't need to type all letters from the type String because it sees that you are typing this type and then it suggests the whole word.

However if you want to do some refactor using some design pattern 
to reuse code Github Copilot doesn't have the context of all the classes of your code and is not conscious about which design patterns the application is using. 

> It is good for local proposals to accelerate some repetitive code snippets.

It doesn't do magic, it proposes you blocks of code that might be useful sometimes but you need to be aware. 

> It's like an enhanced autocomplete functionality.

For instance if you have a dependency conflict problem in a Java application (check this blog post where I talk about how to solve it) Copilot doesn't tell you exactly what do you need to change that will work. It can suggest you things to try that might work.

In testing it can propose some Mockito statements `when` instructions that 

Conclusions
---------------------
It's more like an assistant rather than replacing you as an engineer. 





