//
//  BoSDateLimitSpec.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 02/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "BoSDateLimit.h"
#import "BoSWeekdayDatePickerCalendar.h"

SpecBegin(BoSDateLimit)

describe(@"BoSDateLimit", ^{
  __block NSDateComponents *inputDateComponents = nil;

  beforeEach(^{
    inputDateComponents = [NSDateComponents new];
  });

  afterEach(^{
    inputDateComponents = nil;
  });

  NSDate *(^dateFromComponentsBlock)(NSInteger, NSInteger, NSInteger) = ^NSDate *(NSInteger day, NSInteger month, NSInteger year) {
    inputDateComponents.day = day;
    inputDateComponents.month = month;
    inputDateComponents.year = year;
    return [[BoSWeekdayDatePickerCalendar sharedInstance].calendar dateFromComponents:inputDateComponents];
  };

  context(@"when requested for maximum date", ^{
    it(@"should return date which is exactly one year later than the specified date", ^{
//Tested method
      NSDate *constructedMaxDate = [BoSDateLimit maximumDateFromDate:dateFromComponentsBlock(1, 1, 2015)];
      NSCalendar *calendar = [BoSWeekdayDatePickerCalendar sharedInstance].calendar;
      NSDateComponents *maxDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:constructedMaxDate];

      expect(maxDateComponents.day).to.equal(inputDateComponents.day);
      expect(maxDateComponents.month).to.equal(inputDateComponents.month);
      expect(maxDateComponents.year).to.equal(inputDateComponents.year + 1);
    });

    it(@"should return date which is one year later sans one day than the specified date with leap day", ^{
//Tested method
      NSDate *constructedMaxDate = [BoSDateLimit maximumDateFromDate:dateFromComponentsBlock(29, 2, 2012)];
      NSCalendar *calendar = [BoSWeekdayDatePickerCalendar sharedInstance].calendar;
      NSDateComponents *maxDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:constructedMaxDate];

      expect(maxDateComponents.day).to.equal(inputDateComponents.day - 1);
      expect(maxDateComponents.month).to.equal(inputDateComponents.month);
      expect(maxDateComponents.year).to.equal(inputDateComponents.year + 1);
    });
  });
  
  context(@"when requested for minimum date", ^{
    it(@"should return date which is exactly one year earlier than the specified date", ^{

//Tested method
      NSDate *constructedMinDate = [BoSDateLimit minimumDateFromDate:dateFromComponentsBlock(1, 1, 2015)];
      NSCalendar *calendar = [BoSWeekdayDatePickerCalendar sharedInstance].calendar;
      NSDateComponents *minDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:constructedMinDate];

      expect(minDateComponents.day).to.equal(inputDateComponents.day);
      expect(minDateComponents.month).to.equal(inputDateComponents.month);
      expect(minDateComponents.year).to.equal(inputDateComponents.year - 1);
    });

    it(@"should return date which is one year earlier sans one day than the specified date with leap day", ^{

//Tested method
      NSDate *constructedMinDate = [BoSDateLimit minimumDateFromDate:dateFromComponentsBlock(29, 2, 2012)];
      NSCalendar *calendar = [BoSWeekdayDatePickerCalendar sharedInstance].calendar;
      NSDateComponents *minDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:constructedMinDate];

      expect(minDateComponents.day).to.equal(inputDateComponents.day - 1);
      expect(minDateComponents.month).to.equal(inputDateComponents.month);
      expect(minDateComponents.year).to.equal(inputDateComponents.year - 1);
    });
  });
});

SpecEnd
