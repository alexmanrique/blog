---
layout: single
title: "Ten tips to improve your unit tests"
date: 2021-09-11 09:08:53 +0200
categories: development
comments: true
lang: en
tags: testing, quality, tdd, unit-test
image: images/10-tips-improve-unit-tests.jpg
---

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/10-tips-improve-unit-tests.jpg)
{: refdef}

{:refdef: style="text-align: center;font-size:9px"}
Photo by <a href="https://unsplash.com/@casparrubin?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Caspar Camille Rubin</a> on <a href="https://unsplash.com/s/photos/quality?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
{: refdef}  
  
The same way that production code has to have quality, the same happens with unit tests. In the following post, we are going to talk about 10 tips to improve the quality of your unit tests.    

### 1 - Test happy path and unhappy paths

There are two kinds of cases that we want to test. The first type of test is the one that confirms that a unit indeed behaves as expected on normal input (called happy flow or sunny-side testing). The second kind of test confirms that a unit behaves on non-normal input and circumstances (called unhappy flow or rainy-side testing).

### 2 - Use meaningful names in a method signature

Don't use method names like `testMethod` because this doesn't communicate the intention to the reader of the unit test. We spend much more time reading code rather than writing it so, we need to write good method names that express intention. Things like `shouldReturn...` or `shouldCalculateTheSame...` communicate more than a simple `testMethod`. 

### 3 - Test one thing in each unit test

If we are using more than one `assert` per test it means that we could be unit testing more than one thing in the same test. It's a good thing to split this into different tests rather than having everything into the same one. A method should test one thing and do it well. 

### 4 - Use beforeMethod instead of beforeClass

Tests execution has to be independent of one another and using `beforeClass` annotation can lead to using the same variables that have been used in a previous unit test with the state that they had at the end of the test. With `beforeMethod` you ensure that you restart the state for the execution of the next unit test. You should be able to execute the tests in any order and the execution result should be the same.

### 5 - Use the "given, when, then" structure

Every unit test should follow this structure. Given these objects, when calling these mocked objects we expect these responses, we call the method under test, and finally, we confirm the expected results.

```java

@Test

void shouldReturnTheSameAmountOfMoney(){

    //given the following input objects

    //when there are the following interactions

    //call the method being tested

    //then assert the expected output

}

```

### 6 - Mock roles not objects

You have to mock calls to methods that are not implemented in the class that you are testing, and use real objects for inputs and outputs. In the following paper you can read more about this <a href="http://jmock.org/oopsla2004.pdf">concept</a>. One should try to mock object roles not object states. 

> The idea is to test interactions between objects, not the objects themselves.

If you follow this principle you will improve your unit test and also the class that is being tested. 

### 7 - Don't repeat code in different tests

If you have different unit tests to test different conditionals of a particular method reuse the code to create the inputs to call that method. If you are creating a unit test for a service that has input and output objects the idea is to create a separate class that creates these objects to reuse this code in other unit tests.

### 8 - Don't depend on time in your unit tests

You should never rely on current system time, if you do this then you have coupled your class to the server’s clock like the time of the server where your unit test is being executed. This could lead to random tests failures.

### 9 - Name the unit test class with the same name with a test prefix

It might be something obvious but to look for the unit test of a particular class the test must be named equal to the original class otherwise it will be difficult to find in the code and the coverage tools will not consider that you are testing the original class.

### 10 - Extract literals to constants in the test

The same way that in code you should not use magical numbers, you should not use them in a unit test class. At the beginning of the test class, you should see the constants that the class is using and other variables that your unit test needs. For variables you should use generic names to emphasize that this variable values could be different from the ones used in the test.

### Bonus - If the test is difficult to write it means that ... 

For code that is already written and that doesn't have tests if it's difficult to write a unit test it means that the class under test has room for improvement. You should not have static methods, hardcoded dependencies that you cannot mock in the class under test.

Following Test-driven development (TDD) is the best you can do to have a good software design. Starting writing the test first and writing the implementation after forces you to think about the inputs and the outputs of the methods and leads you to a good software design. 

### Conclusion

We have seen in this post different tips to improve the quality of unit tests. Do you have any tips to write better unit tests?