//
//  BoSWeekdayDatePickerComponentsOrderManager.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 05/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSException.h>
#import <Foundation/NSArray.h>
#import "BoSWeekdayDatePickerComponentsOrderManager.h"
#import "BoSDeviceLocaleHandler.h"

static const NSInteger BoSRowNumberUnknown = -1;

NSString * const BoSFormatCharacterForDays = @"d";
NSString * const BoSFormatCharacterForMonths = @"M";
NSString * const BoSFormatCharacterForYears = @"y";

const NSInteger BoSWeekdaysComponentNumber = 0;

@interface BoSWeekdayDatePickerComponentsOrderManager ()

@property (nonatomic, copy, readwrite) NSDictionary *selectedRows;

@property (nonatomic, strong) NSNumber *previousComponentNumberForDays;
@property (nonatomic, strong) NSNumber *previousComponentNumberForMonths;
@property (nonatomic, strong) NSNumber *previousComponentNumberForYears;

@property (nonatomic, assign, readwrite) NSInteger daysRowNumber;
@property (nonatomic, assign, readwrite) NSInteger monthRowNumber;
@property (nonatomic, assign, readwrite) NSInteger yearRowNumber;

@end


@implementation BoSWeekdayDatePickerComponentsOrderManager

- (void)reloadRowsWithDateFormatTemplate:(NSString *)dateFormatTemplate
{
  NSParameterAssert(dateFormatTemplate.length);

  NSUInteger dayComponentLocation = [dateFormatTemplate rangeOfString:BoSFormatCharacterForDays].location;
  NSAssert(dayComponentLocation != NSNotFound, @"Must contain day component");

  NSUInteger monthComponentLocation = [dateFormatTemplate rangeOfString:BoSFormatCharacterForMonths].location;
  NSAssert(monthComponentLocation != NSNotFound, @"Must contain month component");

  NSUInteger yearComponentLocation = [dateFormatTemplate rangeOfString:BoSFormatCharacterForYears].location;
  NSAssert(yearComponentLocation != NSNotFound, @"Must contain year component");

  self.daysRowNumber = self.monthRowNumber = self.yearRowNumber = BoSRowNumberUnknown;

  [self assignFirstRowNumberWithDayComponentLocation:dayComponentLocation
                              monthComponentLocation:monthComponentLocation
                               yearComponentLocation:yearComponentLocation];

  [self assignThirdRowNumberWithDayComponentLocation:dayComponentLocation
                              monthComponentLocation:monthComponentLocation
                               yearComponentLocation:yearComponentLocation];

  [self assignSecondRowNumber];
}

- (void)assignFirstRowNumberWithDayComponentLocation:(NSUInteger)dayLocation
                              monthComponentLocation:(NSUInteger)monthLocation
                               yearComponentLocation:(NSUInteger)yearLocation
{
  NSUInteger firstLocation = MIN(MIN(dayLocation, monthLocation), yearLocation);
  [self assignRowNumber:1 correspondingToLocation:firstLocation withDayLocation:dayLocation monthLocation:monthLocation yearLocation:yearLocation];
}

- (void)assignThirdRowNumberWithDayComponentLocation:(NSUInteger)dayLocation
                              monthComponentLocation:(NSUInteger)monthLocation
                               yearComponentLocation:(NSUInteger)yearLocation
{
  NSUInteger lastComponent = MAX(MAX(dayLocation, monthLocation), yearLocation);
  [self assignRowNumber:3 correspondingToLocation:lastComponent withDayLocation:dayLocation monthLocation:monthLocation yearLocation:yearLocation];
}

- (void)assignRowNumber:(NSInteger)rowNumber
correspondingToLocation:(NSUInteger)correspondingLocation
        withDayLocation:(NSUInteger)dayLocation
          monthLocation:(NSUInteger)monthLocation
           yearLocation:(NSUInteger)yearLocation
{
  if (dayLocation == correspondingLocation) {
    self.daysRowNumber = rowNumber;
  }
  else if (monthLocation == correspondingLocation) {
    self.monthRowNumber = rowNumber;
  }
  else if (yearLocation == correspondingLocation) {
    self.yearRowNumber = rowNumber;
  }
}

- (void)assignSecondRowNumber
{
  if (self.daysRowNumber == BoSRowNumberUnknown) {
    self.daysRowNumber = 2;
  }
  else if (self.monthRowNumber == BoSRowNumberUnknown) {
    self.monthRowNumber = 2;
  }
  else if (self.yearRowNumber == BoSRowNumberUnknown) {
    self.yearRowNumber = 2;
  }
}

#pragma mark - BoSWeekdayDatePickerLocaleChangeDelegate

- (void)didChangeDateFormatInDatePicker:(BoSWeekdayDatePickerView *)pickerView
{
  [self saveSelectedRowsInDatePicker:pickerView];

  BoSDeviceLocaleHandler *localeHandler = [BoSDeviceLocaleHandler new];
  [self reloadRowsWithDateFormatTemplate:localeHandler.currentDateFormatTemplate];
}

- (void)didReloadComponentsInDatePicker:(BoSWeekdayDatePickerView *)pickerView
{
  [self restorePreviousRowSelectionInPickerView:pickerView];
}


#pragma mark - Helpers

- (void)saveSelectedRowsInDatePicker:(BoSWeekdayDatePickerView *)pickerView
{
  if (self.daysRowNumber == 0 || self.monthRowNumber == 0 || self.yearRowNumber == 0) {
    return;
  }

  self.previousComponentNumberForDays = @(self.daysRowNumber);
  self.previousComponentNumberForMonths = @(self.monthRowNumber);
  self.previousComponentNumberForYears = @(self.yearRowNumber);

  self.selectedRows = @{
    self.previousComponentNumberForDays : @([pickerView selectedRowInComponent:self.daysRowNumber]),
    self.previousComponentNumberForMonths : @([pickerView selectedRowInComponent:self.monthRowNumber]),
    self.previousComponentNumberForYears : @([pickerView selectedRowInComponent:self.yearRowNumber])
  };
}

- (void)restorePreviousRowSelectionInPickerView:(BoSWeekdayDatePickerView *)pickerView
{
  NSInteger previouslySelectedRowForDays = [self.selectedRows[self.previousComponentNumberForDays] integerValue];
  [pickerView selectRow:previouslySelectedRowForDays inComponent:self.daysRowNumber animated:NO];

  NSInteger previouslySelectedRowForMonths = [self.selectedRows[self.previousComponentNumberForMonths] integerValue];
  [pickerView selectRow:previouslySelectedRowForMonths inComponent:self.monthRowNumber animated:NO];

  NSInteger previouslySelectedRowForYears = [self.selectedRows[self.previousComponentNumberForYears] integerValue];
  [pickerView selectRow:previouslySelectedRowForYears inComponent:self.yearRowNumber animated:NO];

  self.selectedRows = nil;
  self.previousComponentNumberForDays = self.previousComponentNumberForMonths = self.previousComponentNumberForDays = nil;
}

@end
