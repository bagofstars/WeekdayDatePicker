//
//  BoSWeekdayDatePickerDelegateDataSource.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 30/01/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <UIKit/UILabel.h>
#import "BoSWeekdayDatePickerDelegateDataSource.h"
#import "BoSWeekdayDatePickerDataGenerator.h"
#import "BoSWeekdayDatePickerAppearance.h"
#import "BoSWeekdayDatePickerCalendar.h"
#import "BoSWeekdayDatePickerComponentsOrderManager.h"
#import "NSDate+BoSConversion.h"
#import "BoSDateUnitsUtility.h"
#import "BoSDeviceLocaleHandler.h"
#import "BoSWeekdayDatePickerSelectedItems.h"

FOUNDATION_EXTERN const NSInteger BoSWeekdaysComponentNumber;


@interface BoSWeekdayDatePickerDelegateDataSource ()

//Array of NSString pointers.
@property (nonatomic, copy) NSArray *weekDayNamesArray;
@property (nonatomic, copy) NSArray *daysDataArray;
@property (nonatomic, copy) NSArray *monthsDataArray;
@property (nonatomic, copy) NSArray *yearsDataArray;

@property (nonatomic, strong, readonly) BoSWeekdayDatePickerDataGenerator *dataGenerator;
@property (nonatomic, strong) BoSWeekdayDatePickerAppearance *appearance;

@property (nonatomic, strong) BoSDateUnitsUtility *dateUnitsUtility;

@end


@implementation BoSWeekdayDatePickerDelegateDataSource

#pragma mark - Public methods

- (instancetype)init
{
  NSAssert(NO, @"Please use designated initializer.");
  return nil;
}

- (instancetype)initWithMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate initialDate:(NSDate *)initialDate
{
  NSParameterAssert(minDate && maxDate && initialDate);
  self = [super init];
  if (!self) {
    return nil;
  }

  BoSDeviceLocaleHandler *localeHandler = [BoSDeviceLocaleHandler new];

  _componentsOrderManager = [BoSWeekdayDatePickerComponentsOrderManager new];
  [_componentsOrderManager reloadRowsWithDateFormatTemplate:localeHandler.currentDateFormatTemplate];

  _dataGenerator = [[BoSWeekdayDatePickerDataGenerator alloc] initWithCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                                                       minDate:minDate
                                                                       maxDate:maxDate];
  _appearance = [[BoSWeekdayDatePickerAppearance alloc] initWithComponentsOrderManager:_componentsOrderManager];
  [self setupDataArraysWithCurrentlySelectedDate:initialDate];

  return self;
}

- (NSInteger)weekdayRowForDateComponentValue:(NSInteger)value
{
  return [self rowForDateComponentValue:value pickerComponent:BoSWeekdaysComponentNumber];
}

- (NSInteger)dayRowForDateComponentValue:(NSInteger)value
{
  return [self rowForDateComponentValue:value pickerComponent:self.componentsOrderManager.daysRowNumber];
}

- (NSInteger)monthRowForDateComponentValue:(NSInteger)value
{
  return [self rowForDateComponentValue:value pickerComponent:self.componentsOrderManager.monthRowNumber];
}

- (NSInteger)yearRowForDateComponentValue:(NSInteger)value
{
  return [self rowForDateComponentValue:value pickerComponent:self.componentsOrderManager.yearRowNumber];
}


#pragma mark - Data setup

- (void)setupDataArraysWithCurrentlySelectedDate:(NSDate *)selectedDate
{
  NSParameterAssert(selectedDate);

  self.weekDayNamesArray = @[
    NSLocalizedString(@"Sunday", nil),
    NSLocalizedString(@"Monday", nil),
    NSLocalizedString(@"Tuesday", nil),
    NSLocalizedString(@"Wednesday", nil),
    NSLocalizedString(@"Thursday", nil),
    NSLocalizedString(@"Friday", nil),
    NSLocalizedString(@"Saturday", nil)
  ];

  self.yearsDataArray = [self.dataGenerator yearsArray];

  self.monthsDataArray = [self.dataGenerator monthsArrayForDate:selectedDate];
  self.daysDataArray = [self.dataGenerator daysArrayForDate:selectedDate];
}

