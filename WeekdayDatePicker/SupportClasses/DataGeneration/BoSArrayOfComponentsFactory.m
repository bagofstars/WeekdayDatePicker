//
//  BoSArrayOfComponentsFactory.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 18/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSException.h>
#import <Foundation/NSArray.h>
#import "BoSArrayOfComponentsFactory.h"
#import "NSDateComponents+BoSComponentValue.h"
#import "BoSDateUnitsUtility.h"

static const NSInteger BoSNumberOfFirstUnit = 1;

@interface BoSArrayOfComponentsFactory ()

@property (nonatomic, strong) BoSDateUnitsUtility *dateUnitsUtility;

@end


@implementation BoSArrayOfComponentsFactory

- (instancetype)init
{
  self = [super init];
  if (self) {
    _dateUnitsUtility = [BoSDateUnitsUtility new];
  }

  return self;
}

- (NSArray *)valuesOfUnit:(NSCalendarUnit)unit fromComponent:(NSDateComponents *)startComponent toComponent:(NSDateComponents *)endComponent
{
  NSAssert(startComponent && endComponent, @"Requires valid components");

  NSInteger startUnitValue = [startComponent bos_valueForComponent:unit];
  NSInteger endUnitValue = [endComponent bos_valueForComponent:unit];

  return [self arrayOfValuesFrom:startUnitValue to:endUnitValue];
}

- (NSArray *)valuesOfUnit:(NSCalendarUnit)unit fromComponent:(NSDateComponents *)startComponent
{
  NSAssert(unit == NSCalendarUnitDay || unit == NSCalendarUnitMonth, @"Only days or months are allowed!");

  NSInteger startUnitValue = [startComponent bos_valueForComponent:unit];
  NSAssert((unit == NSCalendarUnitDay && startUnitValue <= [self.dateUnitsUtility numberOfDaysForMonthNumber:startComponent.month yearNumber:startComponent.year]) ||
           (unit == NSCalendarUnitMonth && startUnitValue <= [self.dateUnitsUtility numberOfMonthsInYearNumber:startComponent.year]), @"Value of end component exceeds range.");
  
  NSInteger endUnitValue = -1;

  if (unit == NSCalendarUnitDay) {
    endUnitValue = [self.dateUnitsUtility numberOfDaysForMonthNumber:startComponent.month yearNumber:startComponent.year];
  }
  else if (unit == NSCalendarUnitMonth) {
    endUnitValue = [self.dateUnitsUtility numberOfMonthsInYearNumber:startComponent.year];
  }

  return [self arrayOfValuesFrom:startUnitValue to:endUnitValue];
}

- (NSArray *)valuesOfUnit:(NSCalendarUnit)unit toComponent:(NSDateComponents *)endComponent
{
  NSAssert(unit == NSCalendarUnitDay || unit == NSCalendarUnitMonth, @"Only days or months are allowed!");
  
  NSInteger endUnitValue = [endComponent bos_valueForComponent:unit];
  NSAssert((unit == NSCalendarUnitDay && endUnitValue <= [self.dateUnitsUtility numberOfDaysForMonthNumber:endComponent.month yearNumber:endComponent.year]) ||
           (unit == NSCalendarUnitMonth && endUnitValue <= [self.dateUnitsUtility numberOfMonthsInYearNumber:endComponent.year]), @"Value of end component exceeds range.");
  
  return [self arrayOfValuesFrom:BoSNumberOfFirstUnit to:endUnitValue];
}

- (NSArray *)arrayOfMonthsForYear:(NSInteger)year
{
  return [self arrayOfValuesFrom:BoSNumberOfFirstUnit to:[self.dateUnitsUtility numberOfMonthsInYearNumber:year]];
}

- (NSArray *)arrayOfDaysForDateComponent:(NSDateComponents *)component
{
  NSInteger monthNumber = component.month;
  NSAssert(monthNumber > 0 && monthNumber < 13, @"Month component value out of range!");

  NSInteger yearNumber = component.year;
  NSAssert(!(monthNumber == 2 && yearNumber == 0), @"Year component value required for February!");

  NSInteger endNumber = [self.dateUnitsUtility numberOfDaysForMonthNumber:monthNumber yearNumber:yearNumber];
  return [self arrayOfValuesFrom:BoSNumberOfFirstUnit to:endNumber];
}


#pragma mark - Private methods

- (NSArray *)arrayOfValuesFrom:(NSInteger)startNumber to:(NSInteger)endNumber
{
  NSAssert(startNumber <= endNumber, @"Requires end component to be later than start component");

  NSMutableArray *resultArray = [NSMutableArray array];

  for (NSInteger i = startNumber; i <= endNumber; i++) {
    [resultArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
  }

  return resultArray.copy;
}

@end
