//
//  BoSDateLimit.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 05/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSException.h>
#import <Foundation/NSCalendar.h>
#import "BoSDateLimit.h"
#import "BoSWeekdayDatePickerCalendar.h"

static const NSInteger BoSWeekdayDatePickerDefaultYearOffset = 1;

@implementation BoSDateLimit

+ (NSDate *)maximumDateFromDate:(NSDate *)date
{
  NSAssert(date, @"Date must NOT be null.");

  return [self dateFromDate:date withYearOffset:BoSWeekdayDatePickerDefaultYearOffset];
}

+ (NSDate *)minimumDateFromDate:(NSDate *)date
{
  NSAssert(date, @"Date must NOT be null.");

  return [self dateFromDate:date withYearOffset:-BoSWeekdayDatePickerDefaultYearOffset];
}

+ (NSDate *)dateFromDate:(NSDate *)date withYearOffset:(NSInteger)offset
{
  NSDateComponents *addComponents = [[NSDateComponents alloc] init];
  addComponents.year = offset;

  return [[BoSWeekdayDatePickerCalendar sharedInstance].calendar dateByAddingComponents:addComponents toDate:date options:0];
}

@end
