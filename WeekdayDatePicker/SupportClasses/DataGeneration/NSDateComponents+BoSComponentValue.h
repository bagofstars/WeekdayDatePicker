//
//  NSDateComponents+BoSComponentValue.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 20/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSCalendar.h>

@interface NSDateComponents (BoSComponentValue)

/*
 There is a similar method in NSDateComponents class but only for iOS 8.
 */
- (NSInteger)bos_valueForComponent:(NSCalendarUnit)unit;

@end
