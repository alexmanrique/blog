---
layout: single
title: "10 code smells to avoid in your code"
date: 2022-08-14 09:08:53 +0200
categories: development
comments: true
lang: en
tags: code
image: 
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/layer.jpeg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Foto de <a href="https://unsplash.com/@hasanalmasi?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Hasan Almasi</a> en <a href="https://unsplash.com/es/s/fotos/capa?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef} 

1 - Comments in the code
--------------------------
Avoid comments that try to explain what the code does. The code has to be readable without comments that explain what it does.

2 - Too many arguments
-----------------------
Functions that have more than 3 arguments are difficult to test and it's quite possible that they do more than one thing. You should strive for having at most 3 arguments.

3 - Dead function
-------------------
Function that nobody calls. Modern IDE'S can help you on this because this methods appear in grey colour. Get rid of this dead functions. The less code that you have, the better.

4 - Duplication
-------------------
Don't repeat yourself (DRY) it's one of the most important concepts. Duplicated code it's a missed opportunity to abstract functionalities. 

5 - Code at wrong level of abstraction
---------------------------------------
If your application is structured in layers (that should) the layer where you place the code for your services should not use exceptions that are from the store layer, for instance, `DataAccessException` or `SQLException`.

6 - Feature envy 
---------------------
This principle it's related with the principle of having "shy code". If you are doing `car.getEngine().getPowerHorses()` it's not good cause you are accessing methods that are from an object returned by getEngine() method. // acabar de completar.


7 - Replace magic numbers with constants
-----------------------------------------
The code should not have hardcoded values, instead of that is better to use constants that abstract the reader of the code of that particular value that don't provide value.  


8 - Function names should say what they do
--------------------------------------------
Seems obvious this principle but if the name of the method doesn't explain what is doing it's that the method is doing more than one thing and then it's difficult to give a name or that the code writer has not choosen a good name for that method.


9 - Prefer polymorphism to if/else or switch case
--------------------------------------------------
Have you seen code that has 10 different if/else branches. This is a bad sympthon that the code is not well written and there's a good opportunity to use polymorphism. Instead of asking the type of the object and call a function doing a cast it's better to call a method of an object and depending of his type it will execute the definition of the method.


10 - Encapsulate conditionals
-------------------------------
You don't need to know the details of a conditional that calls more than one function. It's better to group those calls into a method to abstract the reader of the details of the conditional and only provide a method function call. 


11 - Avoid negative conditionals
---------------------------------
Negative conditionals read really bad, it's easier to read a conditional with isActive() than another one with isNotActive()


Conclusion
------------
In this post we have seen 11 code smells that you have to avoid in your code if you want to increase the quality of it. 



