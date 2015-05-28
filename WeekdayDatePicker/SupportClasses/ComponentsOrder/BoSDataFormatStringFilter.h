//
//  BoSDataFormatStringFilter.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 11/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <objc/NSObject.h>

/**
 *  Class takes data format string and filters all characters except those
 *  which represent days (usually 'dd'), month (usually 'MM') and year ('yyyy' or 'y').
 */
@interface BoSDataFormatStringFilter : NSObject

- (NSString *)filteredDateFormatString:(NSString *)dateFormatString;

@end
