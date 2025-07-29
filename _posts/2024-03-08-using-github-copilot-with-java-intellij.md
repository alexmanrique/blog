---
layout: single
title: "Using GitHub Copilot with Java in IntelliJ IDEA"
date: 2024-03-08 09:08:53 +0200
categories: development
comments: true
lang: en
tags: github, copilot, intellij, java, ai, development
image: images/github-copilot.png
---

{:refdef: style="text-align: center;"}
![GitHub Copilot with Java]({{ site.baseurl }}/images/github-copilot.png)
{: refdef}
{:refdef: style="text-align: center;font-size:9px"}
{: refdef}

In this blog post, I'll share my experience using GitHub Copilot with Java development in IntelliJ IDEA. As AI-powered coding assistants become more prevalent, understanding how to effectively use them can significantly improve your development workflow.

## The Reading vs Writing Code Reality

Before diving into Copilot, it's important to understand a fundamental truth about software development: **developers spend much more time reading code than writing code**.

According to Uncle Bob (Robert C. Martin), the ratio of time spent reading versus writing code is well over 10 to 1:

> <a href="https://www.goodreads.com/quotes/835238-indeed-the-ratio-of-time-spent-reading-versus-writing-is">"Indeed, the ratio of time spent reading versus writing is well over 10 to 1. We are constantly reading old code as part of the effort to write new code. ...[Therefore,] making it easy to read makes it easier to write."</a>

This insight is crucial because it means that any tool that helps us write more readable code is incredibly valuable. Let's explore how GitHub Copilot can assist in this regard.

## What is GitHub Copilot?

GitHub Copilot is an AI-powered coding assistant that integrates directly into your IDE. It uses OpenAI's Codex model to provide intelligent code suggestions, completions, and even entire function implementations based on the context of your current code.

### Key Features

- **Real-time code suggestions** as you type
- **Context-aware completions** based on your project structure
- **Copilot Chat** for interactive assistance
- **Slash commands** for quick actions

## Setting Up GitHub Copilot in IntelliJ IDEA

### Prerequisites

Before you begin, ensure you have:

- IntelliJ IDEA (Community or Ultimate edition)
- An active GitHub Copilot subscription
- Java project configured in IntelliJ

### Installation Steps

1. **Install the GitHub Copilot Plugin**:

   - Go to `File` → `Settings` → `Plugins`
   - Search for "GitHub Copilot"
   - Install and restart IntelliJ

2. **Authenticate with GitHub**:

   - Go to `File` → `Settings` → `Tools` → `GitHub Copilot`
   - Click "Sign in to GitHub"
   - Follow the authentication process

3. **Enable Copilot**:
   - Ensure the plugin is enabled in your project
   - You should see Copilot suggestions as you type

## Using GitHub Copilot with Java

### Code Suggestions

The most basic feature is **automatic code suggestions** that appear as you type. Copilot can:

- Complete entire lines of code
- Suggest function signatures
- Generate entire methods based on comments
- Provide context-aware variable names

> **Pro Tip**: Think of it as an enhanced autocomplete that understands your project's context and coding patterns.

### Copilot Chat Integration

Copilot Chat works with ChatGPT as its backend, providing conversational capabilities beyond simple code completion. You can ask questions, request explanations, and get detailed responses about your code.

## Effective Prompts for Java Development

Here are some proven prompts that work well with Java development in IntelliJ:

### Code Quality and Review

```
- Does this code have errors? (Similar to what FindBugs would detect)
- Is this code secure?
- Code review focusing on best practices such as maintainability, security vulnerabilities, and performance
- What is the code complexity of this piece of code? Can I improve it by using other data structures?
```

### Testing and Documentation

```
- Create unit tests using TestNG with the format testGivenXWhenYThenZ
- Don't use @Inject or @Mock annotations
- Don't use imports with *
- Don't use any() Mockito functions
- Add specific verify clauses for the number of invocations
- Make sure to include test cases for all branches of the code
- Don't explain and just give the consolidated code
```

### Code Refactoring

```
- Refactor code to use the latest Java versions
- Refactor this using Java 17
- Reduce code complexity
- "Select some code" → Refactor this code using Strategy pattern
- This code is too complex, is there any pattern that would help me simplify or abstract the code? Give me specific code examples
```

## Slash Commands for Quick Actions

Copilot Chat includes several slash commands for common tasks. **Remember to select the code in IntelliJ IDEA first**, then use these commands in Copilot Chat:

### Essential Slash Commands

- **`/tests`**: Generates comprehensive test cases for your selected code
- **`/simplify`**: Provides suggestions to simplify complex code
- **`/fix`**: Identifies and suggests fixes for code issues
- **`/explain`**: Helps you understand the code you're working with
- **`/doc`**: Assists in writing documentation for your code
- **`/feedback`**: Sends comments to the Copilot plugin creators

## Best Practices for Java Development

### 1. Start with Clear Comments

Write descriptive comments before implementing methods:

```java
// Calculate the total price including tax and discounts
// Parameters: basePrice (double), taxRate (double), discountPercentage (double)
// Returns: final price (double)
```

### 2. Use Specific Prompts

Be as specific as possible when asking Copilot for help:

```
"Create a method that validates email addresses using regex patterns"
"Generate a builder pattern implementation for this class"
```

### 3. Review Generated Code

Always review and understand the code Copilot generates. Don't blindly accept suggestions without understanding them.

## Limitations and Considerations

### What Copilot Doesn't Do Well

- **Complex dependency conflicts**: Copilot can suggest solutions but won't always provide the exact fix for intricate dependency issues
- **Project-specific architecture decisions**: It may not understand your project's specific architectural patterns
- **Security-sensitive code**: Always review security-related code manually

### IDE Comparison

The Visual Studio Code Copilot plugin seems more advanced than the IntelliJ version, and much of the online documentation focuses on VS Code. However, the IntelliJ integration is still quite powerful for Java development.

## Real-World Example

Here's how I typically use Copilot in my Java workflow:

1. **Write a comment** describing what I want to implement
2. **Let Copilot suggest** the implementation
3. **Review and modify** the generated code
4. **Ask Copilot Chat** for improvements or alternatives
5. **Generate tests** using the `/tests` command

> **⚠️ Important Notice**: This article was written in March 2024. Since then, GitHub Copilot and AI-powered coding tools have evolved significantly. New features, improved capabilities, and different integration methods may now be available. Please check the [official GitHub Copilot documentation](https://github.com/features/copilot) for the most up-to-date information and current best practices.

## Conclusion

GitHub Copilot is more like an intelligent assistant rather than a replacement for your engineering skills. It excels at:

- **Boosting productivity** through smart code completions
- **Improving code readability** by suggesting well-structured code
- **Accelerating learning** through explanations and examples
- **Reducing boilerplate** code writing

However, it's crucial to:

- **Always review** generated code
- **Understand** what you're implementing
- **Use it as a tool**, not a crutch
- **Maintain** your coding standards and practices

The key is finding the right balance between leveraging AI assistance and maintaining your development expertise. Copilot works best when you use it to enhance your workflow rather than replace your thinking process.

Are you using GitHub Copilot with Java? What's your experience been like? Share your thoughts in the comments below!
