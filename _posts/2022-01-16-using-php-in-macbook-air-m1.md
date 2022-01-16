---
layout: single
title: "Using PHP in MacBook air M1"
date: 2022-01-16 09:08:53 +0200
categories: development
comments: true
lang: en
tags: php, m1
image: 
---

In the following post, I'm going to explain what I had to do to run a CakePHP application on my MacBook air m1. 

Trying to run cake server on my localhost
--------------------------------------------

Some days ago I found myself trying to run a <a href="https://cakephp.org/">cakephp</a> application that I maintain. The application is a website with a frontend (html5, CSS, Javascript) and the backend is using a PHP framework called CakePHP. As the database is using a Mysql that is included in my shared hosting. 

When I tried to run the CakePHP server on my localhost using the following command:

```console
$> ./cake server
```

I got the following error message:

```console
PHP Warning:  PHP Startup: Unable to load dynamic library 'intl' (tried: /usr/lib/php/extensions/no-debug-non-zts-20180731/intl (dlopen(/usr/lib/php/extensions/no-debug-non-zts-20180731/intl, 9): image not found), /usr/lib/php/extensions/no-debug-non-zts-20180731/intl.so (dlopen(/usr/lib/php/extensions/no-debug-non-zts-20180731/intl.so, 9): image not found)) in Unknown on line 0
PHP Fatal error:  You must enable the intl extension to use CakePHP.
```

PHP Intl extension
--------------------
The <a href="https://www.php.net/manual/en/intro.intl.php">Internationalization</a> extension (Intl) is a wrapper for the ICU library, a set of C/C++ and Java libraries that provide Unicode and Globalization support for software applications. It enables PHP programmers to perform UCA-conformant collation and date/time/number/currency formatting in their scripts.

I guess that `intl` dynamic library has been removed in some MacOS operating system update during the last weeks. 

Trying to run PHP 
------------------------

Also when trying to run the following command:

```console
php -v                                                                                      
```

I could read the following message:

```console
PHP Warning:  PHP Startup: Unable to load dynamic library 'intl' (tried: /usr/lib/php/extensions/no-debug-non-zts-20180731/intl (dlopen(/usr/lib/php/extensions/no-debug-non-zts-20180731/intl, 9): image not found), /usr/lib/php/extensions/no-debug-non-zts-20180731/intl.so (dlopen(/usr/lib/php/extensions/no-debug-non-zts-20180731/intl.so, 9): image not found)) in Unknown on line 0
WARNING: PHP is not recommended
PHP is included in macOS for compatibility with legacy software.
Future versions of macOS will not include PHP.
PHP 7.3.24-(to be removed in future macOS) (cli) (built: Feb 28 2021 09:53:14) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.3.24, Copyright (c) 1998-2018 Zend Technologies
```

Apple official notes
--------------------------
I looked for information about this topic and I found the following <a href="https://developer.apple.com/documentation/macos-release-notes/macos-catalina-10_15-release-notes">release</a> notes where they shared the following notes: 

> Scripting Language Runtimes

> Deprecations

> Scripting language runtimes such as Python, Ruby, and Perl are included in macOS for compatibility with 
> legacy software. Future versions of macOS won’t include scripting language runtimes by default and might
> require you to install additional packages. If your software depends on scripting languages, it’s 
> recommended that you bundle the runtime within the app.

Apple intends to remove scripting languages runtime in future releases and they advise that is your responsibility to provide PHP to run your apps. 


Installing PHP with homebrew
-------------------------------

The first solution to the problem that we face is to install PHP using `homebrew`. Using the following command in the command line we can install version 7.4 of PHP.

```console
$> brew install php@7.4
```

The following command creates symlinks to the previous installation we performed manually in Cellar. This allows us to have the flexibility to install things on our own but still have these participate as dependencies in homebrew formulas.

```console
$> brew link php@7.4 --force
```

After installing it if we run the command to see the version of PHP that we have available in our `$PATH` 

```console
$> php -v 
```

We see that the previous error doesn't show anymore:

```console
PHP 7.4.27 (cli) (built: Dec 16 2021 18:14:21) ( NTS )
Copyright (c) The PHP Group
Zend Engine v3.4.0, Copyright (c) Zend Technologies
    with Zend OPcache v7.4.27, Copyright (c), by Zend Technologies
```

Using Docker to run your CakePHP app
----------------------------------------
The second option that we have is to take advantage of docker. To do so we can use the <a href="https://github.com/stefanvangastel/docker-cakephp/blob/master/Dockerfile">Dockerfile</a> from the following <a href="https://github.com/stefanvangastel/docker-cakephp">Github repository</a>:

Then we can run the following commands to build the container image:

```console
docker build -t my-app . 
```

and run it:

```console
docker run -p 8080:80 -d my-app 
```

In this case, we will be able to run a PHP app without installing it locally.

Conclusion
---------------
Hope the post was helpful and that you can run your PHP applications on your MacBook air.


