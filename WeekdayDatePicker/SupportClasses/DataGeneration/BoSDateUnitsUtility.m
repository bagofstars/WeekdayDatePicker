//
//  BoSDateUnitsUtility.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 02/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSValue.h>
#import <Foundation/NSCalendar.h>
#import <Foundation/NSException.h>
#import "BoSDateUnitsUtility.h"
#import "BoSWeekdayDatePickerCalendar.h"

@implementation BoSDateUnitsUtility

- (NSInteger)numberOfDaysForMonthNumber:(NSInteger)month yearNumber:(NSInteger)year
{
  NSAssert(month > 0 && month < 13, @"Month number out of range");

  NSDateComponents *dateComponents = [NSDateComponents new];
  dateComponents.month = month;
  dateComponents.year = year;

  NSCalendar *calendar = [BoSWeekdayDatePickerCalendar sharedInstance].calendar;
  NSDate *date = [calendar dateFromComponents:dateComponents];
  NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];

  return (NSInteger)range.length;
}

- (NSInteger)numberOfMonthsInYearNumber:(NSInteger)year
{
  NSDateComponents *dateComponents = [NSDateComponents new];
  dateComponents.year = year;

  NSCalendar *calendar = [BoSWeekdayDatePickerCalendar sharedInstance].calendar;
  NSDate *date = [calendar dateFromComponents:dateComponents];
  NSRange range = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:date];

  return (NSInteger)range.length;
}

@end
