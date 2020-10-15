---
layout: single
title: "400 active users in my first android app"
date: 2020-10-11 13:45:53 +0200
categories: apps
comments: true
lang: en
tags: java, android

---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/simulador-hipoteca-update.png)
{: refdef}

It's been some time since I released my first android app to the <a href="https://play.google.com/store/apps/details?id=com.manriqueapps.simuladorhipoteca&hl=en">android market</a> and I thought it was a good idea to share what is the current status after some time out there.

Motivation
------------------------------------
My motivation when making an Android application was to learn how to make an Android app, since knowing Java I thought that the learning curve would be less steep. I explain the process of how the launch was in this <a href="{{ site.baseurl }}{% post_url 2019-03-24-learn-by-doing %}"> post </a>

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/active-users.png)
{: refdef}

My goal was also to create something that could be useful to people and what better than a calculator for people who are thinking of buying real state.

Number of active users
------------------------------------
Currently there are 401 active users of the app. 

> If I put them all in a meeting room I would have to put a few chairs, so that although I know that there are few users compared to any successful application that is in the android market for me it is already a success.

Keep in mind that I have not made any advertising of the app by any means of payment and I have not recommended it on my social networks.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/new-users.png)
{: refdef}

New features
-------------------------------------
In July I added a new <a href="https://developer.android.com/guide/components/fragments">fragment</a> in which you can see the cost of the mortgage depending on the interest rate offered by banks. I looked for the most important banks in Spain and looked on their websites for the 30-year fixed interest rate they offered on their website.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/simulador-hipoteca-interest-comparator.png)
{: refdef}

The application is not consulting the interest rate in real time on each of the banks' websites. In the next release I do, I will update the interest rates with the new rates.

Previously I made another release to remove some sliders that I introduced in the first version because they were not very usable and made the user interface very cluttered.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/simulador-hipoteca-10-2020.png)
{: refdef}

Some issues to fix
-------------------------------
I have seen in the google play console that the app sometimes throws an ANR, so I will try to fix it so that there are not these errors. It is possible that some users uninstall the application because they no longer need it or because they have suffered ANR's

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/blocks_and_errors.png)
{: refdef}

Migrating the app to kotlin
--------------------------------
I have thought about migrating the application to <a href="https://kotlinlang.org/"> Kotlin </a> because the number of users of this language is increasing and certainly the benefits of using this language are multiple compared to Java.

According to the following <a href="https://insights.dice.com/2019/06/24/kotlin-how-why-tech-professionals-use-it/">post</a> the kotlin jobs increased 15x when it became a “first class” language for Android.

New functionalities for users
---------------------------------
Something that could be useful for users of the app would be:
- The simulations carried out could be saved by saving these simulations in a file, and each simulation can be given a name.
- In the interest rate comparator fragment, users could change the repayment date from 30 to 20 years or to other periods.

Conclusion
----------------------------
Developing an Android application was a challenge at the time of creating it because I did not know how Android worked, then putting it into production and seeing how it was capturing downloads helping people has been a satisfaction. 

I would like to add new features in the app during next months trying to help more people that want to calculate the mortgage costs.





