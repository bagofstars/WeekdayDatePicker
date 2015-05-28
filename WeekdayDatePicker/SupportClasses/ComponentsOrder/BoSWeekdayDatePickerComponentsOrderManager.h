//
//  BoSWeekdayDatePickerComponentsOrderManager.h
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 05/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "BoSWeekdayDatePickerView.h"

@interface BoSWeekdayDatePickerComponentsOrderManager : NSObject <BoSWeekdayDatePickerLocaleChangeDelegate>

/*
  Array indexes corresponds to the component number (column) before changing locale. Values are the selected rows.
  Property is used to retain correct row selection after device locale has been switched and day-month-year components changed their columns.
 */
@property (nonatomic, copy, readonly) NSDictionary *selectedRows;

@property (nonatomic, assign, readonly) NSInteger daysRowNumber;
@property (nonatomic, assign, readonly) NSInteger monthRowNumber;
@property (nonatomic, assign, readonly) NSInteger yearRowNumber;

- (void)reloadRowsWithDateFormatTemplate:(NSString *)dateFormatTemplate;

@end