- (NSInteger)rowForDateComponentValue:(NSInteger)value pickerComponent:(NSInteger)pickerComponent
{
  if (pickerComponent == BoSWeekdaysComponentNumber) {
    return (value - 1);
  }

  NSArray *componentDataArray = [self dataArrayForComponent:pickerComponent];
  NSAssert(componentDataArray, @"Unsupported component");

  return (NSInteger)[componentDataArray indexOfObject:[NSString stringWithFormat:@"%li", (long)value]];
}


#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
  if (!view) {
    view = [self.appearance viewForComponent:component];
  }

  if ([view isKindOfClass:[UILabel class]]) {
    NSString *rowTitle = [self pickerView:pickerView titleForRow:row forComponent:component];
    NSAttributedString *styledTitle = [self.appearance decoratedStringFromString:rowTitle forComponent:component];

    [(UILabel *)view setAttributedText:styledTitle];
  }

  return view;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
  return [self.appearance rowWidthForComponent:component];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  if (component == self.componentsOrderManager.yearRowNumber) {
//The order of invoked methods is important here! Month needs to be adjusted first, because days array depends on selected month.
    [self adjustNumberOfMonthsInPickerView:pickerView];
    [self adjustNumberOfDaysInPickerView:pickerView];
    [self adjustWeekdaySelectionInPickerView:pickerView];

    [self invokeDidSelectCallbackIfNeededWithPickerView:pickerView row:row component:component];
    return;
  }

  if (component == self.componentsOrderManager.monthRowNumber) {
    [self adjustNumberOfDaysInPickerView:pickerView];
  }

  [self adjustWeekdaySelectionInPickerView:pickerView];

  [self invokeDidSelectCallbackIfNeededWithPickerView:pickerView row:row component:component];
}

- (void)invokeDidSelectCallbackIfNeededWithPickerView:(UIPickerView *)pickerView row:(NSInteger)row component:(NSInteger)component
{
  if (component == BoSWeekdaysComponentNumber) {
    return;
  }

  BOOL pickerViewHasCallback = [pickerView isKindOfClass:[BoSWeekdayDatePickerView class]] &&
    ((BoSWeekdayDatePickerView *)pickerView).didSelectRowCallback;
  if (!pickerViewHasCallback) {
    return;
  }

  BoSWeekdayDatePickerSelectedItems *selectedItems = [[BoSWeekdayDatePickerSelectedItems alloc]
    initWithArrayOfRowValues:[self arrayOfValuesSelectedInPickerView:pickerView]
                selectedDate:[self selectedDateInPickerView:pickerView]
          indexOfSelectedRow:row
    indexOfSelectedComponent:component];

  ((BoSWeekdayDatePickerView *)pickerView).didSelectRowCallback(selectedItems);
}

- (NSArray *)arrayOfValuesSelectedInPickerView:(UIPickerView *)pickerView
{
  return @[
    [self selectedObjectInPickerView:pickerView inComponent:0],
    [self selectedObjectInPickerView:pickerView inComponent:1],
    [self selectedObjectInPickerView:pickerView inComponent:2],
    [self selectedObjectInPickerView:pickerView inComponent:3]
  ];
}


#pragma mark - After scroll adjusting

- (void)adjustWeekdaySelectionInPickerView:(UIPickerView *)pickerView
{
  NSDate *selectedDate = [self selectedDateInPickerView:pickerView];

  NSInteger newWeekdayValue = [[BoSWeekdayDatePickerCalendar sharedInstance].calendar components:NSCalendarUnitWeekday fromDate:selectedDate].weekday;
  NSInteger weekdayRow = [self rowForDateComponentValue:newWeekdayValue pickerComponent:BoSWeekdaysComponentNumber];

  NSAssert(weekdayRow >= 0 && weekdayRow < (NSInteger)self.weekDayNamesArray.count , @"Weekday row is out of range!");

  [pickerView selectRow:weekdayRow inComponent:BoSWeekdaysComponentNumber animated:YES];
}

- (void)adjustNumberOfDaysInPickerView:(UIPickerView *)pickerView
{
  NSDate *selectedDate = [self selectedDateInPickerView:pickerView];
  NSArray *regeneratedArray = [self.dataGenerator daysArrayForDate:selectedDate];
  if ([regeneratedArray isEqual:self.daysDataArray]) {
    return;
  }

//Order is important here - this value must be saved before new array is applied and component is reloaded.
  NSString *previouslySelectedDay = [self selectedObjectInPickerView:pickerView inComponent:self.componentsOrderManager.daysRowNumber];

  self.daysDataArray = regeneratedArray;
  [pickerView reloadComponent:self.componentsOrderManager.daysRowNumber];

  [self pointRow:self.componentsOrderManager.daysRowNumber ofPickerView:pickerView intoPreviouslySelectedValue:previouslySelectedDay withNewArray:regeneratedArray];
}

