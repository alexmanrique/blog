---
layout: single
title: "Using Github Copilot with Java in Intellij IDEA"
date: 2024-03-08 09:08:53 +0200
categories: development
comments: true
lang: en
tags: github, copilot, intellij
image: images/github-copilot.png
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/github-copilot.png)
{: refdef}
{:refdef: style="text-align: center;font-size:9px"}


In this blog post I will talk about my experience using Github Copilot with Java inside Intellij IDE. 

Something that we need to remember is that developers spend much more time reading code than writing code.According to uncle Bob the ratio of time spent reading vs writing is 10 to 1. 

> <a href="https://www.goodreads.com/quotes/835238-indeed-the-ratio-of-time-spent-reading-versus-writing-is"> Indeed, the ratio of time spent reading versus writing is well over 10 to 1. We are constantly reading old code as part of the effort to write new code. ...[Therefore,] making it easy to read makes it easier to write. </a>

Then, let's see how using Copilot can help writing code that is easier to read. 

Copilot Chat is working with ChatGPT as backend so it has the same conversational capabilities as ChatGPT, it can povide long answers not only code answers.

Suggestions 
-------------------------
The code that is automatically generated while you type in your IDE. Copilot can suggest code completions as you type, based on the context of your current code. 

> It's like an enhanced autocomplete functionality.

It can complete entire lines of code, function signatures, or even entire functions.

Chat Prompts 
-------------------------
Prompt ideas for Copilot Chat:
- Does this code have errors? Does something similar to what Findbugs would do. 
- Is this code secure?
- Code review focusing on best practises such as code mantainability, security vulnerabilities and performance. 
- What is the code complexity of this piece of code? Can I improve it by using other Data Structures?
- Create unit tests using testNG with the format testGivenXWhenYThenZ. Don't use @Inject or @Mock annotations. Don't use imports with *. Don't use any() mockito functions. Add specific verify clauses for the number of invocations. Make sure to include test cases for all the branches of the code. Don't explain and just give the consolidated code. 
- Refactor code to use the latest Java versions
- Refactor this using Java 17.
- Reduce code complexity.
- "Select some code" -> Refactor this code using Strategy pattern 
- This code is too complex, is there any pattern that would help me simplify or abstract the code? Give me specific code examples.

Chat Slash commands
---------------------------
- /tests : it generates the testing cases for your code.
- /simplify : it can give you ideas to simplify the code.
- /fix : it looks for fixes in the code
- /explain : helps you understand the code that you are working with.
- /doc : it can help you writing documentation 
- /feedback : 

You need to select the code in Intellij IDEA and after that in the Copilot Chat use some of the previous slash commands

Conclusions
---------------------
It doesn’t do magic, it suggests you blocks of code that might be useful sometimes but you need to be aware.

For instance if you have a dependency conflict problem in a Java application (check this blog post where I talk about how to solve it) Copilot doesn’t tell you exactly what do you need to change that will work. It can suggest you things to try that might work.

Visual Studio Code copilot plugin seems way more advanced than Intellj one and a lot of information on the Internet is about Visual Studio Code.

To conclude I would say It's more like an assistant rather than replacing you as an engineer. 





