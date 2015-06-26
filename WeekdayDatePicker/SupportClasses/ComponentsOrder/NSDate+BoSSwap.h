//
//  NSDate+BoSSwap.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 18/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//
#import <Foundation/NSDate.h>

/**
 *  Class implements method which ensures min date is earlier than max date.
 */
@interface NSDate (BoSSwap)

+ (void)bos_swapIfNecessaryMinDate:(NSDate * __autoreleasing *)minDate withMaxDate:(NSDate * __autoreleasing *)maxDate;

@end
