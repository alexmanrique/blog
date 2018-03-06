---
layout: single
title:  "Using dependency injection"
date:   2018-02-26 20:13:53 +0200
categories: development
comments: true
lang: en
ref: review
tags: java code clean 
---

When you write code you have to think that every <a href="https://en.wikipedia.org/wiki/Java_class_file">class</a> represents a unit of code that should be testable by itself. 
If you can't write a <a href="https://en.wikipedia.org/wiki/Unit_testing">unit test</a> without executing the logic 
of another class it means that your class is <a href="https://www.geeksforgeeks.org/coupling-in-java/">coupled</a> with the other class, which means that you can't 
change easily the dependency to the other class. 

In the following example we are going to see three different ways to use `PaymentService` in `BankAccountController` class and how we can write a unit 
test for this class in each situation.  

1 - Hardcoding dependency :-(
-------------------------------

Ideally Java classes should be as independent as possible from other Java classes. If the Java class 
creates an instance of another class via the new operator, it cannot be used (and tested) 
independently from this class and this is called a hard dependency.

In the code below `BankAccountController` uses `PaymentService` in the `transferMoney` method. 

```java

public class BankAccountController {
	
public BankAccountController(){

}

public BigDecimal transferMoney(){

PaymentService paymentService = new PaymentServiceImpl();
paymentService.callMethod();
// do other stuff

  }
}

```

This is a bad way of hardcoding `PaymentService` dependency inside `BankAccountController`. What if we want in the future to change the dependency with the `PaymentServiceImpl` and use another implementation of `PaymentService` interface?

The client of this class will will not be able to decide which implementation will be used in `BankAccountController` because it's created inside with the new operator.

{% highlight java %}

BankAccountController bankAccountController = 
new BankAccountController();

{% endhighlight %} 

If you want to unit test `BankAccountController`, your test will execute the code inside `PaymentServiceImpl`, and maybe there's a call to a webservice, a connection to the database is opened or a file is written in the filesystem. 

```java

public class BankAccountControllerTest {
  
private BankAccountController bankAccountController;

@BeforeMethod
public void init(){
  
bankAccountController = new BankAccountController();

}

@Test
public void transferMoney(){
  
  //we will execute code from PaymentServiceImpl :-(

  BigDecimal result = bankAccountController.transferMoney();

  assertEquals(result, new BigDecimal(500));

} 


}
```

2 - Using constructor to decide implementation :-)
--------------------------------

Another approach can be the following code:

```java

public class BankAccountController {

private final PaymentService paymentService;

public BankAccountController(PaymentService paymentService){

   this.paymentService = paymentService;

}

public BigDecimal transferMoney(){

paymentService.callMethod();
// do other stuff

  }
}

```  

In this case the dependency to `PaymentService` is not hardcoded because in the constructor of the class we are passing a `PaymentService` implementation (the one that we prefer) 

That's a better solution than the first one because `BankAccountController` is not coupled with an specific implementation.

Now the client of this class will decide which implementation will be used inside `BankAccountController`.

```java

BankAccountController bankAccountController = 
new BankAccountController(new PaymentServiceImpl());

```


In the unit test you will be able to <a href="http://site.mockito.org/">mock</a> the implementation of `PaymentServiceImpl` and use `when` methods that allow you to control the response of a certain method. 

```java

public class BankAccountControllerTest {

@Mock  
private PaymentService paymentService;

private BankAccountController bankAccountController;

@BeforeMethod
public void init(){
  
MockitoAnnotations.init(this);

// we are passing the mock object in the constructor

bankAccountController = new BankAccountController(paymentService);

}

@Test
public void transferMoney(){
  
  //we are able to mock the call of paymentService :-)

  when(paymentService.callMethod()).thenReturn("OK");

  //we will not call methods of paymentService :-)

  BigDecimal result = bankAccountController.transferMoney();

  assertEquals(result, new BigDecimal(500));

} 

}
```

However, if this class is used by another one of your application (the client class) this class will have to 
decide which implementation has to be used, so, in some way you are still hardcoding the use of this 
implementation in another part of your code. 


3 - Using dependency injection ;-)
-------------------------------
Let's see the third approach:

```java

public class BankAccountController {

private final PaymentService paymentService;

@Inject
public BankAccountController(PaymentService paymentService){
   paymentService = paymentService;
}

public BigDecimal transferMoney(){

paymentService.callMethod();
// do other stuff

  }
}

```


```java

public class PaymentModule extends AbstractModule {
	
  @Override 
  protected void configure() {
   bind(PaymentService.class).to(PaymentServiceImpl.class);
  }

}

```

```java

public static void main(String[] args) {

    Injector injector = Guice.createInjector(new PaymentModule());

    BankAccountController bankAccountController = injector.getInstance(BankAccountController.class);
   
  }

```

In this third approach we are using <a href="https://github.com/google/guice">Google guice</a> as a dependency injection framework.

In this case we use the method `getInstance` of class `Injector` to get an instance of `BankAccountController` without specifying which implementation we are using of `PaymentService` at the time of creating an instance of this class. 

We have separated the configuration (which implementation to use in the code) from the logic of the application.

```java

public class BankAccountControllerTest {

@Mock  
private PaymentService paymentService;

private Injector injector;

private BankAccountController bankAccountController;

@BeforeMethod
public void init(){
  
MockitoAnnotations.init(this);

injector = Guice.createInjector(
         bind(PaymentService.class).to(paymentService));

bankAccountController = injector.getInstance(BankAccountController.class);

}

@Test
public void transferMoney(){
  
  //we are able to mock the call of paymentService :-)

  when(paymentService.callMethod()).thenReturn("OK");

  //we will not call methods of paymentService :-)

  BigDecimal result = bankAccountController.transferMoney();

  assertEquals(result, new BigDecimal(500));

} 

}

```

Conclusion
---------------------- 
Using dependency injection in your code is a better way to write your code without hardcoding dependencies. 
It helps you to write better unit tests because you can mock the dependencies and test a single class 
per unit test.

I recommend <a target="_blank" href="https://www.amazon.com/gp/product/0321503627/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0321503627&linkCode=as2&tag=de8blg6-20&linkId=9241dfe0f4f2811c3d7633aca77e6234">Growing Object-Oriented Software, Guided by Tests</a><img src="//ir-na.amazon-adsystem.com/e/ir?t=de8blg6-20&l=am2&o=1&a=0321503627" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" /> 
where it explains how you can make your software more object oriented using unit tests and supports the idea that if 
your code is difficult to test it means that it must be improved.










