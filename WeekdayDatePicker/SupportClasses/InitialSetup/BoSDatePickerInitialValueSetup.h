//
//  BoSDatePickerInitialValueSetup.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 28/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//
/*
 Class implements method for setting up initial row values for WeekdayDatePicker.
 */
#import <objc/NSObject.h>

@class UIPickerView;
@class BoSWeekdayDatePickerDelegateDataSource;

@interface BoSDatePickerInitialValueSetup : NSObject

+ (void)setupRowsSelectionFromInitialDate:(NSDate *)initialDate forDatePicker:(UIPickerView *)pickerView withDataSource:(BoSWeekdayDatePickerDelegateDataSource *)dataSource;

@end
