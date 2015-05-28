//
//  NSDateComponents+BoSComponentValue.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 20/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSException.h>
#import "NSDateComponents+BoSComponentValue.h"

@implementation NSDateComponents (BoSComponentValue)

- (NSInteger)bos_valueForComponent:(NSCalendarUnit)unit
{
  switch(unit) {
    case NSCalendarUnitYear:
      return self.year;
    case NSCalendarUnitMonth:
      return self.month;
    case NSCalendarUnitDay:
      return self.day;
    default:
      NSAssert(NO, @"Unit not supported!");
  }

  return -1;
}

@end
