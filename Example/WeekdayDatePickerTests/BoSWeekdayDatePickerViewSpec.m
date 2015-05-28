//
//  BoSWeekdayDatePickerViewSpec.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 18/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "BoSWeekdayDatePickerView.h"
#import "BoSWeekdayDatePickerCalendar.h"
#import "NSDate+BoSConversion.h"

SpecBegin(BoSWeekdayDatePickerView)

fdescribe(@"BoSWeekdayDatePickerView", ^{
  const NSTimeInterval datePickerDataReloadDelay = 3.0;
  __block BoSWeekdayDatePickerView *sut = nil;
  __block NSDate *initialSelectionDate = nil;
  __block NSDate *minDate = nil;
  __block NSDate *maxDate = nil;

  beforeEach(^{
    sut = [BoSWeekdayDatePickerView new];
  });
  
  afterEach(^{
    sut = nil;
  });

  it(@"should throw an assert when min date is missing", ^{
    expect(^{
      [sut setupMinDate:nil maxDate:[NSDate date] initialSelectionDate:[NSDate date]];
    }).to.raise(NSInternalInconsistencyException);
  });

  it(@"should throw an assert when max date is missing", ^{
    expect(^{
      [sut setupMinDate:[NSDate date] maxDate:nil initialSelectionDate:[NSDate date]];
    }).to.raise(NSInternalInconsistencyException);
  });

  context(@"when initial selection date is missing", ^{
    it(@"should setup first row in day, month and year components", ^{
      [sut setupMinDate:[NSDate dateWithTimeIntervalSinceNow:-10.0] maxDate:[NSDate date] initialSelectionDate:nil];

      expect([sut selectedRowInComponent:1]).will.after(datePickerDataReloadDelay).equal(0);
      expect([sut selectedRowInComponent:2]).will.after(datePickerDataReloadDelay).equal(0);
      expect([sut selectedRowInComponent:3]).will.after(datePickerDataReloadDelay).equal(0);
    });
  });

  context(@"when initial selection date is earlier than min date", ^{
    beforeEach(^{
      initialSelectionDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                                fromDay:1 month:1 year:1999];
      minDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                   fromDay:15 month:6 year:2000];
      maxDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                   fromDay:30 month:12 year:2001];
    });

    afterEach(^{
      initialSelectionDate = minDate = maxDate = nil;
    });

    it(@"should setup first row in day, month and year components", ^{
      [sut setupMinDate:minDate maxDate:maxDate initialSelectionDate:initialSelectionDate];

      expect([sut selectedRowInComponent:1]).will.after(datePickerDataReloadDelay).equal(0);
      expect([sut selectedRowInComponent:2]).will.after(datePickerDataReloadDelay).equal(0);
      expect([sut selectedRowInComponent:3]).will.after(datePickerDataReloadDelay).equal(0);
    });
  });


  context(@"when initial selection date is later than max date", ^{
    beforeEach(^{
      minDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                   fromDay:1 month:1 year:1999];
      maxDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                   fromDay:15 month:6 year:2000];
      initialSelectionDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                                fromDay:30 month:12 year:2001];
    });

    afterEach(^{
      initialSelectionDate = minDate = maxDate = nil;
    });

    it(@"should setup first row in day, month and year components", ^{
      [sut setupMinDate:minDate maxDate:maxDate initialSelectionDate:initialSelectionDate];

      expect([sut selectedRowInComponent:1]).will.after(datePickerDataReloadDelay).equal(0);
      expect([sut selectedRowInComponent:2]).will.after(datePickerDataReloadDelay).equal(0);
      expect([sut selectedRowInComponent:3]).will.after(datePickerDataReloadDelay).equal(0);
    });
  });


  context(@"when initial selection date is one day, one month and one year later than min date", ^{
    beforeEach(^{
      minDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                   fromDay:1 month:1 year:1998];
      initialSelectionDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                                fromDay:2 month:2 year:1999];
      maxDate = [NSDate bos_dateInCalendar:[BoSWeekdayDatePickerCalendar sharedInstance].calendar
                                   fromDay:1 month:1 year:2000];
    });

    afterEach(^{
      initialSelectionDate = minDate = maxDate = nil;
    });

    it(@"should setup second row in day, month and year components", ^{
      [sut setupMinDate:minDate maxDate:maxDate initialSelectionDate:initialSelectionDate];

      expect([sut selectedRowInComponent:1]).will.after(datePickerDataReloadDelay).equal(1);
      expect([sut selectedRowInComponent:2]).will.after(datePickerDataReloadDelay).equal(1);
      expect([sut selectedRowInComponent:3]).will.after(datePickerDataReloadDelay).equal(1);
    });
  });
});

SpecEnd
