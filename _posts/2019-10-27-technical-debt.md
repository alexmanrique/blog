---
layout: single
title: "Technical debt"
date: 2019-11-03 00:13:53 +0200
categories: development
comments: true
lang: en
tags: technical debt, java
---
Do you know what it means to have debt? Is when you have to return to the bank money with interests. The more debt that you have, the worse, because you have to pay it every month and you will have less money to spend on other things. 

The same happens with technical debt in software. The more debt that you have you will have to pay completely at some moment or you will pay it gradually during the developments.

{:refdef: style="text-align: center;"}
![Technical debt delay cost]({{ site.baseurl }}/images/technical_debt.png)
{: refdef}


It's important to avoid increasing this debt when you are doing a project. This can happen when you have a deadline in a project and things have to be delivered fast. Managers can push teams to deliver things with less quality than is expected and getting into debt.


The impact of technical debt
------------------------------
Imagine that you have to add a feature to your codebase, if you have to spend 4 days in a codebase that is easy to change and 6 days in a code that is difficult, the 2 days of difference is the interest on the debt. 

Maybe doing a refactor and cleaning the code could mean 6 days of time, so after 3 new features done after the cleaning, you would have saved all the time that have used to clean your code.

Stated like that seems like is easy to measure the time to develop a feature and clean/refactor your code. 

> Unfortunately, is not easy to estimate the amount of time to develop a feature, neither to clean/refactor your code. 

What we can say is that avoiding technical debt has a cost that increases in time until there is no other option, and you have to pay this technical debt because the cost of delivering new functionalities is too high and you move forward really slowly.

{:refdef: style="text-align: center;"}
![Technical debt delay cost]({{ site.baseurl }}/images/technical_debt_function.png)
{: refdef}

Pay the debt gradually
-------------------------------
Given that is difficult to asses the benefits in terms of productivity if we clean the code, the best way to pay the debt is by doing it gradually as you would do with financial debt.

The day that you develop the first feature you would pay a little bit of debt cleaning/refactoring the part of the codebase that you are modifying. By removing some of the cruft it would be easier for the next developer to do more changes in the codebase in the next developments.

Areas, where there are a lot of changes done there, should be a zero-tolerance to bad code difficult to change and iterate because the interest payments there are really high. If the code is a nightmare to change, developers will spend more time than expected developing because the effort to do changes is really high in that part of the code.

If a feature needs to be built urgently maybe we should think of taking first the technical debt, accept that this debt will have to be managed in the future and that we can’t delay more taking action over it.

Examples of technical debt
-------------------------------
- Your source code is written in an old version of your chosen programming language.

- You are using an old application server version that has no support from the community.

- Your code is using old versions of third party libraries.

- Your code is coupled with a specific implementation and changing it, is difficult.

- Your code doesn't have unit tests.

- Your code doesn't have integration tests.

- Your code has libraries conflicts (dependency hell)

- Your code has comments that suggest what the code is doing.

- Code is difficult to read and there's no documentation related to it. 

- The execution of your continuous integration spends a lot of time. 

Conclusion
--------------------------------

We have seen through this post what is technical debt in software, the impact that it has, ways to reduce it and some examples. 
 















  












