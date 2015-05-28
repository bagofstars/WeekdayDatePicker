//
//  BoSDateLimit.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 05/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <objc/NSObject.h>

@class NSDate;

@interface BoSDateLimit : NSObject

+ (NSDate *)maximumDateFromDate:(NSDate *)date;
+ (NSDate *)minimumDateFromDate:(NSDate *)date;

@end
