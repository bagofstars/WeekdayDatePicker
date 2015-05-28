//
//  BoSDateUnitsUtilitySpec.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 02/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "BoSDateUnitsUtility.h"

SpecBegin(BoSDateUnitsUtility)

describe(@"BoSDateUnitsUtility", ^{

  __block BoSDateUnitsUtility *sut = nil;
  
  beforeAll(^{
    sut = [BoSDateUnitsUtility new];
  });
  
  afterAll(^{
    sut = nil;
  });
  
  it(@"should return correct number of days for given month and year", ^{
    NSInteger nonLeapYear = 1;
    NSInteger leapYear = 4;

    NSInteger daysInNonLeapFebruary = 28;
    NSInteger daysInLeapFebruary = 29;
    NSInteger daysInShortMonth = 30;
    NSInteger daysInLongMonth = 31;

    expect([sut numberOfDaysForMonthNumber:1 yearNumber:nonLeapYear]).to.equal(daysInLongMonth);
    expect([sut numberOfDaysForMonthNumber:2 yearNumber:nonLeapYear]).to.equal(daysInNonLeapFebruary);
    expect([sut numberOfDaysForMonthNumber:3 yearNumber:nonLeapYear]).to.equal(daysInLongMonth);
    expect([sut numberOfDaysForMonthNumber:4 yearNumber:nonLeapYear]).to.equal(daysInShortMonth);
    expect([sut numberOfDaysForMonthNumber:5 yearNumber:nonLeapYear]).to.equal(daysInLongMonth);
    expect([sut numberOfDaysForMonthNumber:6 yearNumber:nonLeapYear]).to.equal(daysInShortMonth);
    expect([sut numberOfDaysForMonthNumber:7 yearNumber:nonLeapYear]).to.equal(daysInLongMonth);
    expect([sut numberOfDaysForMonthNumber:8 yearNumber:nonLeapYear]).to.equal(daysInLongMonth);
    expect([sut numberOfDaysForMonthNumber:9 yearNumber:nonLeapYear]).to.equal(daysInShortMonth);
    expect([sut numberOfDaysForMonthNumber:10 yearNumber:nonLeapYear]).to.equal(daysInLongMonth);
    expect([sut numberOfDaysForMonthNumber:11 yearNumber:nonLeapYear]).to.equal(daysInShortMonth);
    expect([sut numberOfDaysForMonthNumber:12 yearNumber:nonLeapYear]).to.equal(daysInLongMonth);

    expect([sut numberOfDaysForMonthNumber:2 yearNumber:leapYear]).to.equal(daysInLeapFebruary);
  });

  it(@"should return correct number of months for given year", ^{
    expect([sut numberOfMonthsInYearNumber:2015]).to.equal(12);
  });
});

SpecEnd
