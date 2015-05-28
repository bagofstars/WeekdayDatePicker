//
//  NSDate+BoSSwap.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 18/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "NSDate+BoSSwap.h"

@implementation NSDate (BoSSwap)

+ (void)bos_swapIfNecessaryMinDate:(NSDate * __autoreleasing *)minDate withMaxDate:(NSDate * __autoreleasing *)maxDate
{
  NSDate *earlierDate = [*minDate earlierDate:*maxDate];
  if ([earlierDate isEqualToDate:*maxDate]) {
    (*maxDate) = (*minDate);
    (*minDate) = earlierDate;
  }
}

@end
