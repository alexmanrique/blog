---
title:  "Tips to write clean code"
date:   2018-01-05 20:13:53 +0200
categories: development
comments: true
lang: en
ref: clean
tags: clean code 
---

In this post I will go through the most useful rules that I follow to write clean code. You would wonder why it's important to write clean code, well, for the most part of the time we are reading code from other people so when we write code we have to think that our code will be read by future developers that should be able to understand your intentions just reading your code.

Maybe you are not in the same team, company when other people read your code so it's important to write it carefully. Sometimes it's better to spend some extra time writing the code than deliver it fast and bad. 

1 - Use meaningful names.
---------------------------------
It's important to give good names to your variables, method names and classes. Thing of the next developer that will read your code. The most part of the time you are reading code of other people, so consider writing with that focus in mind.

2 - Avoid large classes, keep number of imports low.
---------------------------------
If you have a lot of imports in a class it means that it has a lot of dependencies and is not cohesive enough, your class has to do one thing also and has to be short.
A class with more than 200 lines is a candidate to split in two or more classes. If the class does more than one thing it's not a good sign.

3 - Keep methods short.
---------------------------------
If your methods are short that method will tend to do one single thing. You can thing on the other way if a method does one thing it has to be short. If the method does one thing it will be easy to read and to understand.

4 - Reduce the scope of the variables.
---------------------------------
A variable created at the beginning of a method an used inside some lines it's a bad sign. A variable can be used to get the result of another method call and avoid calling that method again, but maybe you can avoid creating this variable and use the call of a function in the place that you use the variable.

5 - Less comments, more meaningful names.
---------------------------------
This is related with having meaningful names. Sometimes you can see comments just before calling a method. This comments seem to clarify what that method is doing. Instead of writing this kind of comment improve the name of the method.

6 - Logic has to be unit tested.
---------------------------------
When you write a unit test of a method you realize mistakes in your code. As a general rule we can say that if it's difficult to write a unit test for a class then this class can be improved. This happens when you have static methods in a class
that you can't mock and control the logic of this calls. The unit test helps to thing what a class is and what is its purpose. If you write a unit test you will force yourself to write better code. 

7 - Inject dependencies instead of hardcoding them.
---------------------------------
You should use dependency injection pattern in your code. Your classes should not depend on a particular implementation. This way your code is more generic and you can change implementations without changing your code.
Using Context and dependency injection (CDI), google guice or spring dependency injection are some ways to achieve this.

8 - Put configuration in properties.
---------------------------------
If your code has hardcoded configuration values is also a bad smell. URL's of API's that your code uses should be in properties files because they might change if you are in a development, staging or production environment.

9 - Avoid data clump.
---------------------------------
Pass a lot of parameters to a method can be a sign of poor design. It can be refactored grouping the different variables together into a single object rather than passing a lot of parameters to a method.

10 - Less code = less bugs
---------------------------------
Less code, means less code to mantain and less possible mistakes and more easy to read. It's a simple rule but really important to remember.

Conclusion
--------------------
This is my list of things to remember when writing code and keep it clean (there are more). I definitely recommend <a target="_blank" href="https://www.amazon.com/gp/product/0132350882/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0132350882&linkCode=as2&tag=de8blg6-20&linkId=3d20c156665621e677091dfeeb4bc1e0">Clean Code: A Handbook of Agile Software Craftsmanship</a><img src="//ir-na.amazon-adsystem.com/e/ir?t=de8blg6-20&l=am2&o=1&a=0132350882" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" /> where he explains how to write clean code with a lot of examples (A must for any software developer) 
What is your list? leave a comment below if you have another tip that you feel that is important.







