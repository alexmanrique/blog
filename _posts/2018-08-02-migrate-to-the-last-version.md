---
layout: single
title:  "Update to the last version"
date:   2018-08-02 20:13:53 +0200
categories: development
comments: true
lang: es
tags: development 
---

Is it necessary to update the software?
------------------------------------------------
Sometimes non technical people don't understand why its necessary to migrate an application in your mobile phone, or why it is necessary that annoying blue screen when you are shutting down windows that tells you "Do not turn off your computer".

All software has to be updated
------------------------------------------------
Software runs in all the devices that we use on a daily basis: smart watch, mobile phone, desktop computer, printer, fridge, car, tickets selling machine, airplane ... and a long list that continues.

From the operating system, to the applications that we have in our mobile phone the software has to be updated because software has bugs or mistakes done by developers when the code was developed and it can be the source of security problems in the application, bad performance or lack of functionalities that were planned but not developed. 

Fixing old bugs and vulnerabilities
-------------------------------------
A good reason to update the software is to fix problems and vulnerabilities that you can have in the software. There is a website called https://www.cvedetails.com where you can search for bugs and vulnerabilities for particular versions that are known and an historic of them. 

Controlling the number of bugs
--------------------------------------
Software changes during time because new requirements come up and -of course- you should add controls in your development process to reduce as much as you can the number of them like: static code analysis tools, code reviews, unit tests, functional tests, regression tests and manual tests. All this helps reduce the number of bugs that you deliver, but all developers know that bugs will appear, however, good developers try to reduce this number as much as possible.

Getting new functionalities
-------------------------------------
The good part of getting new functionalities is that you will be able to do new things with the software that you couldn't before. The drawback If you deliver new functionalities is that it will add normally a number undetermined number of bugs. Software that doesn't change during time because no new functionalities are added, will no increase the number of bugs in newer versions. The more lines of code that you deliver, more potential bugs can have your application. 

How often we should update
-------------------------------------
The newest stable software should be used and migrate as soon as possible to the latest versions. GA (general availability) version should be used because those versions are more stable rather than beta or alpha, which are versions that are released to a reduced group of users to detect possible problems. Versions after the alpha or beta are good choices because the number of bugs is reduced comparing with beta and alfa versions.

Forced to update cakephp version  
-----------------------------------
I maintain a website written in PHP with a framework called <a href="https://cakephp.org/">cakephp</a>, and one of the customers of the website called one day telling me that he couldn't see the website in Safari browser. In the beginning I thought was because the shared hosting or the database was down. I realized that the website was available in other browsers like Firefox or google chrome. I tried to reproduce the error locally and I did, the website was not available when I used Safari version 11.

An outdated version
--------------------------------
The website was using PHP 5.5 and I suspect that this could be the reason why it was not working in Safari. I changed the version of PHP to 7, and then I could see the website again in Safari. The bad news was that there was a class called String that cakephp was using, and String in PHP 7 is  <a href="https://www.drupal.org/project/graphql/issues/2715609">reserved</a>. My only option was to migrate to the last version cakephp 3.6 that was compatible with PHP 7. 
I could't provide SSL to the website users when the website was using PHP 5.5. For some reason with this version there was an error `ERR_SPDY_PROTOCOL_ERROR`in Chrome and in Safari (not in Firefox) when trying to load the page using SSL. 

After updating the version
--------------------------------
Both problems disappeared after migrating the version of cakephp 2.4.9 to cakephp 3.6 and migrating from PHP 5.5 to 7. Now customers can use SSL in the website and the web can be browsed with any browser.

Bonus - Why I developed a website in PHP?
----------------------------------
I have been Java developer for the last 9 years and in my professional life I have not been paid a single euro to write PHP code line, but in the past I developed a website with PHP to try different programming languages and frameworks. Another reason why I did in PHP is because I wanted to use a cheap shared hosting solution and the backend language supported was PHP and not Java. 

Conclusion
------------------
Software should be updated to the last stable version as often as you can. You will be able to enjoy new functionalities/features and also fixes that will prevent you from security problems, performance or crashes in the software that you are using. 

![Windows updating]({{ site.baseurl }}/images/windows-updating.png)













