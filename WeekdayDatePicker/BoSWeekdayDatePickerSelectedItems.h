//
//  BoSWeekdayDatePickerSelectedItems.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 11/09/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <objc/NSObject.h>

//Inventory class which stores items after user changed selected row in day, week or year component.

@class NSArray, NSDate;

@interface BoSWeekdayDatePickerSelectedItems : NSObject

//values of type NSString*
@property (nonatomic, copy, readonly) NSArray *arrayOfRowValues;
@property (nonatomic, strong, readonly) NSDate *selectedDate;

@property (nonatomic, assign, readonly) NSInteger indexOfSelectedRow;
@property (nonatomic, assign, readonly) NSInteger indexOfSelectedComponent;

- (instancetype)initWithArrayOfRowValues:(NSArray *)selectedValues selectedDate:(NSDate *)selectedDate
                      indexOfSelectedRow:(NSInteger)indexOfSelectedRow indexOfSelectedComponent:(NSInteger)indexOfSelectedComponent;
@end
