---
layout: single
title: "How to document your Java REST api"
date: 2020-09-26 13:45:53 +0200
categories: development
comments: true
lang: en
tags: jaxrs, code, job
image: images/swagger-documentation.png 
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/swagger-documentation.png)
{: refdef}

In this post, we are going to explore how to document our Java REST API using Swagger. It's important to have good documentation that is easy to maintain and that is easy to share with your team and with your stakeholders and Swagger it's a good way to achieve these goals.

What is Swagger?
----------------
<a href="https://swagger.io/">Swagger</a> it's a platform that one of the things that we can do is to document our Java REST API's using <a href="https://github.com/swagger-api/swagger-ui">Swagger UI</a>. It provides us more functionalities that we can explore in their documentation like designing APIs, however, we are not going to cover them in this article. I will share my experience using it to document a REST API. 

Why documenting our Java REST API's?
------------------------------
Having documentation that is attached to the code it's a good thing because when you do changes in your code you are forced to also change the documentation. 

```java
@Api(produces = "application/json", value = "Operations related with the pet store")
public class PetServiceController {
```

If the documentation is far from the code there are more possibilities that when you change something you don't update the documentation. 

With this way of documenting we achieve that the consumers of this documentation learn about:
- How to use the code
- What the code does

How does Swagger look like? 
---------------------------
When you have Swagger in place working you will be able to share to developers from other teams, other product managers/product owners, and other stakeholders a good up to date documentation of the different endpoints of your API and also with ready to use examples to get familiar with. 

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/swagger.png)
{: refdef}

In the following link you can see a live example of  <a href="https://petstore.swagger.io/?_ga=2.25871421.1425290472.1601114879-866601831.1599386328#/">a pet store API</a> using Swagger UI.

Is it hard the documentation maintenance with Swagger?
-------------------------------
Because Swagger is attached to the code, if developers are changing the API, if in their <a href="{{ site.baseurl }}{% post_url 2020-09-17-my-favourite-pull-requests %}">pull request</a> they have not updated the code to show the changes we can request them to update them. 

If the documentation is in a wiki page is more difficult to remember to update the documentation, but if we have it in the code the developer is forced to keep it up to date.

If we check the stars that has the Swagger UI <a href="https://github.com/swagger-api/swagger-ui">repository</a> in Github, they have 18,6k stars, so the odds that the project is discontinued are low. 

How to add Swagger to your API?
-----------------------------------
We need to add in the `pom.xml` file of your Maven project the following dependencies. As we said in the article <a href="{{ site.baseurl }}{% post_url 2018-01-24-managing-maven-dependencies %}"> managing maven dependencies</a> it's a good practice to use `<dependencyManagement>` tag to set the version of dependency that we are going to use in the whole project.  

```java
   <properties>
       <swagger.version>1.5.20</swagger.version>
       <build.artifacts.classifier/>
   </properties>

<dependencymanagement>
   <dependency>
       <groupId>io.swagger</groupId>
       <artifactId>swagger-jaxrs</artifactId>
       <version>${swagger.version}</version>
   </dependency>
   <dependency>
       <groupId>io.swagger</groupId>
       <artifactId>swagger-annotations</artifactId>
       <version>${swagger.version}</version>
   </dependency>

```

Then after it we have to create a controller that extends `ApiListingResource` class and set the path in the annotation where the swagger file with the API specification will be placed.  

```java
import io.swagger.jaxrs.listing.ApiListingResource;

import javax.ws.rs.Path;

@Path("/api-docs/swagger.{type:json|yaml}")
public class SwaggerApiController extends ApiListingResource {
}

```

Then in the class that extends <a href="https://docs.oracle.com/javaee/7/api/javax/ws/rs/core/Application.html">`Application`</a> class we have to initialize Swagger using the previous controller that we have defined.

