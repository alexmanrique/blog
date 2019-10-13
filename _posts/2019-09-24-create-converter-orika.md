---
layout: single
title: "Creating an Orika converter"
date: 2019-09-24 00:13:53 +0200
categories: development
comments: true
lang: en
tags: mappers, java, converter
---

If we think in a Java REST api that we want to build it would be a good practice that the 
> requests objects of your api should not be used inside your application and avoid coupling your logic to a particular version of your api. 

Then in this scenario you would have requests objects from version x and a set of objects that are independent from the version of your api that are really similar, but not equal.

The problem
----------------------------------
How would you map the requests objects into those objects that are really similar? 
The old way would be to create all mappers that translate objects from version X with the generic one's. 

This can lead to bugs like missing one of the attributes of the class to map or have to spend the time to create all the unit tests for the mappers that you are writing
> the less code that you have to write the better.

The solution
--------------------
Here is when <a href="https://orika-mapper.github.io/orika-docs/">Orika</a> comes into play and saves us from creating all the code that would be needed to map all those objects.

Orika is a Java library to map Java beans objects and that recursively copies data from one object to another. Useful when developing multi-layered applications.

When mapping fields by default is not enough
-----------------------------------------
What if one attribute of your class needs one of the other attributes to be set? In the following example we have a class called `PriceCondition` that has 3 fields, an `String` and two `BigDecimal`. 

The problem is that we want to set in those `BigDecimal` the default fraction digits that the `currency` field has, and do it in the constructor. For example the Jordan's fractions digits are 3, but the INR fraction digits are 2. See the following link for <a href="https://www.geeksforgeeks.org/currency-getdefaultfractiondigits-method-in-java-with-examples/">more</a> examples. 

In the constructor we need to call:

```java
minApparentPrice.setScale(Currency.getInstance(currency).getDefaultFractionDigits(), BigDecimal.ROUND_HALF_UP).stripTrailingZeros()
```

Note that we need to use `currency` field in the setter of `minApparentPrice` and `maxApparentPrice` to set the scale properly.

```java
package com.mycompany.contract.v1.conditions

public class PriceCondition {
	
private final String currency;

private final BigDecimal minApparentPrice;

private final BigDecimal maxApparentPrice;

}
```

Bidirectional custom converter
-----------------------

Then in the following lines we can see a bidirectional <a href="https://orika-mapper.github.io/orika-docs/converters.html">custom converter</a> that does the job:

```java
     
package com.mycompany.configuration.converter;

import com.mycompany.generic.conditions.ApparentPriceCondition;
import ma.glasnost.orika.MappingContext;
import ma.glasnost.orika.converter.BidirectionalConverter;
import ma.glasnost.orika.metadata.Type;

import java.math.BigDecimal;
import java.util.Currency;

public class PriceConditionConverter extends BidirectionalConverter<com.odigeo.marketing.promo.campaigns.v3.conditions.PriceCondition, PriceCondition> {

    @Override
    public PriceCondition convertTo(com.mycompany.v3.conditions.PriceCondition priceCondition, Type<PriceCondition> type, MappingContext mappingContext) {
        PriceCondition result = new PriceCondition(
        getPriceValue(priceCondition.getMaxPrice(), priceCondition.getPriceCurrency()),
        getPriceValue(priceCondition.getMinPrice(), priceCondition.getPriceCurrency()),
        priceCondition.getPriceCurrency());
        return result;
    }

    @Override
    public com.mycompany.v3.conditions.PriceCondition convertFrom(PriceCondition priceCondition, Type<com.mycompany.v3.conditions.PriceCondition> type, MappingContext mappingContext) {
        com.mycompany.v3.conditions.PriceCondition result = new com.mycompany.v3.conditions.PriceCondition(
        getPriceValue(priceCondition.getMaxPrice(), priceCondition.getPriceCurrency()),
        getPriceValue(priceCondition.getMinPrice(), priceCondition.getPriceCurrency()),
        priceCondition.getPriceCurrency());
        return result;
    }

    private BigDecimal getPriceValue(BigDecimal input, String currency) {
        BigDecimal result = null;
        if (input != null) {
            result = input.setScale(Currency.getInstance(currency).getDefaultFractionDigits(), BigDecimal.ROUND_HALF_UP).stripTrailingZeros();
        }
        return result;
    }

}


```

Conclusion
-----------------------
In this post we have seen how to map objects using Orika and the creation of a custom converter. We have also seen the benefits of using Orika in your application and what it means in terms of reducing the amount of code that you need to mantain. 


















  












