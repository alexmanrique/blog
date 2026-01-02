---
layout: single
title: "Using Cursor AI to develop"
date: 2025-08-02 09:08:53 +0200
categories: development
comments: true
lang: en
tags: ai, cursor, mcp, mysql, database, llm
image: images/llm.jpg
---

{:refdef: style="text-align: center;"}
![AI Database Integration]({{ site.baseurl }}/images/llm.jpg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@almoya?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Aerps.com</a> on <a href="https://unsplash.com/photos/a-laptop-displays-a-search-bar-asking-how-it-can-help-0Jk1QCGMz5o?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
{: refdef}

In this blog post I'm going to write my opinion on using Cursor AI to develop. 

I'm using the chat Agent of Cursor AI where I chat with the Agent to develop changes in the project that I'm working.

The most important point using Cursor is that you need to use a Control version System like Git this way everytime that Cursor proposes you a group of changes you can rollback easily what has been changed, this is a good safety net.

By default in Cursor you have `Auto` that chooses the LLM for you but it's not the best model that you can use for your coding tasks. You can select Claude sonnet in case that you want to use this model to perform the coding tasks. 

To use MCP you need an specific file called `./cursor/mcp.json` where you define which MCP's you will have available to develop. We talked about them in a previous post. 

Cursor adds files everytime that there's a change and you have to remove code that might not be useful or it's dead code that is not used anywhere, is like it's not taking into account all the code that has generated and then the cleaning has to be done manually. It's prone to duplicate code so you have to tell explicetely that reuses code from another place to avoid repeating code one of the sins in developing software that is to duplicate code. 

It can be useful for testing because it can do curls to your application locally or in production, however once it has performed one time testing is like for every change it tries to test it automatically, also if you commit and push to your git repository one time, then also for every change it tries to commit and push automatically something annoying because before commiting to the repository I want to test that changes performed are working and there's no issue. 

If you are using some framework in your application is good that you share the documentation of the framework that you are using in order to give context. 

I want to try how it works using templates that you have in <a href="https://cursor.directory/">cursor</a> directory where there are prompts that allow you to develop like a senior developer and check if the quality of the results that the agent gives you improves.  

The way that we develop has changed a lot during the last year with a lot of new tools that help us do our work but we have to know how all this tools work and be challenging with what the models provide us, because it can be that a method for a function doesn't exist or that you have a problem and cursor wants to reinvent the wheel because it doesn't know that there's a library or a service that helps you to do that.

Where I have found more difficulties is when you have to develop things for the frontend, once you have the skeleton of what you want, it's really difficult when the view is not beauty enough to specify what is wrong and how you want it to be changed. You need to have basic concepts of CSS because our natural language is not as specific as the css rules that give you a really wide set of options to specify visual things. It's easy to share with cursor a design of what you want to be accomplished but once this is implemented changing something is not as easy. 

Testing. When you ask to the agent to write unit tests, It wrote tests that were depending on a database which is not ok as unit tests should only the class/file that you are testing and not depending on a external system.

Use /"add current open files to the context"

Check the context window percentage that you are using. Open new chat agent windows when developing different features and functionalities.
