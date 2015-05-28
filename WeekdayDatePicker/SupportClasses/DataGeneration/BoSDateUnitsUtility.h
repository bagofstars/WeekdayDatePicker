//
//  BoSDateUnitsUtility.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 02/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <objc/NSObject.h>

@interface BoSDateUnitsUtility : NSObject

- (NSInteger)numberOfDaysForMonthNumber:(NSInteger)month yearNumber:(NSInteger)year;
- (NSInteger)numberOfMonthsInYearNumber:(NSInteger)year;

@end
