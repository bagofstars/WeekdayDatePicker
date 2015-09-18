//
//  BoSWeekdayDatePickerSelectedItems.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 12/09/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSException.h>
#import <Foundation/NSArray.h>
#import "BoSWeekdayDatePickerSelectedItems.h"

@implementation BoSWeekdayDatePickerSelectedItems

- (instancetype)initWithArrayOfRowValues:(NSArray *)selectedValues selectedDate:(NSDate *)selectedDate
                      indexOfSelectedRow:(NSInteger)indexOfSelectedRow indexOfSelectedComponent:(NSInteger)indexOfSelectedComponent
{
  NSParameterAssert(selectedValues.count > 0);
  NSParameterAssert(selectedDate);

  self = [super init];
  if (!self) {
    return nil;
  }

  _arrayOfRowValues = selectedValues;
  _selectedDate = selectedDate;
  _indexOfSelectedRow = indexOfSelectedRow;
  _indexOfSelectedComponent = indexOfSelectedComponent;

  return self;
}

@end
