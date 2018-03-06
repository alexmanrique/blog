---
title:  "Tips to read and understand code"
date:   2017-12-02 14:13:53 +0200
categories: development
comments: true
lang: en
ref: coding
tags: code fork
---

The following list contains my personal tips for reading code of other developers. We spend a lot of time reading code of other people and knowing how to do it in an efficient way it's important. This tips work for me but maybe you have other techniques that work better, feel free to write a comment below. 

1 - Download the repository and open with a good IDE
----------------------------------------------------
The first thing to do is to clone the repository in your computer and open it with an integrated development environment (IDE). You can read code directly in github or in bitbucket but it’s more difficult if you want to understand how the different pieces of the software interact, how a class uses another class, how a method uses another method, find quickly a class inside the repository, check who commit each line of the code that you are reading... All this tasks are more easy with a IDE. I personally use Idea Intellij Community Edition but Eclipse or Netbeans are other good options if you are using Java.

2 - Execute the application from an entry point
----------------------------------------------------
The next thing to do is to execute the application from its entry point. Find some main() or some front end that let’s you execute the program and interact with it. It’s important to ensure that the application that you are testing is not changing something or interacting with some service in production. Developers that have developed the application should have guaranteed that you don’t change nothing accidentally having the keys or passwords from production environment in the application. At least if the application points to production it must not modify anything and ensure that is in read-only mode. 
With the execution of the application you can see the results of an execution and become familiar with the functionalities. This way you can see the standard output, the logs or the results in a front end page. 

3 - Debug the code of the application
----------------------------------------------------
Something useful is to debug the application. This allows you to execute the application step by step and see the variables and other state of a class or method. You should put a breakpoint in the code lines that you are specially interested and execute the code until this breakpoint. When you reach the breakpoint you can go line by line to understand it better. You can evaluate some expression of the code that you are debugging, if you are wondering what is doing a method of a class that is available you can evaluate it and see the result of it. 
 
4 - Find usages of the methods and classes
----------------------------------------------------
All modern IDE’s allow you to find the usages of a method that you have in a class. Once you check all the usages you get a list of places in the code the use this method or class. You can see the classes that use this method, you can see where those classes are created as instances… you can get an idea of the usages of this method and see how is used. Something useful that I use is an option called call hierarchy of a method that is available in Intellij idea https://www.jetbrains.com/help/idea/building-call-hierarchy.html you get a recursive tree view of the classes that use that method and you can navigate easily.

5 - Execute and read unit tests
----------------------------------------------------
Good code is supported by unit tests. It’s a way to ensure that your functionality is protected against future changes in the code of new developers that don’t know the code and try to make refactors because they don’t see the purpose of those lines of code. Of course if the unit tests are not good enough you will not understand the code too, but it’s a good way to increase your knowledge of the application. Read them, execute them, debug them too… etc. When you see the usages of a method you will find that the unit tests are also using that class that you were reading, and it’s a good moment to read them.

6 - Check commit history
----------------------------------------------------
You can see the commits of a class and check the differences of a previous commit, or read the commit description to get more information of the code that has been written. In the commits you can find mercurial/git users that have committed those changes and is possible that you can contact them to get more information about a particular part of the code. They can provide you with useful information like documentation, powerpoint or just a short talk of the project that can give you more context about it.

7 - Look for the Jira ticket
-----------------------------------------------------
Normally the commit messages have the ticket id that links to a Jira ticket or some other issue tracking product that teams use. In the ticket you can get information of why this project was done, interesting documentation... Comments in the jira sometimes contain some discussions with the stakeholders of the projects and you can read some of their suggestions, ideas or requests related with the code that you are reading that can help you get more context of the application. In the jira you can find normally information of the release version of that ticket and you can see when this code was released to production. You can see also the transitions to see who tested the application or if it was blocked for some reason.

8 - Read repository readme
-----------------------------------------------------
You normally can get interesting information in the Readme.md file of the repository. In my opinion the way that all the repositories should be documented is like when in Github someone uploads his repository for the community and he wants that people are able to understand it. I think it’s the best way to document software because wikis that are not integrated with the repository and get out of date easily. Developers should update readme file accordingly with the current status of the software.  

9 - Query the database
-----------------------------------------------------
If your application is using a datastore to persist data it’s worth it to use query the database and investigate which tables are used, how many rows are in a specific table … When you are reading classes that interact with data stores it's a good moment to do it.  

10 - Check the logs
-----------------------------------------------------
This is useful for bugs and maintenance of the application but it’s a way to detect that something is not working fine in the application. If you are reading code of an application that in the logs appear a lot of null pointers or other exceptions means that something is not ok with the application. It doesn’t mean that the code is bad because maybe there is a configuration file that is missing, some data is missing in the database, a service is down ...

11 - Read the metrics
-----------------------------------------------------
Modern applications monitor the performance of the application. In web API’s you monitor the number of requests that the API is receiving, how much time needs the API to respond a request … you can have an idea of the most important methods, endpoints… this is not directly related with the code but it can give you more context and understand important thinks of the application.

12 - Read related API’s
-----------------------------------------------------
Imagine that you are reading an application that is using Java 8 and you are not familiar with this new version because you don’t have experience with it. Having the Javadoc of the Java 8 can be really useful and also a good book of this technology can help you a lot. Finding good sources of documentation can be helpful in all aspects. Good youtube videos can help you also understand new API’s or technologies that you are not familiar with or books of experts in the field can boost your knowledge in the area.

13 - Check other code examples of the technology
-----------------------------------------------------
Reading other examples of code related with the technology that you are using can be really helpful and increase easily the knowledge of the technology. I look for github project examples of the technology that a project is using. This can help me find the best way to use this technology rather than reading all the documentation of the api. You have to find the right balance between this tip and the last one because if you look at examples with 0 knowledge can be a waste of time, but reading all the documentation without seeing any example can be also a waste of time.

14 - Talk with the owners of the repository
-----------------------------------------------------
If you have the opportunity to talk with the person that has written this piece of code is a good way also to understand it. What I do before asking the person that wrote this code is to read it by myself and If I get stuck then I ask. I think if you do it this way when you talk with that person he will see that you are interested in the code that he has written and he will be more motivated to help you because he will see that you have bothered yourself in diving with the code.

15 - Comment the code with other peers
-----------------------------------------------------
If you are working with more senior developers than you maybe you can have a conversation of the code that you are reading. 4 eyes see more things than 2 and it’s a good way to interact with other mates. Maybe those mates have worked already with this code and are able to help you to understand the code. Try to avoid interrupting, if they are focused with an specific task ask first if they are available to speak about it. Show them that you spent time trying to understand it by your own.

Conclusion
-----------------------------------------------------
All those tips help me working with code that I have not written and help me understand it more easily. Think that we spend more time trying to understand code of others than writing new code from scratch. Which tips do you think are helpful? Would you include other tips in this list? 

