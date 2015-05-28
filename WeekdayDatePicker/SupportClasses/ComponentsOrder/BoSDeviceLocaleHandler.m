//
//  BoSDeviceLocaleHandler.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 05/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSString.h>
#import <Foundation/NSLocale.h>
#import <Foundation/NSDateFormatter.h>
#import "BoSDeviceLocaleHandler.h"

@implementation BoSDeviceLocaleHandler

- (NSString *)currentDateFormatTemplate
{
  return [NSDateFormatter dateFormatFromTemplate:@"ddMMyyyy" options:0 locale:[NSLocale currentLocale]];
}

@end