- (void)adjustNumberOfMonthsInPickerView:(UIPickerView *)pickerView
{
  NSDate *selectedDate = [self selectedDateInPickerView:pickerView];
  NSArray *regeneratedArray = [self.dataGenerator monthsArrayForDate:selectedDate];
  if ([regeneratedArray isEqual:self.monthsDataArray]) {
    return;
  }

  NSString *previouslySelectedMonth = [self selectedObjectInPickerView:pickerView inComponent:self.componentsOrderManager.monthRowNumber];

  self.monthsDataArray = regeneratedArray;
  [pickerView reloadComponent:self.componentsOrderManager.monthRowNumber];

  [self pointRow:self.componentsOrderManager.monthRowNumber ofPickerView:pickerView intoPreviouslySelectedValue:previouslySelectedMonth withNewArray:regeneratedArray];
}

- (void)pointRow:(NSInteger)row ofPickerView:(UIPickerView *)pickerView intoPreviouslySelectedValue:(NSString *)previouslySelectedValue withNewArray:(NSArray *)regeneratedArray
{
  if ([regeneratedArray containsObject:previouslySelectedValue]) {
    NSInteger newCorrespondingRow = [self rowForDateComponentValue:[previouslySelectedValue integerValue] pickerComponent:row];
    [pickerView selectRow:newCorrespondingRow inComponent:row animated:NO];
    return;
  }

  if ([previouslySelectedValue integerValue] < [regeneratedArray.firstObject integerValue]) {
    [pickerView selectRow:0 inComponent:row animated:NO];
    return;
  }

  [pickerView selectRow:((NSInteger)regeneratedArray.count - 1) inComponent:row animated:NO];
}

- (NSString *)selectedObjectInPickerView:(UIPickerView *)pickerView inComponent:(NSInteger)component
{
  NSInteger indexOfSelectedRow = [pickerView selectedRowInComponent:component];
  NSArray *componentDataArray = [self dataArrayForComponent:component];
  NSAssert(indexOfSelectedRow >= 0 && indexOfSelectedRow < (NSInteger)componentDataArray.count, @"Index out of range.");

  return componentDataArray[(NSUInteger)indexOfSelectedRow];
}

- (NSDate *)selectedDateInPickerView:(UIPickerView *)pickerView
{
  NSInteger selectedDayNumber = [[self selectedObjectInPickerView:pickerView inComponent:self.componentsOrderManager.daysRowNumber] integerValue];
  NSInteger selectedMonthNumber = [[self selectedObjectInPickerView:pickerView inComponent:self.componentsOrderManager.monthRowNumber] integerValue];
  NSInteger selectedYearNumber = [[self selectedObjectInPickerView:pickerView inComponent:self.componentsOrderManager.yearRowNumber] integerValue];

  NSInteger maxDayNumber = [self.dateUnitsUtility numberOfDaysForMonthNumber:selectedMonthNumber yearNumber:selectedYearNumber];

  if (selectedDayNumber > maxDayNumber) {
    selectedDayNumber = maxDayNumber;
  }

  return [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar fromDay:selectedDayNumber month:selectedMonthNumber year:selectedYearNumber];
}


#pragma mark - UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  return [self dataArrayForComponent:component][(NSUInteger)row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  return (NSInteger)[self dataArrayForComponent:component].count;
}

- (NSArray *)dataArrayForComponent:(NSInteger)pickerComponent
{
  if (pickerComponent == BoSWeekdaysComponentNumber) {
    return self.weekDayNamesArray;
  }

  if (pickerComponent == self.componentsOrderManager.daysRowNumber) {
    return self.daysDataArray;
  }

  if (pickerComponent == self.componentsOrderManager.monthRowNumber) {
    return self.monthsDataArray;
  }

  if (pickerComponent == self.componentsOrderManager.yearRowNumber) {
    return self.yearsDataArray;
  }

  NSAssert(NO, @"Unsupported component");
  return nil;
}


#pragma mark - Lazy initializer

- (BoSDateUnitsUtility *)dateUnitsUtility
{
  return _dateUnitsUtility ?: (_dateUnitsUtility = [BoSDateUnitsUtility new]);
}

@end
