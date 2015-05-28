//
//  NSDate+BoSConversion.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 01/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSException.h>
#import <Foundation/NSCalendar.h>
#import "NSDate+BoSConversion.h"

@implementation NSDate (BoSConversion)

+ (instancetype)bos_dateInCalendar:(NSCalendar *)calendar fromDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
{
  NSParameterAssert(calendar);
  NSParameterAssert(month > 0 && month < 13);
  NSParameterAssert(day > 0 && day < 32);
  NSParameterAssert(year >= 0);

  NSDateComponents *components = [NSDateComponents new];
  components.day = day;
  components.month = month;
  components.year = year;

  return [calendar dateFromComponents:components];
}

@end
