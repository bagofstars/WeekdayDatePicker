//
//  BoSWeekdayDatePickerAppearance.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 01/03/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <objc/NSObject.h>

@class BoSWeekdayDatePickerComponentsOrderManager;


@interface BoSWeekdayDatePickerAppearance : NSObject

- (instancetype)initWithComponentsOrderManager:(BoSWeekdayDatePickerComponentsOrderManager *)orderManager;

- (CGFloat)rowWidthForComponent:(NSInteger)component;
- (UIView *)viewForComponent:(NSInteger)component;

- (NSAttributedString *)decoratedStringFromString:(NSString *)rowString forComponent:(NSInteger)component;

@end
