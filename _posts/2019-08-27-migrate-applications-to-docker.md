---
layout: single
title: "Developing before and after Docker"
date: 2019-08-27 00:13:53 +0200
categories: development
comments: true
lang: en
tags: docker, application, datasource
---

Before Docker
-------------------------
When I started my <a href="https://www.linkedin.com/in/amanrique/">carrer</a> as a software developer in 2009 and I had to develop an application I needed to install all the services before starting to write a single line of code. It means installing <a href="https://www.mysql.com/">mysql</a> in my computer, installing <a href="https://wildfly.org/">JBoss</a>, <a href="https://tomcat.apache.org/">Tomcat</a> or whatever application server needed for the software. 

Configurations out of control
------------------------------
That was a waste of time because - and a source of problems - i.e: configurations in the `standalone.xml` in JBoss, exact version of application server, exact version of jvm with the same configuration to start, installing certificates to have SSL ...

What happened if the configuration was different depending on the <a href="https://dltj.org/article/software-development-practice/">development environment</a>? (dev, integration, staging, production)
That would mean that your app doesn't behave the same way in the different environments, so if you have tested your app in your computer or in a integration environment you would get different results.  

After Docker
-------------------------
<a href="https://en.wikipedia.org/wiki/Docker_(software)">Docker</a> automates the deployment of applications within software <a href="https://en.wikipedia.org/wiki/OS-level_virtualisation">containers</a>, providing an additional layer of abstraction and automation of application <a href="https://en.wikipedia.org/wiki/Virtualization">virtualization</a> on multiple operating systems.

With Docker life is easier. You clone a repository from your code repository and you just need to create the docker image and run `docker compose up` if a `docker-compose.yml` exists in the repository.

Docker compose
-----------------------------

<a href="https://docs.docker.com/compose/">Docker Compose</a> is a tool for defining, running, and managing multi-container Docker applications. Services are defined in a configuration file (a <a href="https://yaml.org/">YAML</a> format) and can be created and run all together with a single command.

See below an example of docker-compose.yml 

{% highlight xml %}
version: '3'
services:
  my-micro-service:
    image: my-micro-service
    container_name: "my-micro-service"
    ports:
      - "8080:8080"
      - "8787:8787"
    volumes:
    - ./log/:/opt/jboss/jboss-eap-6.4/standalone/log
    environment:
      - ENVIRONMENT_VARIABLE=environment_value
{% endhighlight %}

This command creates you all necessary to run your app locally and start your development. If you need <a href="https://kafka.apache.org/">kafka</a> you can run it adding in the docker compose, if you need an <a href="https://www.elastic.co/">elasticsearch</a> you can do it also, if you need <a href="https://neo4j.com/">neo4j</a> or mysql you can add it too. 

No need to install manually in your computer it saves a lot of time to you as a developer, and if your team where you are working is big enough you can save time and money to your company.

Resources separated by environment
-------------------------------------------
All the properties and files that you need to configure your application should be inside your repository. The different <a href="https://docs.jboss.org/jbossas/docs/Getting_Started_Guide/beta422/html/Using_other_Databases-DataSource_Configuration_Files.html">datasource configuration files</a> should be in the different folders according to each environment.

In a Java application you would have a folder for each environment with the properties and other resources that you need to have in each environment. 

I.e: You would have a datasource file for dev which points to the development database, you would have a datasource for integration environment pointing to a database that is a copy of production and you would have a datasource pointing to production database.

> Code repository has to be the source of truth of your application, everything should be inside it to be able to run it like you were in production.

Vault to store secrets
-------------------------------------------
One thing that should be considered is that passwords should not be inside your repository. You should use something like <a href="https://www.vaultproject.io/">vault</a> to store passwords and connect to it to retrieve those passwords when are needed and not storing them in the repository.  

Conclusion
-----------------------
Life is easier for developers now with Docker because we don't have to dedicate time to install all the services that your app is using and we can start developing much faster.

Having everything in the repository helps reducing errors because you have all the configurations that your application needs to work and you don't have differences between environments cause what you deploy to production is the same that you deploy in all the environments.

In the links below you can find more info if you are interested to Dockerize your Java application.

Links
--------------------------
- https://runnable.com/docker/java/dockerize-your-java-application
- https://www.atlassian.com/blog/software-teams/deploy-java-apps-with-docker-awesome
- https://www.oreilly.com/ideas/how-to-manage-docker-containers-in-kubernetes-with-java













  












