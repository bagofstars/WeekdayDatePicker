//
//  BoSWeekdayDatePickerCalendar.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 04/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSCalendar.h>

@interface BoSWeekdayDatePickerCalendar : NSObject

@property (nonatomic, strong, readonly) NSCalendar *calendar;

+ (instancetype)sharedInstance;

@end
