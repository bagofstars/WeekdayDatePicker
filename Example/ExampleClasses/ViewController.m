//
//  ViewController.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 30/01/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <UIKit/UIScreen.h>
#import <UIKit/UILabel.h>
#import "ViewController.h"
#import "BosWeekdayDatePickerView.h"
#import "BoSWeekdayDatePickerCalendar.h"
#import "NSDate+BoSConversion.h"
#import "BoSWeekdayDatePickerSelectedItems.h"

static NSString *const BoSWeekdayDatePickerExampleDateFormatString = @"EEEE dd MMMM yyyy";

@interface ViewController ()

@property (nonatomic, weak) IBOutlet BoSWeekdayDatePickerView *pickerView;
@property (nonatomic, weak) IBOutlet UILabel *selectedDateLabel;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end


@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setupDateFormatter];
  [self displayInitialDateOnTheLabel];

  [self setupWeekdayDatePicker];
}

- (void)setupDateFormatter
{
  self.dateFormatter = [NSDateFormatter new];
  self.dateFormatter.dateFormat = BoSWeekdayDatePickerExampleDateFormatString;
}

- (void)displayInitialDateOnTheLabel
{
  NSAssert(self.dateFormatter, @"Label requires initialized date formatter.");
  self.selectedDateLabel.text = [self.dateFormatter stringFromDate:self.exampleInitialDate];
}

- (void)setupWeekdayDatePicker
{
  BoSWeekdayDatePickerView *sourceCodePickerView = [[BoSWeekdayDatePickerView alloc] initWithFrame:self.datePickerFrame];

  [sourceCodePickerView setupMinDate:self.exampleMinDate maxDate:self.exampleMaxDate initialSelectionDate:self.exampleInitialDate];
  [self setupRowSelectionCallbackForDatePicker:sourceCodePickerView];

  [self.view addSubview:sourceCodePickerView];
}

- (void)setupRowSelectionCallbackForDatePicker:(BoSWeekdayDatePickerView *)weekdayDatePicker
{
  NSParameterAssert(weekdayDatePicker);

  __weak typeof(self) weakSelf = self;
  weekdayDatePicker.didSelectRowCallback = ^(BoSWeekdayDatePickerSelectedItems *selectedItems) {
    weakSelf.selectedDateLabel.text = [weakSelf.dateFormatter stringFromDate:selectedItems.selectedDate];
  };
}

- (NSDate *)exampleInitialDate
{
  return [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                            fromDay:15 month:12 year:2015];
}

- (NSDate *)exampleMinDate
{
  return [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                            fromDay:1 month:1 year:2005];
}

- (NSDate *)exampleMaxDate
{
  return [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                            fromDay:31 month:12 year:2016];
}

- (CGRect)datePickerFrame
{
  return CGRectMake(0.0, 336.0f, CGRectGetWidth([UIScreen mainScreen].bounds), 216.0f);
}


- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  NSDate *initialSelectionDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                            fromDay:9 month:1 year:2020];
  NSDate *minDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                               fromDay:1 month:1 year:1984];
  NSDate *maxDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                               fromDay:31 month:12 year:2059];

  [self.pickerView setupMinDate:minDate maxDate:maxDate initialSelectionDate:initialSelectionDate];
}


@end
