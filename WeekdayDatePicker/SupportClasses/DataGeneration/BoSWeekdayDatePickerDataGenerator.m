//
//  BoSWeekdayDatePickerDataGenerator.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 28/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSCalendar.h>
#import <Foundation/NSException.h>

#import "BoSWeekdayDatePickerDataGenerator.h"
#import "BoSArrayOfComponentsFactory.h"
#import "NSDate+BoSSwap.h"

@interface BoSWeekdayDatePickerDataGenerator ()

@property (nonatomic, strong, readonly) NSCalendar *gregorianCalendar;

@property (nonatomic, strong) NSDateComponents *minDateComponents;
@property (nonatomic, strong) NSDateComponents *maxDateComponents;

@property (nonatomic, strong, readonly) BoSArrayOfComponentsFactory *componentsFactory;

@end


@implementation BoSWeekdayDatePickerDataGenerator

- (instancetype)initWithCalendar:(NSCalendar *)calendar minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate
{
  NSParameterAssert(calendar && minDate && maxDate);
  NSParameterAssert(![minDate isEqualToDate:maxDate]);

  self = [super init];
  if (!self) {
    return nil;
  }

  _gregorianCalendar = calendar;
  _componentsFactory = [BoSArrayOfComponentsFactory new];

  [NSDate bos_swapIfNecessaryMinDate:&minDate withMaxDate:&maxDate];
  [self setupLimitComponentsWithMinDate:minDate maxDate:maxDate];

  return self;
}

- (instancetype)init
{
  NSAssert(NO, @"Please use designated initializer!");
  return nil;
}

- (NSArray *)yearsArray
{
  NSAssert(self.minDateComponents && self.maxDateComponents, @"Limit components required!");
  return [self.componentsFactory valuesOfUnit:NSCalendarUnitYear fromComponent:self.minDateComponents toComponent:self.maxDateComponents];
}

- (NSArray *)monthsArrayForDate:(NSDate *)date
{
  NSParameterAssert(date);
  NSDateComponents *currentDateComponents = [self.gregorianCalendar components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];

  return [self monthsArrayForYear:currentDateComponents.year];
}

- (NSArray *)monthsArrayForYear:(NSInteger)year
{
  NSAssert(self.minDateComponents, @"Min limit components required!");
  if (year == self.minDateComponents.year) {
    return [self.componentsFactory valuesOfUnit:NSCalendarUnitMonth fromComponent:self.minDateComponents];
  }

  NSAssert(self.maxDateComponents, @"Max limit components required!");
  if (year == self.maxDateComponents.year) {
    return [self.componentsFactory valuesOfUnit:NSCalendarUnitMonth toComponent:self.maxDateComponents];
  }

  return [self.componentsFactory arrayOfMonthsForYear:year];
}

- (NSArray *)daysArrayForDate:(NSDate *)date
{
  NSParameterAssert(date);
  NSCalendarUnit units = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
  NSDateComponents *currentDateComponents = [self.gregorianCalendar components:units fromDate:date];

  return [self daysArrayForComponents:currentDateComponents];
}

- (NSArray *)daysArrayForComponents:(NSDateComponents *)components
{
  NSInteger inputYear = components.year;
  NSInteger inputMonth = components.month;

  NSAssert(self.minDateComponents, @"Min limit components required!");
  if (inputYear == self.minDateComponents.year && inputMonth == self.minDateComponents.month) {
    return [self.componentsFactory valuesOfUnit:NSCalendarUnitDay fromComponent:self.minDateComponents];
  }

  NSAssert(self.maxDateComponents, @"Max limit components required!");
  if (inputYear == self.maxDateComponents.year && inputMonth == self.maxDateComponents.month) {
    return [self.componentsFactory valuesOfUnit:NSCalendarUnitDay toComponent:self.maxDateComponents];
  }

  return [self.componentsFactory arrayOfDaysForDateComponent:components];
}


#pragma mark - Private

- (void)setupLimitComponentsWithMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate
{
  NSParameterAssert(minDate && maxDate);

  NSCalendarUnit units = NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;

  self.minDateComponents = [self.gregorianCalendar components:units fromDate:minDate];
  self.maxDateComponents = [self.gregorianCalendar components:units fromDate:maxDate];
}

@end
