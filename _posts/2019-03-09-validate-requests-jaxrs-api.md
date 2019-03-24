---
layout: single
title: "Validate requests in a Java Rest API"
date: 2019-03-09 00:13:53 +0200
categories: development
comments: true
lang: es
tags: development
---

{:refdef: style="text-align: center;"}
![Bad request]({{ site.baseurl }}/images/bad_request_api.png)
{: refdef}

The same way that we have to validate the input of our users in a form, validating what they introduce and displaying them
that they have introduced wrong some input we have to do the same in a rest api.

If we want to validate the requests that we receive in our java backend endpoint we can use <a href="https://docs.oracle.com/javaee/7/api/javax/validation/constraints/package-summary.html">javax validations</a> annotations in
our request objects.

{% highlight java %}
@NotNull
private int age;
@Min(value=30000)
private int salary;

{% endhighlight %}

When the backend receives a request we have to validate that the values meet the constraints.

> Suppose that the user will send bad values in his request and be ready for that.

To do it we can instantiate a `ValidatorFactory` and call `validate` method to check that all the constraints are fulfilled.

{% highlight java %}
ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
Validator validator = factory.getValidator();
Set<ConstraintViolation<Campaign>> violations = validator.validate(campaignGeneric);
if (!violations.isEmpty()) {
   String errorMessage = buildErrorMessage(violations);
   throw new YourException(errorMessage);
}
{% endhighlight %}

The above code can be improved because there’s no need to instantiate the ValidatorFactory this way. We can use `@ValidateRequest`
and `@Valid` annotations to do it for us. Our resource class has to be tagged with `@ValidateRequest` and the parameters in the
methods with @Valid.

{% highlight java %}
import org.jboss.resteasy.spi.validation.ValidateRequest;

import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import java.util.ArrayList;
import java.util.List;

@Path("path")
@Produces({"application/json;charset=UTF-8"})
@ValidateRequest
public class YourApiResource {

   @POST
   @Path("/subpath")
   @Consumes({"application/json"})
   @Produces({"application/json"})
   public List<Response> aMethod(@Valid Request aRequest) {
   }
{% endhighlight %}

To use the annotations that we were talking about we need to use the following dependencies in the pom.xml file of our Java maven project.

{% highlight xml %}
<dependency>
   <groupId>org.jboss.resteasy</groupId>
   <artifactId>resteasy-jaxrs</artifactId>
   <version>[2.3.10.Final]</version>
   <scope>provided</scope>
</dependency>

<dependency>
   <groupId>org.jboss.resteasy</groupId>
   <artifactId>resteasy-hibernatevalidator-provider</artifactId>
   <version>[2.3.6.Final]</version>
   <scope>provided</scope>
</dependency>
{% endhighlight %}

Note that in the maven dependency we have set scope `provided`. It’s important to check libraries that your application
server comes with. In case that we are using JBoss application server we have to check in the modules folder.

> Use provided in the maven dependencies when your application server has the library.

If we do:

{% highlight xml %}
$> ls /opt/jboss/jboss-eap-6.4/modules/system/layers/base

asm  ch  com  gnu  ibm  javaee  javax  net  nu  org  sun
{% endhighlight %}

We will get a list of folders where the different libraries that come in the JBoss application server.

Once you know which libraries you have in your application server is good to use them instead of providing your own.

The good thing to use hibernate validator is that this library comes with a lot of annotations that help us validate
things in the requests that our api receives. When our API is running we get `HibernateValidatorAdapter` for free,
that will check if our constraints are fulfilled.

{% highlight java %}
class HibernateValidatorAdapter implements ValidatorAdapter {

  private final Validator validator;
  private final MethodValidator methodValidator;

  HibernateValidatorAdapter(Validator validator) {
     if( validator == null )
        throw new IllegalArgumentException("Validator cannot be null");
    
     this.validator = validator;
     this.methodValidator = validator.unwrap(MethodValidator.class);
  }

  @Override
  public void applyValidation(Object resource, Method invokedMethod,
        Object[] args) {
...
{% endhighlight %}

> Use the libraries and don't reinvent the wheel writing code that has been already written

Using Exception Mappers
----------------------------
If we don't provide an exception mapper our api will return a 500 Internal server error code because a `MethodConstraintViolationException` is thrown
by the `ValidatorAdapter` which is not the most desired response for our clients.
It's better in this situation to return a bad request to our clients. This is what the next mapper is doing.

> Return suitable http codes to your api clients depending on each situation.

{% highlight java %}
import org.hibernate.validator.method.MethodConstraintViolation;
import org.hibernate.validator.method.MethodConstraintViolationException;

import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;
import java.util.HashMap;
import java.util.Map;

@Provider
@Produces(MediaType.APPLICATION_JSON)
public class MethodConstraintViolationExceptionMapper implements ExceptionMapper<MethodConstraintViolationException> {

   @Override
   public Response toResponse(MethodConstraintViolationException ex) {
       Map<String, String> errors = new HashMap<>();
       for (MethodConstraintViolation<?> methodConstraintViolation : ex.getConstraintViolations()) {
           errors.put(methodConstraintViolation.getPropertyPath().toString(), methodConstraintViolation.getMessage());
       }
       return Response.status(Response.Status.BAD_REQUEST).entity(errors).build();
   }
}

{% endhighlight %}

Response received when using exception mapper
-----------------------------------------------------------
Finally if we test the API and we don't send all the parameters we receive a 400 Bad request error with a message of the value that we are missing.

{% highlight json %}
{
    "Resource#method(arg0).attribute": "may not be null"
}
{% endhighlight %}

Conclusion
--------------------------------------------------
In this post we have seen how to validate requests in our rest api using Java annotations.
We have seen also some principals like knowing our app server libraries or sending the suitable error codes to our api clients.


 

