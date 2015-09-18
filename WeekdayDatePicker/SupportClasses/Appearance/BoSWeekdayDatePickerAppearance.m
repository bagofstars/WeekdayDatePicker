//
//  BoSWeekdayDatePickerAppearance.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 01/03/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <UIKit/UILabel.h>
#import <UIKit/UIScreen.h>
#import <UIKit/NSAttributedString.h>

#import "BoSWeekdayDatePickerAppearance.h"
#import "BoSWeekdayDatePickerComponentsOrderManager.h"

FOUNDATION_EXTERN const NSInteger BoSWeekdaysComponentNumber;

static NSString * const BoSDefaultFontFamily = @"Helvetica-Light";
static const CGFloat BoSDefaultFontSize = 13.0f;
static const CGFloat BoSDefaultGreyColorValue = 0.13f;

static const CGFloat BoSDefaultPickerViewRowHeight = 24.0f;

static const CGFloat BoSWeekdayLeftIndentation = 30.0f;
static const CGFloat BoSDayLeftIndentation = 10.0f;
static const CGFloat BoSMonthLeftIndentation = 18.0f;
static const CGFloat BoSYearLeftIndentation = 15.0f;

static const NSInteger BoSPercentageOfWidthForWeekday = 40;
static const NSInteger BoSPercentageOfWidthForDay = 14;
static const NSInteger BoSPercentageOfWidthForMonth = 14;
static const NSInteger BoSPercentageOfWidthForYear = 24;


@interface BoSWeekdayDatePickerAppearance ()

@property (nonatomic, strong, readonly) BoSWeekdayDatePickerComponentsOrderManager *orderManager;

@property (nonatomic, assign) CGFloat weekdayViewWidth;
@property (nonatomic, assign) CGFloat dayViewWidth;
@property (nonatomic, assign) CGFloat monthViewWidth;
@property (nonatomic, assign) CGFloat yearViewWidth;

@end


@implementation BoSWeekdayDatePickerAppearance


#pragma mark - Public methods

- (instancetype)initWithComponentsOrderManager:(BoSWeekdayDatePickerComponentsOrderManager *)orderManager
{
  NSParameterAssert(orderManager);
  self = [super init];
  if (!self) {
    return nil;
  }

  _orderManager = orderManager;
  return self;
}

- (instancetype)init
{
  NSAssert(NO, @"Please use designated initializer");
  return self;
}

- (CGFloat)rowWidthForComponent:(NSInteger)component
{
  if (component == BoSWeekdaysComponentNumber) {
    return self.weekdayViewWidth;
  }

  if (component == self.orderManager.daysRowNumber) {
    return self.dayViewWidth;
  }

  if (component == self.orderManager.monthRowNumber) {
    return self.monthViewWidth;
  }

  if (component == self.orderManager.yearRowNumber) {
    return self.yearViewWidth;
  }

  NSAssert(NO, @"Unsupported component");
  return 0.0f;
}

- (UIView *)viewForComponent:(NSInteger)component
{
  CGFloat viewWidth = [self rowWidthForComponent:component];
  return [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewWidth, BoSDefaultPickerViewRowHeight)];
}

- (NSAttributedString *)decoratedStringFromString:(NSString *)rowString forComponent:(NSInteger)component
{
  if (!rowString.length) {
    return nil;
  }
  
  NSMutableDictionary *decorationStyle = [NSMutableDictionary dictionaryWithDictionary:@{
    NSFontAttributeName : [UIFont fontWithName:BoSDefaultFontFamily size:BoSDefaultFontSize],
    NSForegroundColorAttributeName : [UIColor colorWithRed:BoSDefaultGreyColorValue green:BoSDefaultGreyColorValue blue:BoSDefaultGreyColorValue alpha:1.0f]
  }];

  CGFloat leftIndentSize = [self leftIndentationForComponent:component];

  if (leftIndentSize > 0) {
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.firstLineHeadIndent = leftIndentSize;
    style.headIndent = leftIndentSize;

    decorationStyle[NSParagraphStyleAttributeName] = style;
  }

  return [[NSAttributedString alloc] initWithString:rowString attributes:decorationStyle];
}


#pragma mark - Private method

- (CGFloat)leftIndentationForComponent:(NSInteger)component
{
  if (component == BoSWeekdaysComponentNumber) {
    return BoSWeekdayLeftIndentation;
  }

  if (component == self.orderManager.daysRowNumber) {
    return BoSDayLeftIndentation;
  }

  if (component == self.orderManager.monthRowNumber) {
    return BoSMonthLeftIndentation;
  }

  if (component == self.orderManager.yearRowNumber) {
    return BoSYearLeftIndentation;
  }

  NSAssert(NO, @"Unsupported component");
  return 0.0f;
}


#pragma mark - Cached widths

- (CGFloat)weekdayViewWidth
{
  if (_weekdayViewWidth == 0.0f) {
    _weekdayViewWidth = roundf((float)CGRectGetWidth([UIScreen mainScreen].bounds) * BoSPercentageOfWidthForWeekday / 100.0f);
  }

  return _weekdayViewWidth;
}

- (CGFloat)dayViewWidth
{
  if (_dayViewWidth == 0.0f) {
    _dayViewWidth = roundf((float)CGRectGetWidth([UIScreen mainScreen].bounds) * BoSPercentageOfWidthForDay / 100.0f);
  }

  return _dayViewWidth;
}

- (CGFloat)monthViewWidth
{
  if (_monthViewWidth == 0.0f) {
    _monthViewWidth = roundf((float)CGRectGetWidth([UIScreen mainScreen].bounds) * BoSPercentageOfWidthForMonth / 100.0f);
  }

  return _monthViewWidth;
}

- (CGFloat)yearViewWidth
{
  if (_yearViewWidth == 0.0f) {
    _yearViewWidth = roundf((float)CGRectGetWidth([UIScreen mainScreen].bounds) * BoSPercentageOfWidthForYear / 100.0f);
  }

  return _yearViewWidth;
}

@end
