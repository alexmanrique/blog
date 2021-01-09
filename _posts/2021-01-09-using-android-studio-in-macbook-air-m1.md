---
layout: single
title: "Using Android studio in Macbook Air M1"
date: 2021-01-09 09:45:53 +0200
categories: development
comments: true
lang: en
tags: mac, apple, m1, java, android
image: images/m1_android_studio.png
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/m1_android_studio.png)
{: refdef}

This is the second post that I dedicate to talk about configurations using the new M1 Apple processor. As I said in the previous post, these configurations are workarounds until stable versions are released, however, for me, they have been useful and I guess that someone in the same situation as me can benefit from that.

Using Android studio in the new Macbook Air
-------------------------------------------
When you install Android Studio you will get the following warning: 

>Unable to install Intel® HAXM 
>
>Your CPU does not support VT-x.
>
>Unfortunately, your computer does not support hardware-accelerated virtualization.
>
>Here are some of your options:
>
>1 - Use a physical device for testing
>
>2 - Develop on a Windows/OSX computer with an Intel processor that supports VT-x and NX
>
>3 - Develop on a Linux computer that supports VT-x or SVM
>
>4 - Use an Android Virtual Device based on an ARM system image
>
>(This is 10x slower than hardware-accelerated virtualization)
>
>Creating Android virtual device
>
>Android virtual device Pixel_3a_API_30_x86 was successfully created


And also in the Android virtual device (AVD) screen you will read the following warning:

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/your_processor_doesn_allow_virtualization.png)
{: refdef}

If you want to learn more regarding virtualization in processors you can read the following Wikipedia <a href="https://en.wikipedia.org/wiki/X86_virtualization">article</a>, the thing is that our M1 processor doesn't support VT-x, however, we have options to run an Android Virtual Device. 

As the previous message was telling us, we have 4 options. The easiest way to proceed is to use a physical device, but what if you haven't one available at the moment you are developing? 

From now on, we will go with the option of using an Android virtual device based on an ARM system image as options 2 and 3 are not available. 

### Using the virtual emulator

The only thing that you have to do is to download the last available emulator for Apple silicon processors from Github <a href="https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2">https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2</a>

Once you have downloaded you have to right-click to the .dmg file and click open to skip the developer verification.

After installing the virtual emulator, we have to open it from the Applications menu. 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/android_emulator_in_launchpad.png)
{: refdef}

After opening it you will see `Virtual emulator` in Android Studio available to use to deploy your Android application. Make sure to have Project tools available in Android Studio (View -> Tool Windows -> Project) 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/virtual_device.png)
{: refdef}

After pressing the launch button you will get your Android application running in your ARM virtual emulator :-)

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/android_app_running_virtual_emulator_on_m1.png)
{: refdef}

Conclusion
------------------
In this post, we have seen that is possible to install Android Studio in Macbook Air M1 and use a virtual device even that your M1 doesn't support VT-x. You can learn more about this emulator in the following references: 

<a href="https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html">https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html</a>

<a href="https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html">https://androidstudio.googleblog.com/2020/12/android-emulator-apple-silicon-preview.html</a>

<a href="https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2">https://github.com/741g/android-emulator-m1-preview/releases/tag/0.2</a>

<a href="https://stackoverflow.com/questions/64907154/android-studio-emulator-on-macos-with-arm-cpu">https://stackoverflow.com/questions/64907154/android-studio-emulator-on-macos-with-arm-cpu</a>