//
//  BoSWeekdayDatePickerDelegateDataSource.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 30/01/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <UIKit/UIPickerView.h>

@class BoSWeekdayDatePickerComponentsOrderManager;

@interface BoSWeekdayDatePickerDelegateDataSource : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong, readonly) BoSWeekdayDatePickerComponentsOrderManager *componentsOrderManager;

- (instancetype)initWithMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate;

- (NSInteger)weekdayRowForDateComponentValue:(NSInteger)value;
- (NSInteger)dayRowForDateComponentValue:(NSInteger)value;
- (NSInteger)monthRowForDateComponentValue:(NSInteger)value;
- (NSInteger)yearRowForDateComponentValue:(NSInteger)value;

@end