```java

public class ServiceApplication extends Application {

    private final Set<Object> singletons = new HashSet<>();

    public ServiceApplication(@Context ServletConfig sc) {
        initializeSwagger(sc);
        buildRestControllers();
    }

    private void buildRestControllers() {
        singletons.add(new SwaggerApiController());
    }

    private void initializeSwagger(ServletConfig sc) {
        Info info = new Info()
                .title("my jaxrs api")
                .description("my jaxrs service")
                .contact(new Contact().email("contact@alexmanrique.com").name("manriqueapps"));
        Swagger swagger = new Swagger().info(info);
        BeanConfig beanConfig = new BeanConfig();
        beanConfig.setResourcePackage("com.manriqueapps");
        beanConfig.setInfo(info);
        beanConfig.setBasePath("/myjaxrs-service");
        beanConfig.configure(swagger);
        new SwaggerContextService()
                .withServletConfig(sc)
                .withScanner(beanConfig)
                .updateSwagger(swagger)
                .initScanner();
    }

    @Override
    public Set<Object> getSingletons() {
        return new HashSet<>(singletons);
    }
}

```

Then we have to define in the <a href="https://docs.oracle.com/cd/E26180_01/Platform.94/ATGIntFrameGuide/html/s0204webxmlfile01.html">`web.xml`</a> file the servlet-mapping for the different Swagger urls.

```java
  <servlet-mapping>
        <servlet-name>resteasy-servlet</servlet-name>
        <url-pattern>/v1/*</url-pattern>
        <url-pattern>/api-docs/*</url-pattern>
        <url-pattern>/swagger/*</url-pattern>
  </servlet-mapping>

  <context-param>
        <param-name>resteasy.providers</param-name>
        <param-value>
            io.swagger.jaxrs.listing.SwaggerSerializers
        </param-value>
  </context-param>
```
In the different operations of our service we have to use the annotation `@ApiOperation` to explain what the operation is doing or `@ApiResponse` to document the possible responses that the operation can return.

```java

@Api(produces = "application/json", value = "Operations related with the pet store")
public class PetServiceController {

  @ApiOperation(value = "Create a new pet", response = YourResponseEntity.class)
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Successfully created a new Pet"),
            @ApiResponse(code = 401, message = "You are not authorized to view the resource"),
            @ApiResponse(code = 403, message = "Accessing the resource you were trying to reach is forbidden"),
            @ApiResponse(code = 404, message = "The resource you were trying to reach is not found"),
            @ApiResponse(code = 500, message = "Application failed to process the request")
            public PetResponse createPet (CreateRequest petRequest){
              // 
            }
    }
```

We have to define also an HTML file that will load all the operations of the API using the `swagger.json` file that we are generating (This file needs to be placed in the webapp directory in your Java maven project)

```java

<!-- HTML for static distribution bundle build -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Swagger UI</title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700|Source+Code+Pro:300,600|Titillium+Web:400,600,700" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/swagger-ui-dist@3/swagger-ui.css" >
    <link rel="icon" type="image/png" href="https://unpkg.com/swagger-ui-dist@3/favicon-32x32.png" sizes="32x32" />
    <link rel="icon" type="image/png" href="https://unpkg.com/swagger-ui-dist@3/favicon-16x16.png" sizes="16x16" />
    <style>
      html
      {
        box-sizing: border-box;
        overflow: -moz-scrollbars-vertical;
        overflow-y: scroll;
      }

      *,
      *:before,
      *:after
      {
        box-sizing: inherit;
      }

      body
      {
        margin:0;
        background: #fafafa;
      }
    </style>
  </head>

  <body>
    <div id="swagger-ui"></div>
    <script src="https://unpkg.com/swagger-ui-dist@3/swagger-ui-bundle.js"></script>
    <script src="https://unpkg.com/swagger-ui-dist@3/swagger-ui-standalone-preset.js"></script>

    <script>
    window.onload = function() {
      // Build a system
      const ui = SwaggerUIBundle({
        url: "../../api-docs/swagger.json",
        dom_id: '#swagger-ui',
        deepLinking: true,
        presets: [
          SwaggerUIBundle.presets.apis,
          SwaggerUIStandalonePreset
        ],
        plugins: [
          SwaggerUIBundle.plugins.DownloadUrl
        ],
        layout: "StandaloneLayout"
      })

      window.ui = ui
    }
  </script>
  </body>
</html>

```

Conclusion
----------------------------
In this post, we have seen why it's important to document our API and how Swagger can help us to achieve this objective. If you want to see how to use Swagger with Spring boot in this  <a href="{{ site.baseurl }}{% post_url 2020-09-04-spring-boot-hello-world %}"> post </a> I explain how to do a Hello world with Spring boot and the API that the app deploys is using Swagger. You can find the code for the Spring boot hello world with Swagger in the following <a href="https://github.com/alexmanrique/spring-boot-application-example">link</a>. 








