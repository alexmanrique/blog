---
title:  "The importance of Code review"
date:   2018-01-31 20:13:53 +0200
categories: development
comments: true
lang: en
ref: review
tags: java code team 
---

I think code review is one of the most important things in software development nowadays. Code quality makes software maintainable and makes the job easier for future developers, fosters collaboration within a team and keeps people motivated to improve their coding skills.

Improving code quality
--------------------------------
It's better to waste one hour doing code review to see how your code can be improved and spend one day refactoring it rather than delivering code that is not well written, it's not modular and that only the developer that wrote it understands.

New ideas, different perspectives
--------------------------------  
Maybe your teammates have other ideas, or better names related with the domain objects of the problem that you are trying to solve. Maybe they know a library that is already doing what you are doing and you can avoid writing that code or they have other details that you didn't have when you wrote the code that can improve the code.

Fostering collaboration
-------------------------------
It's a way to increase collaboration within the team because everybody that participates is involved in other projects, everybody has the opportunity to [read]({{ site.baseurl }}{% post_url 2017-12-02-tips-to-understand-code %}) code of others and learn how other teammates think or how they approach problems. It can help junior developers to increase their knowledge about how to do clean code and learn more about design principles.

A way to get feedback 
-------------------------------
This is not a way to punish people or feel embarrassed about their own work. It’s a way to get feedback from other developers that probably have seen more code than you and can help you become better at your job. You should internalize inside the team that it's a necessary task. You are not wasting time. It should be always done in a respectful way. It's a way to start a conversation inside a team.

The ego effect
-------------------------------
The knowledge that others will be examining their work naturally drives people to produce a better product. This "Ego Effect" naturally incentivizes developers to write cleaner code because their peers will certainly see it.

Code quality
--------------------------------
In another post I did a [list]({{ site.baseurl }}{% post_url 2018-01-05-tips-to-write-clean-code %}) of things that I use to write cleaner code. It's good to internalize some list of code quality principles to use them automatically. When you write code or read code from other people you will naturally think in your list of principles. I.e: an important design principle to think in could be single responsibility principle (SRP). If you follow this principle your class or your methods should do one single thing (and do it well). This principle will force you to ‘break’ classes and it will make your code more understandable.  

Establish a process to fix defects 
-------------------------------
If you find a bug in a code review it's an opportunity to increase the quality of the code. You should establish a procedure to fix it, because if you talk about things that you can be improved but you dont schedule actions that you have to do to improve things finally you will end up procrastinating.

No longer than 60 minutes
-----------------------------
This sessions normally should not be longer than one hour. Just as you shouldn´t review code too quickly, you also should not review for too long in one sitting. When people engage in any activity requiring concentrated effort over a period of time, performance starts dropping off after about 60 minutes. Studies show that taking breaks from a task over a period of time can greatly improve quality of work.

Integrate in the software development cycle 
------------------------------
You can integrate the code review process in your repository if you are using <a href="https://bitbucket.org/">Bitbucket</a> or <a href="https://github.com/">Github</a> you can comment the code and the comments will arrive to the person that has written that code. Why don’t you add one task in your development cycle called code review? 

Conclusion
-----------------
Code review is a good practice that every development team should have integrated in their development life cycle or at least do it periodically. It has benefits for the product that you are building in terms of quality, fosters collaboration within the team and helps developers to improve their coding skills.  










