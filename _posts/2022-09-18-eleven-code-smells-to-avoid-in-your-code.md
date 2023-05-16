---
layout: single
title: "11 code smells to avoid in your code"
date: 2022-08-14 09:08:53 +0200
categories: development
comments: true
lang: en
tags: code
image: images/code-smell.jpeg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/code-smell.jpeg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Foto de <a href="https://unsplash.com/@hrustall?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Дмитрий Хрусталев-Григорьев</a> en <a href="https://unsplash.com/es/s/fotos/smell?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef} 

1 - Comments in the code
--------------------------------------------
Avoid comments that try to explain what the code does. The code has to be readable without comments that explain what it does. Instead of relying on comments, focus on writing clear and self-explanatory code. Use meaningful variable and function names, follow a consistent coding style, and break complex code into smaller, more manageable functions.

2 - Too many arguments
--------------------------------------------
Functions that have more than 3 arguments are difficult to test and it's quite possible that they do more than one thing. You should strive for having at most 3 arguments. If a function requires a large number of arguments, it indicates a potential violation of the Single Responsibility Principle. Consider refactoring the function by encapsulating related arguments into objects or using default values and optional parameters where appropriate.

3 - Dead function
--------------------------------------------
A dead function is a function that nobody calls. Modern IDEs can help you identify dead functions as they usually appear in grey color. Remove these unused functions from your codebase as they add unnecessary clutter and can confuse other developers. Keeping your codebase lean and clean improves maintainability and makes it easier to understand the code.

4 - Duplication
--------------------------------------------
Don't repeat yourself (DRY) is one of the most important concepts in software development. Duplicated code is a missed opportunity to abstract functionalities and can lead to maintenance issues. Instead of duplicating code, strive to create reusable functions, classes, or modules that can be shared across your codebase. This promotes code reuse, improves readability, and reduces the chances of introducing bugs when making changes.

5 - Code at wrong level of abstraction
--------------------------------------------
In the given code snippet, the function percentFull appears to be at the wrong level of abstraction. It is defined in the Stack interface, but different implementations of a stack may not need to know how full they are. To address this, consider placing the percentFull function in a derivative interface such as BoundedStack that specifically deals with stack implementations that have bounded capacity. This ensures that each component of your codebase is responsible for its specific functionality and avoids unnecessary dependencies.

6 - Feature envy
--------------------------------------------
The principle of feature envy relates to having "shy code" and avoiding excessive method chaining. If you find yourself accessing methods from an object returned by another method, like e.getTenthRate().getPennies(), it can indicate a potential violation of encapsulation and hinder code maintainability. Instead, consider refactoring your code to promote better encapsulation and move the necessary operations closer to the relevant objects or classes.

7 - Replace magic numbers with constants
--------------------------------------------
Hardcoded values in code, often referred to as magic numbers, should be avoided as they make the code less readable and maintainable. Instead, use constants with meaningful names to represent these values. By abstracting the values into constants, you enhance the readability of your code and make it easier to understand the purpose and significance of the numbers used. 


8 - Function names should say what they do
--------------------------------------------
Seems obvious this principle but if the name of the method doesn't explain what is doing it's that the method is doing more than one thing and then it's difficult to give a name or that the code writer has not choosen a good name for that method.


9 - Prefer polymorphism to if/else or switch case
-----------------------------------------------------
When you encounter code with multiple if/else branches, it's often a sign of poorly structured code. A better approach is to leverage polymorphism, which allows you to define common behavior through interfaces or base classes and provide specific implementations in derived classes. Instead of checking the object's type and casting, you can simply call a method on the object, and the appropriate implementation will be executed based on its type. This promotes cleaner code, reduces branching logic, and improves extensibility.

10 - Encapsulate conditionals
-----------------------------------------------------
Complex conditionals that involve multiple function calls can make code harder to understand and maintain. To improve readability and abstraction, consider encapsulating these conditionals within a separate method. By grouping the related function calls together, you provide a higher-level abstraction that hides the details of the conditional logic. This enhances code clarity and allows other developers to focus on the method's purpose without being distracted by the implementation details of the conditional.

11 - Avoid negative conditionals
-----------------------------------------------------
Negative conditionals, such as using "isNotActive()" instead of "isActive()", can make code more difficult to read and understand. Positive conditionals are generally easier to follow and have a more natural flow. When writing conditionals, strive to use positive, affirmative language that clearly expresses the intended behavior. By favoring positive conditionals, you can improve code readability and make it easier for others to comprehend the logic at a glance.

Conclusion
-----------------------------------------------------
In this post, we have explored 11 code smells that you should avoid in your code to enhance its quality. By addressing issues such as excessive comments, too many arguments, dead code, duplication, incorrect abstraction levels, feature envy, magic numbers, poor function naming, over-reliance on if/else or switch case, complex conditionals, and negative conditionals, you can create cleaner, more maintainable, and easier-to-understand code. Remember, writing high-quality code is essential for long-term success in software development.



