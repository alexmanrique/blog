---
layout: single
title: "How to backup your files to NAS western digital"
date: 2021-06-18 18:08:53 +0200
categories: data
comments: true
lang: en
tags: backup
image: /images/backup-files.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/backup-files.jpg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@markusspiske?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Markus Spiske</a> on <a href="https://unsplash.com/s/photos/backup?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef}  

I decided to write this post to share how to backup files into a western digital NAS drive.

Avoid having a single point of failure
----------------------------------------
It's good to practice <a href="https://en.wikipedia.org/wiki/Data_redundancy">data redundancy</a>. The same way that you don't have a single server to handle all the traffic and you have more than one just in case that one of them is not available, the same happens with data. 

> You should not have a single point of failure (SPOF) 

The mean time to failure of a hard drive is 5 years so it's not a bad idea thinking about copying your files into another destination.

Copying files manually is not a good idea
----------------------------------------
One could think to just copy files from location A to location B, but if the amount of data that you have is big everytime that you add, remove or rename a file in A you will have to copy everything from A to B replacing all the files. 

This is not really optimal if you have just removed a single file for example or you have added a new file.

rsync command to backup files
----------------------------------------
Here is when `rsync` <a href="https://en.wikipedia.org/wiki/Rsync">program</a> comes into play. With this program we can synchronize files from location A into location B, and we can use `SSH` to transfer securely files from location A to location B over the network.

Enable SSH in NAS western digital
-----------------------------------
Now that we know which command we need to use, we have to enable SSH in western digital NAS to be able to transfer files over the network. We have to go to the configuration of western digital and enable ssh.

We have to go to the following url 

> http://wdmycloud.local

//explicacion de como habilitar ssh en western digital

Now we are able to use `rsync` to copy our files from one localtion to another

## Conclusion

It's a great idea to backup your files to be ready for any problem that may arise in your disk taking into account that the mean time to failure of disks is 5 years. In this post we have seen how to use this program to synchronize files from location A to location B using SSH.
