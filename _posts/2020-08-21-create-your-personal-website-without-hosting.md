---
layout: single
title: "Create your personal website without a hosting"
date: 2020-08-21 02:00:53 +0200
categories: development
comments: true
lang: en
tags: github-pages, github
image: images/personal-website.png
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/personal-website.png)
{: refdef}

Do you wonder how you can have your personal website without having to pay a hosting? In this post we are going to talk about it and I will show you an example live in production.

1 - Create a Github account
-------------------------------------------
We need to have a Github account to be able to publish our personal website. Without it we cannot fork, commit neither publish our personal website. It's completely free and if you are a developer you should consider having a personal account because it helps you stay up to date, you can contribute to open source and you can have your public profile out there. It's the most famous social network for developers. 

2 - Look for a template that you like in Github
---------------------------------------------------
The second think you should do is to look for a template that you like on github. There are two topics in Github where you can find examples of websites <a href="https://github.com/topics/personal-website">personal website topic</a> and <a href="https://github.com/topics/portfolio-template">portfolio template topic</a> 

3 - Fork the repository that has your favourite template
---------------------------------------------------------
Once you find the one that you like you have to do a fork of this repository to be able to modify the template with your own data. You will see that in your personal space you will have a new  repository. To start working on that you have to clone the repository in your personal computer.

![fork repository]({{ site.baseurl }}/images/fork-repository.png)

4 - Customize template with your experience
---------------------------------------------------
To customize the template I would suggest you to use some kind of IDE like for instance <a href="https://visualstudio.microsoft.com/es/">Microsoft Visual studio</a> as you will have to modify html content. Here you have to adapt the template to your experience and your preferences. In the template that I used it didn't have a link to a personal blog or to twitter. 

![visual studio]({{ site.baseurl }}/images/visual-studio.png)

I saw that the template was using <a href="https://fontawesome.com/icons?d=gallery">fontawesome</a> and I looked for a blog icon to link to my <a href="https://alexmanrique.com/blog">personal blog</a> and an android icon for the <a href="https://play.google.com/store/apps/details?id=com.manriqueapps.simuladorhipoteca&hl=en">android app</a> that I have in the android market.

![font awesome]({{ site.baseurl }}/images/fontawesome.png)

This way I could add 2 links in the template to those links with a suitable fontawesome icon.

5 - Copy the build files in a new repository called username.github.io
--------------------------------------------------
Those templates that are on Github are not ready to be shown in <a href="https://pages.github.com/">github pages</a> because the `index.html` file is not in the root folder of the repository and it's inside a `dist` folder. 

We have to create a new repository with the name `username.github.io` and visibility `public`. 

{:refdef: style="text-align: center;"}
![create repository]({{ site.baseurl }}/images/create-repository.png)
{: refdef}

The idea here is to copy those files from dist folder into a repository that all the files that are in the `dist` folder are in the root folder. This includes index.html `css` , `js` or any other subfolders. If you don't include this folders the template will not render as you expect.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/dist-files.png)
{: refdef}

6 - You will have your personal website in username.github.io
------------------------------------------------------------------ 
When you have commited the files in the repository username.github.io your personal website will be available in `https://username.github.io`. If you see a 404 error is that you have missed some previous step.

7 - (Bonus) Having your personal website under your domain
------------------------------------------------------------
Add a `CNAME` file in the root of the repository with your domain. You can read more information about how to do this configuration in the following <a href="https://docs.github.com/en/github/working-with-github-pages/configuring-a-custom-domain-for-your-github-pages-site">link</a>


Conclusion
------------------------
In this post we have went through all the steps to create a personal website without having to pay a hosting using Github pages technology. If you want to see the result of my work you can visit https://alexmanrique.com. Do you have a personal website? Do you like the idea of having a personal website?




