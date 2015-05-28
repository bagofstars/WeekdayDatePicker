//
//  BoSWeekdayDatePickerDataGenerator.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 28/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <objc/NSObject.h>

/**
 All arrays contain NSString objects.
 */
@interface BoSWeekdayDatePickerDataGenerator : NSObject

- (instancetype)initWithCalendar:(NSCalendar *)calendar minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate;

//Years array
- (NSArray *)yearsArray;

//Months array
- (NSArray *)monthsArrayForYear:(NSInteger)year;
- (NSArray *)monthsArrayForDate:(NSDate *)date;

//Days array
- (NSArray *)daysArrayForComponents:(NSDateComponents *)components;
- (NSArray *)daysArrayForDate:(NSDate *)date;

@end
