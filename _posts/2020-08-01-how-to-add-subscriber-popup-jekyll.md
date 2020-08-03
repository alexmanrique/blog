---
layout: single
title: "How to add a subscriber pop-up with Jekyll"
date: 2020-08-01 13:20:53 +0200
categories: development
comments: true
lang: en
tags: jekyll, popup, email
---

![email]({{ site.baseurl }}/images/popup.jpg)

In this post we are going to talk about how to add a popup form in a <a href="https://jekyllrb.com/">Jekyll</a> website with <a href="https://github.com/mmistakes/minimal-mistakes">minimal-mistakes</a> plugin. Notice that we are using Jekyll but it can work with any other platform that you control the source code of the website where you can include a Javascript <a href="https://en.wikipedia.org/wiki/Snippet_(programming)">code snippet</a>.

Using Jekyll for your personal blog
--------------------------------------
Jekyll is a static template website generator that you can use with <a href="https://pages.github.com/">github pages</a>. All this posts that you can read in this blog are stored in a <a href="https://github.com/alexmanrique/blog">github repository</a> and I don't pay a dime for having them in any hosting platform. 

![blog repository]({{ site.baseurl }}/images/blog-repository.png)

I don't need to use any <a href="https://en.wikipedia.org/wiki/Database">database management system</a> because all the pages are stored in the github repository. The only thing I pay is my domain `alexmanrique.com`, but all the things that you see under this domain are hosted in different repositories in Github.

Using minimal-mistakes with Jekyll
-----------------------------------
Minimal-mistakes is a theme for Jekyll, the same that you have with themes for <a href="wordpress.com">Wordpress</a>, minimal-mistakes is a flexible two column Jekyll theme that helps you writing blogs posts. 

![blog repository]({{ site.baseurl }}/images/minimal-mistakes.png)

If you want to learn more about how to create a blog with Jekyll for free I wrote a [post]({{ site.baseurl }}{% post_url 2017-10-21-host-personal-website-for-free-with-github-pages %}) some time ago that can help you get started.

Adding a popup form in the blog
--------------------------------------
To add a popup form in minimal-mistakes blog you have have in your file directory a `custom.html` file in the following route `includes/head/custom.html` . All the code that you include in this file will be added at the end of head tag just before closing it.

We have to place the code snippet that we will generate in the next step inside the 

```html
<head>
//the code snippet to show the popup form has to be placed here before this tag closes.
</head>
```  

Mailchimp to collect emails 
-----------------------------------
In this example we use <a href="https://mailchimp.com/">Mailchimp</a> to collect emails but there are other options that can help you as well. We have to create an account with Mailchimp and then we will have the option to create a popup form. 

![subscriber form]({{ site.baseurl }}/images/subscriber.png)

From there we can specify the content of the form, the layout, when it will appear in the screen and another interesting options. 

![subscriber form design]({{ site.baseurl }}/images/subscriber-form-design.png)

Once we have it ready we can see a preview of how it will look like and we can download the Javascript code to inject in your website. The good thing is that we don't have to change the javascript code everytime we do a change. 

Conclusion
-----------------------------------
In this post we have seen how to add a popup form in your website to invite people to subscribe to your website and to receive emails related with your publications.    





