//
// Created by Marcin Hawro on 30/01/2015.
// Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "BoSWeekdayDatePickerView.h"
#import "UIView+BoSNibLoading.h"
#import "BoSWeekdayDatePickerDelegateDataSource.h"
#import "BoSWeekdayDatePickerComponentsOrderManager.h"
#import "NSDate+BoSSwap.h"
#import "BoSDatePickerInitialValueSetup.h"

@interface BoSWeekdayDatePickerView ()

@property (nonatomic, strong) BoSWeekdayDatePickerDelegateDataSource *pickerDelegateDataSource;
@property (nonatomic, weak) id<BoSWeekdayDatePickerLocaleChangeDelegate> localeChangeDelegate;

@end


@implementation BoSWeekdayDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (!self) {
    return nil;
  }

  [self registerLocaleChangeNotification];
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (!self) {
    return nil;
  }

  [self registerLocaleChangeNotification];
  return self;
}

- (instancetype)initWithNibNamed:(NSString *)nibFile
{
  self = [super initWithNibNamed:nibFile];
  if (!self) {
    return nil;
  }

  [self registerLocaleChangeNotification];
  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:NSCurrentLocaleDidChangeNotification object:nil];
  self.delegate = nil;
  self.dataSource = nil;
}

- (void)setupMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate initialSelectionDate:(NSDate *)initialSelectionDate
{
  NSParameterAssert(minDate && maxDate);

  [NSDate bos_swapIfNecessaryMinDate:&minDate withMaxDate:&maxDate];
  self.pickerDelegateDataSource = [[BoSWeekdayDatePickerDelegateDataSource alloc] initWithMinDate:minDate maxDate:maxDate initialDate:initialSelectionDate];
  [self connectDelegates];

  [BoSDatePickerInitialValueSetup setupRowsSelectionFromInitialDate:initialSelectionDate forDatePicker:self withDataSource:self.pickerDelegateDataSource];
}


#pragma mark - Private methods

- (void)connectDelegates
{
  NSAssert(self.pickerDelegateDataSource, @"Delegate-data source object hasn't been created");
  NSAssert(self.pickerDelegateDataSource.componentsOrderManager, @"Delegate for updating locale hasn't been created");

  self.delegate = self.pickerDelegateDataSource;
  self.dataSource = self.pickerDelegateDataSource;
  self.localeChangeDelegate = self.pickerDelegateDataSource.componentsOrderManager;
}

- (void)registerLocaleChangeNotification
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange:) name:NSCurrentLocaleDidChangeNotification object:nil];
}

- (void)localeDidChange:(NSNotification *)notification
{
  if ([self.localeChangeDelegate respondsToSelector:@selector(didChangeDateFormatInDatePicker:)]) {
    [self.localeChangeDelegate performSelector:@selector(didChangeDateFormatInDatePicker:) withObject:self];
  }

  [self reloadAllComponents];

  if ([self.localeChangeDelegate respondsToSelector:@selector(didReloadComponentsInDatePicker:)]) {
    [self.localeChangeDelegate performSelector:@selector(didReloadComponentsInDatePicker:) withObject:self];
  }
}

@end