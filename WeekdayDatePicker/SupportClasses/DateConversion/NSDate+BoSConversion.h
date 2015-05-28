//
//  NSDate+BoSConversion.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 01/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSDate.h>

@interface NSDate (BoSConversion)

+ (instancetype)bos_dateInCalendar:(NSCalendar *)calendar fromDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;

@end
