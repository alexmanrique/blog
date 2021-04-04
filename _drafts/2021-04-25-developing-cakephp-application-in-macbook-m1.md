---
layout: single
title: "Developing cakephp application in macbook air m1"
date: 2021-03-20 09:08:53 +0200
categories: development
comments: true
lang: en
tags: elasticsearch
image: 
---

ls -l $(which php)

> /etc/

php -v 

brew list | grep php

brew install php@7.2

brew link --force php@7.2

echo 'export PATH="/opt/homebrew/opt/php@7.2/bin:$PATH"' >> ~/.zshrc

echo 'export PATH="/opt/homebrew/opt/php@7.2/sbin:$PATH"' >> ~/.zshrc

php --ini

brew install composer

composer install

composer update captcha-com/cakephp-captcha --no-plugins

https://stackoverflow.com/questions/31554588/cakephp-3-x-sqlstatehy000-general-error-11-database-disk-image-is-malformed

localhost -> 127.0.0.1

https://stackoverflow.com/questions/29695450/pdoexception-sqlstatehy000-2002-no-such-file-or-directory

SQLSTATE[HY000] [2002] Connection refused cakephp

## Conclusion

