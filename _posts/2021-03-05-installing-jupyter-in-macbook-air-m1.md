---
layout: single
title: "Installing Jupyter in Macbook Air M1"
date: 2021-03-05 09:08:53 +0200
categories: development
comments: true
lang: en
tags: python, silicon, macbook
image: images/m1-jupyter.png
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/m1-jupyter.png)
{: refdef}

In this post I'm going to list the steps to install <a href="https://jupyter.org/">jupyter notebooks </a>  in a Macbook Air M1. 

What is Jupyter notebook?
--------------------------
It's an open-source web application that allows us to share and create documents that have live code, visualizations, and narrative text.

It supports over 40 programming languages (not only Python) and you can share those documents with others using Github, Dropbox, or email.

Why Jupyter if I'm a Java developer? 
------------------------------------
At the time of writing this blog post, I don't have experience developing with Python and I decided to give it a try playing around with the language and with Jupyter notebooks. 

Java is criticized for its verbosity as a programming language and Python is recommended for beginners because the learning curve is lower and in few lines of code you can achieve more.

Even that a vast majority of my experience has been working with Java, I'm curious about other programming languages and technologies that can help solve problems differently.

Installing Homebrew
-------------------------
Having `homebrew` installed on your laptop is useful because it's a package management system that allows you to install anything that you need in your mac system. 

You just have to copy-paste the following command in your terminal and execute. More information available <a href="https://brew.sh/">here</a>.

```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
After installing it we can update `brew` with the following command.

```console
brew update && brew doctor
```

Installing Python
-------------------------
We then install `pyenv` that lets us switching Python version easily. 

```console
brew install pyenv 
```

with the following command, we install Python version 3.9.1 

```console
pyenv install 3.9.1
```

with the following command, we can add the initialization of `pyenv` new values into the `.zshrc` file, this way we don't have to type the same command everytime we open a new `iterm`.

```console
echo 'eval "$(pyenv init -)"' >> .zshrc
```
then we set the Python version 3.9.1 globally.

```console
pyenv global 3.9.1
```

Installing Jupyter
-------------------------
With the next command, we can install `jupyter` using `pip3` that is a package management system useful to install and manage software packages written in Python.

```console
pip3 install jupyter
```

Running Jupyter
-------------------------
Once jupyter is installed we can run a jupyter notebook with the following command.

```console
jupyter notebook
```
And 'voila' we have jupyter notebook running in our Macbook air m1 on <a href="http://localhost:8888/tree">http://localhost:8888/tree</a>

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/jupyter-notebook.png)
{: refdef}

Fixing the Jupyter kernel issue
----------------------------------- 
There's a problem with Jupyter notebook kernel that stops working in our shiny Macbook m1 laptops. A workaround is explained in this <a href="https://www.youtube.com/watch?v=mwmke957ki4&feature=youtu.be&t=2740">George Hotz youtube video</a>.

We have to look for `eventloops.py` file in our system. To do this we can execute the following command:

```console
find / -name eventloops.py
```

Then in my case, I found the file in the following path that I opened using `vi` 

```console
vi /System/Volumes/Data/opt/homebrew/lib/python3.9/site-packages/ipykernel/eventloops.py
```

We have to navigate to the function `def _use_appnope()` and the line of code to change is the return line. After V('10.9'), we have to add: 

```console
and platform.mac_ver()[2] != 'arm64'
```
we save and close the file and the kernel should not stop anymore :-)

Conclusion
------------------------
In this post, we have seen how to install Jupyter notebook in a Macbook air m1. Now it's time to see what things we can do with Jupyter notebooks but this will be in another post.


