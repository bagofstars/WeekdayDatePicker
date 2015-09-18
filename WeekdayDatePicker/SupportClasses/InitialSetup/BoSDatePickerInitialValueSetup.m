//
//  BoSDatePickerInitialValueSetup.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 28/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSException.h>
#import <UIKit/UIPickerView.h>

#import "BoSDatePickerInitialValueSetup.h"
#import "BoSWeekdayDatePickerDelegateDataSource.h"
#import "BoSWeekdayDatePickerCalendar.h"
#import "BoSWeekdayDatePickerComponentsOrderManager.h"

FOUNDATION_EXTERN const NSInteger BoSWeekdaysComponentNumber;

@implementation BoSDatePickerInitialValueSetup

+ (void)setupRowsSelectionFromInitialDate:(NSDate *)initialDate forDatePicker:(UIPickerView *)pickerView withDataSource:(BoSWeekdayDatePickerDelegateDataSource *)dataSource
{
  NSParameterAssert(dataSource && pickerView);
  if (!initialDate) {
    return;
  }

  NSCalendarUnit initialDateUnits = NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
  NSDateComponents *currentDateComponents = [[BoSWeekdayDatePickerCalendar sharedInstance].calendar components:initialDateUnits fromDate:initialDate];

  NSInteger weekdayRow = [dataSource weekdayRowForDateComponentValue:currentDateComponents.weekday];
  NSInteger dayRow = [dataSource dayRowForDateComponentValue:currentDateComponents.day];
  NSInteger monthRow = [dataSource monthRowForDateComponentValue:currentDateComponents.month];
  NSInteger yearRow = [dataSource yearRowForDateComponentValue:currentDateComponents.year];

  BOOL initialDateOutOfRange = (dayRow == NSNotFound || monthRow == NSNotFound || yearRow == NSNotFound);
  if (initialDateOutOfRange) {
    return;
  }

  NSAssert(pickerView.dataSource, @"Requires data source to set the initial row!");

  [pickerView selectRow:weekdayRow inComponent:BoSWeekdaysComponentNumber animated:NO];
  [pickerView selectRow:dayRow inComponent:dataSource.componentsOrderManager.daysRowNumber animated:NO];
  [pickerView selectRow:monthRow inComponent:dataSource.componentsOrderManager.monthRowNumber animated:NO];
  [pickerView selectRow:yearRow inComponent:dataSource.componentsOrderManager.yearRowNumber animated:NO];
}

@end
