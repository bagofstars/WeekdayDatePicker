//
//  BoSArrayOfComponentsFactory.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 18/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSCalendar.h>

/*
 Class implements methods for generating arrays of NSStrings which represent values of calendar units between two date components.
 
 For example: two date components with years 2014 and 2017 produce [2014, 2015, 2016, 2017] array.
 */

@interface BoSArrayOfComponentsFactory : NSObject

- (NSArray *)valuesOfUnit:(NSCalendarUnit)unit fromComponent:(NSDateComponents *)startComponent toComponent:(NSDateComponents *)endComponent;

/*
 For days it's from x to end of month. For months it's x to 12 (December).
 */
- (NSArray *)valuesOfUnit:(NSCalendarUnit)unit fromComponent:(NSDateComponents *)startComponent;

/*
 For days and months it's 1 to x.
 */
- (NSArray *)valuesOfUnit:(NSCalendarUnit)unit toComponent:(NSDateComponents *)endComponent;

/*
 Full month array from 1 to 12.
 */
- (NSArray *)arrayOfMonthsForYear:(NSInteger)year;

/*
 Full day array from 1 to 28, 29, 30 or 31 depending on month and year.
 */
- (NSArray *)arrayOfDaysForDateComponent:(NSDateComponents *)component;

@end
