//
//  ViewController.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 30/01/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <UIKit/UIScreen.h>
#import "ViewController.h"
#import "BosWeekdayDatePickerView.h"
#import "BoSWeekdayDatePickerCalendar.h"
#import "NSDate+BoSConversion.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet BoSWeekdayDatePickerView *pickerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  NSDate *initialSelectionDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                                    fromDay:15 month:12 year:2015];
  
  NSDate *minDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                       fromDay:1 month:10 year:2015];
  
  NSDate *maxDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                       fromDay:31 month:12 year:2015];
  
  BoSWeekdayDatePickerView *sourceCodePickerView = [[BoSWeekdayDatePickerView alloc] initWithFrame:CGRectMake(0.0, 306.0f, CGRectGetWidth([UIScreen mainScreen].bounds), 216.0f)];
  [sourceCodePickerView setupMinDate:minDate maxDate:maxDate initialSelectionDate:initialSelectionDate];
  
  [self.view addSubview:sourceCodePickerView];
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
