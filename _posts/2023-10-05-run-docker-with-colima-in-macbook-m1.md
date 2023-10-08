---

layout: single
title: "Run Docker with Colima in Macbook M1"
date: 2023-10-05 09:08:53 +0200
categories: development
comments: true
lang: en
tags: macbook, m1
image: images/cloud.jpg

---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/colima.jpg)
{: refdef}
{:refdef: style="text-align: center;font-size:9px"}
Foto de <a href="https://unsplash.com/es/@kylepetzer?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Kyle Petzer</a> en <a href="https://unsplash.com/es/fotos/sD_JW9vvUUA?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
{: refdef}

As Docker Desktop is no longer <a href="https://www.docker.com/pricing/">free</a> of license there's as an alternative that is to use <a href="https://github.com/abiosoft/colima">Colima</a> which allows to run containers on macOS (and Linux).

# Steps to install and use the VM

## Install colima

The first step is to install Colima, which can be done effortlessly using Homebrew:

```
brew install colima
```

## Run the VM

Once Colima is installed, initiate the virtual machine with the desired specifications:

```
colima start --cpu 4 --memory 8 --disk 60 docker
```

## Set DOCKER_HOST

To ensure that Docker commands interact with Colima, you'll need to configure the DOCKER_HOST environment variable. If you don't already have a `.zshenv` file, create one:

- create a .zshenv if not exist

```
touch .zshenv
```

---

- open the .zshenv and add

```
export DOCKER_HOST=unix://$HOME/.colima/docker/docker.sock`
```

---

## Expose VM as default Docker socket

Instead of setting the DOCKER_HOST variable environment you could alternatively create a symlink from the default Docker socket and your colima Docker socket 

```
sudo ln -sfn /Users/$USER/.colima/docker/docker.sock /var/run/docker.sock
```

---

In the former example <instance name> would be **docker** as defined when running the VM

When issuing the command `ln -sfn <target> <source>` you can identify your specific target and source, running

```
docker context ls
```

To stop the Colima virtual machine, use the following command:

```
colima stop
```

If you wish to delete a specific Colima profile, execute:

```
colima delete <profile_to_delete>
```

And to list the available profiles you can run the following command.

```
colima ls 
```

Conclusion
------------------
In this post we have seen how to run Docker with Colima in Macbook M1. Are you using any other alternative? I read you in the comments below.
