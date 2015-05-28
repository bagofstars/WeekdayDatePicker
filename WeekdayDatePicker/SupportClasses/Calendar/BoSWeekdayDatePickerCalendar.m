//
//  BoSWeekdayDatePickerCalendar.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 04/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/NSLocale.h>
#import "BoSWeekdayDatePickerCalendar.h"

@interface BoSWeekdayDatePickerCalendar ()

@property (nonatomic, strong, readwrite) NSCalendar *calendar;

@end


@implementation BoSWeekdayDatePickerCalendar

+ (instancetype)sharedInstance
{
  static dispatch_once_t onceToken;
  static BoSWeekdayDatePickerCalendar *singleton;
  dispatch_once(&onceToken, ^{
    singleton = [BoSWeekdayDatePickerCalendar new];
  });

  return singleton;
}

- (NSCalendar *)calendar
{
  if (_calendar) {
    return _calendar;
  }
  
  _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:self.calendarIdentifier];
  return _calendar;
}

- (NSString *)calendarIdentifier
{
#ifdef __IPHONE_8_0
  return NSCalendarIdentifierGregorian;
#else 
  return NSGregorianCalendar;
#endif
}

@end
