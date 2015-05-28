//
// Created by Marcin Hawro on 30/01/2015.
// Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <UIKit/UIPickerView.h>

@class BoSWeekdayDatePickerView;

@protocol BoSWeekdayDatePickerLocaleChangeDelegate <NSObject>

- (void)didChangeDateFormatInDatePicker:(BoSWeekdayDatePickerView *)pickerView;
- (void)didReloadComponentsInDatePicker:(BoSWeekdayDatePickerView *)pickerView;

@end

@interface BoSWeekdayDatePickerView : UIPickerView

- (void)setupMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate initialSelectionDate:(NSDate *)initialSelectionDate;

@end