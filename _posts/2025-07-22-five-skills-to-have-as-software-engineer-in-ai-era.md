---
layout: single
title: "5 Skills Software Engineers Should Learn in the Age of AI"
date: 2025-07-22 09:08:53 +0200
categories: development
comments: true
lang: en
tags: ai, cursor, context 
image: images/llm.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/llm.jpg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@almoya?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Aerps.com</a> on <a href="https://unsplash.com/photos/a-laptop-displays-a-search-bar-asking-how-it-can-help-0Jk1QCGMz5o?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a> 
{: refdef} 

---

It’s been over a year since I last posted on the blog, and the truth is that everything has changed a lot in a very short time — especially the way we, as software engineers, develop software. That’s why I’d like to talk about the five skills you should learn as a software engineer in the age of artificial intelligence.

## 1. Context Engineering

We're no longer just talking about writing the best prompt for a large language model (LLM). What we need to do is give our code editor the best possible **context** to get the job done.

In your favourite IDE like Cursor, Windsurf, Visual Studio Code it would be good that you specify the following files:

### `product.md`

A Markdown file describing our product. Here we explain all the characteristics that make our product unique, so the AI understands what we’re building.

### `design.md`

In this file, we specify the technologies we want to use for the project.  
If we don’t include anything, the AI will try to guess, and will most likely choose **React** and **Next.js**.

### `structure.md`

This file defines the folder structure of our application, helping the AI understand how to organize the project.

If you don’t do that, the LLM will try to guess what you want and may use something popular like React or TypeScript for the frontend.

Editors like [**Kiro**](https://kiro.dev/) (launched by Amazon recently) already force you to define these specifications before you even start coding.

---

## 2. Proper Vibe Coding

Knowing how to do *vibe coding* correctly is essential. **Blindly accepting** everything the LLM agent suggests is not good practice.

You need to:

- **Review** the proposed changes critically  
- **Ensure** they align with your goals and intentions  

> The AI is a helpful assistant, not an infallible expert.

---

## 3. Understanding Model Context Protocol (MCP)

The **[Model Context Protocol (MCP)](https://www.anthropic.com/index/model-context-protocol)** is a protocol developed by [**Anthropic**](https://www.anthropic.com/), allowing LLMs to communicate with external systems (e.g., a MySQL database). Think of it like a USB port for AI.

For example, I used a MySQL MCP within [**Cursor**](https://www.cursor.sh/), and it was amazing. I asked it to create a blog for my app, and it:

- Suggested three database tables  
- Created them  
- Populated them with data  

One of the most talked-about MCPs is the one from [**Supabase**](https://supabase.com/edge-functions/mcp) — I haven’t tried it yet, but it seems to be gaining traction.

> ⚠️ **Be careful** downloading MCPs from unknown sources — they can be an attack vector. Always prioritize security.

---

## 4. Product Engineering

You need to understand what will truly **add value** to your end users. Delivering features that don't help or hurt key metrics is pointless.

Some things to focus on:

- Understand user behavior through [**A/B testing**](https://en.wikipedia.org/wiki/A/B_testing)  
- Learn key product metrics like **[conversion rate](https://en.wikipedia.org/wiki/Conversion_rate_optimization)** and **[lifetime value (LTV)](https://www.shopify.com/blog/customer-lifetime-value)**  
- Build and release **MVPs** (Minimum Viable Products) to validate usefulness  

> 💡 **You’re not paid to write code. You’re paid to deliver value.**

Approach development from a technical perspective, yes — but always with the product in mind.

---

## 5. Communication

Being able to **communicate your value** is just as important as delivering it.

If you ship a feature but can’t explain its impact, you’re missing out. Look at companies like [**OpenAI**](https://openai.com/), [**Anthropic**](https://www.anthropic.com/), or [**Microsoft**](https://blogs.microsoft.com/blog/tag/ai/): when they release a new feature, they also publish a video explaining its **benefits and use cases**.

If you’ve:

- Reduced the **load time** of your site’s most visited page  
- Fixed a **critical bug**  
- Improved the **user experience**  

…make sure your team and your organization know about it.

> 🗣️ Even in the age of AI, the **human side** still matters. Communication — written and spoken — will be a major differentiator in your career.

---

In this post we have seen 5 skills important in the age of AI, would you add any skill in the list?   
