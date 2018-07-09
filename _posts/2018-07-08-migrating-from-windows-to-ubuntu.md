---
layout: single
title:  "My experience migrating from Windows to Ubuntu"
date:   2018-07-08 20:13:53 +0200
categories: development
comments: true
lang: es
tags: development 
---

In the last month I have been using Ubuntu as the operating system of my desktop computer and I wanted to write a review of what I like about it and the process of migrating from windows to ubuntu. 

Different operating systems used 
-----------------------------------
I used <a href="https://www.debian.org/">Debian linux</a> distribution when I was in college some years ago and also at home in my desktop computer where I had two <a href="https://en.wikipedia.org/wiki/Disk_partitioning">partitions</a> in my hard drive, one with <a href="https://en.wikipedia.org/wiki/Microsoft_Windows">Windows</a> and another one with <a href="https://www.ubuntu.com/">Ubuntu</a>. In the beginning there where devices that were not compatible, but nowadays it has changed and everything that you can do in Windows you can do it in Ubuntu.

I was used to work with Windows for the last 9 years as a developer but I have always been interested in using tools that enabled me to emulate the unix terminal. TImes when I needed to do a `curl` command to test an endpoint or to `ping` an url to check connectivity … those were times when I used <a href="http://www.cygwin.com/">cygwin</a>, cmd, <a href="http://cmder.net/">cmder</a> or <a href="https://en.wikipedia.org/wiki/PowerShell">powershell</a> of windows.

Backup important data 
------------------------------------
One month ago I had the opportunity to change from Windows operating system to Ubuntu. I write my name in an excel to do the migration. Before doing it I backup all the files from my Documents folder to my network drive, and I ensure that all my bookmarks of my browser were saved in Google Chrome. 

All the api calls, all the links to the different tools, <a href="https://en.wikipedia.org/wiki/Kibana">kibana</a>, production, integration, qa, dev environments, my links to official documentation where in my google chrome account. Also I backup the configuration files from applications like <a href="https://www.soapui.org/">SoapUI</a> or <a href="https://www.oracle.com/database/technologies/appdev/sql-developer.html">Oracle sql developer</a> that I used on a daily basis.

Better performance in ubuntu
------------------------------------
One of the major improvements that I have experienced is the deploy of Java applications in JBoss. In Windows 10 the deploy of a legacy java application using <a href="https://ant.apache.org/">apache ant</a> spent 12 minutes using <a href="https://en.wikipedia.org/wiki/Solid-state_drive">SSD</a> and 16 GB of RAM. With ubuntu it spends 3 minutes approximately. That's a 4x time reduction :) 

All the system works smoothly without crashes. Sometimes I get some application that allocates a lot of resources but then I open the system monitor (the equivalent of task manager in windows) to check which process is involved and I stop it. If I am in the terminal I can use `top` command and when I visualize which processes are using more resources I quit from `toptermina and I execute the command 
```java
kill -TERM <processId> 
```

Using the terminal
------------------------------------
I also like using the UNIX terminal with all the commands that you can use. I was used to use cygwin and cmder in Windows but I feel that it was a fake of the unix terminal. Now when I want to run JBoss in my desktop I type 

```java
cd $JBOSS_HOME 
```
and once there I type the command 

```java
sh bin/run.sh -c default 
```

and I get it up and running. 

Previously I defined the environment variables in .bashrc file of my home directory. 

```java
export JAVA_HOME="/usr/lib/jvm/java-6-oracle"
export JAVA="$JAVA_HOME/bin/java"
export JBOSS_HOME="/usr/local/share/jboss"
export PATH="$HOME/bin:$HOME/.local/bin:$JAVA_HOME/bin:$JBOSS_HOME/bin:$JAVA:$PATH"
```

Price of the operating system
------------------------------------
The strongest argument for Ubuntu Vs Windows, in favor of Ubuntu, is the price. Ubuntu is free Operating System. Ubuntu developers encourage the OS users to make donations to the community. The users can make donations from the official site. The Price of Windows 10 varies depending on the version of the Operating System. Windows 10 Pro costs about $199.99

Security of the operating system
------------------------------------
Windows is the main target of Virus and Malware developers. For this reason antivirus programs should update their virus definition periodically. The anti virus software will consume significant amount hardware resources.

In case of Ubuntu, it is generally a more secure Operating System. It is relatively smaller user base so Virus developers do not develop virus for Ubuntu.  But it is advised to use only the software repositories to prevent any potential virus attack on Ubuntu.

Useful links to install development tools in ubuntu 
------------------------------------
-20 most commonly used useful ubuntu commands in the terminal: <https://www.quora.com/What-are-the-20-most-commonly-used-useful-Ubuntu-commands-in-the-terminal>

-Using the intellij shortcuts in ubuntu: <https://askubuntu.com/questions/412046/unable-to-use-intellij-idea-keyboard-shortcuts-on-ubuntu>

-Add watches to intellij idea:
<https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit>

-Installing mercurial:
<https://help.ubuntu.com/community/Mercurial>

-How to install oracle jdk-6:
<https://askubuntu.com/questions/67909/how-do-i-install-oracle-jdk-6>

-How to install oracle jdk-8:
<https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04>

-How to install maven:
<https://www.vultr.com/docs/how-to-install-apache-maven-on-ubuntu-16-04>

-How to install docker ce:
<https://unix.stackexchange.com/questions/363048/unable-to-locate-package-docker-ce-on-a-64bit-ubuntu>

-Install docker compose in ubuntu:
<https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-16-04>

-Mount password protected network folders in Ubuntu:
<https://wiki.ubuntu.com/MountWindowsSharesPermanently>

Conclusion
-------------------------
If you use the terminal to execute commands you will prefer Ubuntu than Windows. The price of the operating system is a good reason to migrate because it's free. The security of the operating system can be also a good reason because malware and virus developers target their efforts to the Microsoft operating system.













