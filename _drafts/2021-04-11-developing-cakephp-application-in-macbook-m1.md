---
layout: single
title: "How to set up a CakePHP application in Macbook Air M1"
date: 2021-04-11 00:00:00 +0200
categories: development
comments: true
lang: en
tags: php
image: 
---

In this post I'm going to summarize the steps that I followed to have running on my Macbook Air M1 a <a href="https://cakephp.org/">CakePHP</a> application using <a href="https://mariadb.org/">MariaDB</a> as a database.

## PHP and MacOS big Sur are not good friends

If we look for where PHP is installed in macOS big Sur we find it in `/etc/` directory. If you don't know where you have it you can run the following command.

```console
ls -l $(which php)
````
If we list the files that we have in `/etc/` directory we have the following files. 

```console
ls -la | grep php
-r--r--r--   1 root  wheel     145  1 ene  2020 php-NOTICE-PLANNED-REMOVAL.txt
-rw-r--r--   1 root  wheel    5331  1 ene  2020 php-fpm.conf.default
drwxr-xr-x   3 root  wheel      96  1 ene  2020 php-fpm.d
-r--r--r--   1 root  wheel   71553 28 mar 19:23 php.ini
-r--r--r--   1 root  wheel   71554 28 mar 19:22 php.ini.default
``` 

You can notice a `php-NOTICE-PLANNED-REMOVAL.txt` file warning you that PHP will be removed from newer versions of the operating system. 

```console
WARNING: PHP is not recommended.
PHP is included in macOS for compatibility with legacy software.
Future versions of macOS will not include PHP.
```

To know which version of PHP I had installed on my computer I run the following command

```console
php -v 
```

After trying to uncomment the line where the `intl` extension was defined on `/etc/php.ini` file  

```console
; - Many DLL files are located in the extensions/ (PHP 4) or ext/ (PHP 5+)
;   extension folders as well as the separate PECL DLL download (PHP 5+).
;   Be sure to appropriately set the extension_dir directive.
;
;extension=bz2
;extension=curl
;extension=fileinfo
;extension=gd2
;extension=gettext
;extension=gmp
extension=intl
``` 
I had the same error as before, so I decided to install a separate version of PHP using Homebrew.

## Installing PHP through Homebrew

Then I could list which versions were available to install using `brew`. 

```console
brew list | grep php
```

I decided to install version 7.2 of PHP 

```console
brew install php@7.2
```

Then using the link command of brew I forced the usage of the version that I had previously installed.

```console
brew link --force php@7.2
```
## Adding newly installed PHP version to the PATH

Then I added in the `.zshrc` file the path to the installation directory `bin` and `sbin` of `php`

```console
echo 'export PATH="/opt/homebrew/opt/php@7.2/bin:$PATH"' >> ~/.zshrc
```

```console
echo 'export PATH="/opt/homebrew/opt/php@7.2/sbin:$PATH"' >> ~/.zshrc
```

The following command is helpful to find where the php.ini file is located.

```console
php --ini
Configuration File (php.ini) Path: /opt/homebrew/etc/php/7.2
Loaded Configuration File:         /opt/homebrew/etc/php/7.2/php.ini
Scan for additional .ini files in: /opt/homebrew/etc/php/7.2/conf.d
Additional .ini files parsed:      /opt/homebrew/etc/php/7.2/conf.d/ext-opcache.ini
```

## Installing composer 

For CakePHP the first thing that I had to do was execute the following command to install `composer`:

```console
brew install composer
```

```console
composer install
```

## Updating captcha-com plugin

Then once composer was installed I was able to update the captcha plugin that I'm using to filter spambots.

```console
composer update captcha-com/cakephp-captcha --no-plugins
```

## Running cake 

To run a cake application locally we can use a built-in server going to the `bin/` folder and executing `bin/cake server` command. If we have done the previous installation properly we will be able to run the previous command good and we will see the following output in the command line.

```console
bin/cake server

Welcome to CakePHP v3.6.7 Console
---------------------------------------------------------------
App : src
Path: /path-to-your-application/src/
DocumentRoot: /path-to-your-application/webroot
Ini Path:
---------------------------------------------------------------
built-in server is running in http://localhost:8765/
You can exit with `CTRL-C`
```

## Creating a docker-compose.yml  

My CakePHP application is using a relational database to store data. Every time that I had to change the computer I had to install MariaDB, then, a way to avoid this is to use docker to run an instance of MariaDB. Here we can see the `docker-compose.yml` file where we specify   

``` yaml
version: '3.1'
services:
  db:
    image: mariadb
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example
  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080
```

## Connection refused to MariaDB

I was trying to connect to MariaDB from the CakePHP application but I was getting connection refused. I didn't understand why because MariaDB was starting successfully.

```
SQLSTATE[HY000] [2002] Connection refused cakephp
``` 

Then I realized that was not defining the database ports in the yaml file of `docker-compose.yml`. 

```yaml
version: '3.1'
services:
  db:
    image: mariadb
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example
    ports:
      - 3306:3306
  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080
```

## Conclusion

In this post, we have seen how to install PHP and run CakePHP application using a MariaDB database running inside docker in a Macbook Air M1.