//
//  BoSDeviceLocaleHandler.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 05/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <objc/NSObject.h>

@interface BoSDeviceLocaleHandler : NSObject

/*
  Return date format string depending on the locales set on the device.
  E.g. English (United States) it returns "MM/dd/yyyy" for English (United Kingdom) returns "dd/MM/yyyy" etc...
 */
@property (nonatomic, copy, readonly) NSString *currentDateFormatTemplate;

@end
