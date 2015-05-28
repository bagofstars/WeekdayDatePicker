//
//  BoSWeekdayDatePickerDataGeneratorSpec.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 04/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//
#import "Specta.h"
#import "Expecta.h"
#import "BoSWeekdayDatePickerDataGenerator.h"
#import "BoSDateUnitsUtility.h"
#import "BoSWeekdayDatePickerCalendar.h"
#import "NSDate+BoSConversion.h"

//This test verifies if generated arrays respect date limits.
//For example if date limit is 05.08.2016 the generated month array for year 2016 should contain 8 elements
//and generated days array for year 2016 and month 8 should contain 5 elements.

SpecBegin(BoSWeekdayDatePickerDataGenerator)

describe(@"BoSWeekdayDatePickerDataGenerator when created", ^{
  __block NSCalendar *gregorianCalendar = nil;

  beforeAll(^{
    gregorianCalendar = [BoSWeekdayDatePickerCalendar sharedInstance].calendar;
  });

  afterAll(^{
    gregorianCalendar = nil;
  });

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"

  
  context(@"with empty calendar", ^{
    it(@"should throw an exception", ^{
      expect(^{
        NSDate *minDate = [NSDate dateWithTimeIntervalSinceNow:-1.0];
        NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:1.0];

        [[BoSWeekdayDatePickerDataGenerator alloc] initWithCalendar:nil minDate:minDate maxDate:maxDate];
      }).to.raise(NSInternalInconsistencyException);
    });
  });

  context(@"with empty min date", ^{
    it(@"should throw an exception", ^{
      expect(^{
        NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:1.0];

        [[BoSWeekdayDatePickerDataGenerator alloc] initWithCalendar:gregorianCalendar minDate:nil maxDate:maxDate];
      }).to.raise(NSInternalInconsistencyException);
    });
  });

  context(@"with empty max date", ^{
    it(@"should throw an exception", ^{
      expect(^{
        NSDate *minDate = [NSDate dateWithTimeIntervalSinceNow:-1.0];

        [[BoSWeekdayDatePickerDataGenerator alloc] initWithCalendar:gregorianCalendar minDate:minDate maxDate:nil];
      }).to.raise(NSInternalInconsistencyException);
    });
  });

  context(@"with min date equal max date", ^{
    it(@"should throw an exception", ^{
      expect(^{
        NSDate *now = [NSDate date];
        [[BoSWeekdayDatePickerDataGenerator alloc] initWithCalendar:nil minDate:now maxDate:now];
      }).to.raise(NSInternalInconsistencyException);
    });
  });

#pragma clang diagnostic pop  
  
  context(@"with min date later than max date", ^{
    __block BoSWeekdayDatePickerDataGenerator *sut = nil;

    NSDate* (^simulatedDateWithYear)(NSInteger) = ^NSDate*(NSInteger year) {
      return [NSDate bos_dateInCalendar:gregorianCalendar fromDay:1 month:1 year:year];
    };

    beforeEach(^{
      NSDate *earlierDate = simulatedDateWithYear(2012);
      NSDate *laterDate = simulatedDateWithYear(2014);

      sut = [[BoSWeekdayDatePickerDataGenerator alloc] initWithCalendar:gregorianCalendar minDate:laterDate maxDate:earlierDate];
    });

    afterEach(^{
      sut = nil;
    });

    it(@"should swap those two dates and still produce valid year array", ^{
      NSArray *yearsArray = sut.yearsArray;

      expect(yearsArray).to.haveCountOf(3);
      expect(yearsArray.firstObject).to.equal(@"2012");
      expect(yearsArray.lastObject).to.equal(@"2014");
    });
  });
});


describe(@"BoSWeekdayDatePickerDataGenerator after being created has a default date limit constraints", ^{
  const NSInteger simulatedDay = 15;
  const NSInteger simulatedMonth = 8;
  const NSInteger simulatedEarlierYear = 2014;
  const NSInteger simulatedLaterYear = 2017;
  
  __block BoSWeekdayDatePickerDataGenerator *sut = nil;
  __block NSCalendar *gregorianCalendar = nil;

  __block NSDate *minDate = nil;
  __block NSDate *maxDate = nil;

  beforeAll(^{
    gregorianCalendar = [BoSWeekdayDatePickerCalendar sharedInstance].calendar;
  });

  afterAll(^{
    gregorianCalendar = nil;
  });

  beforeEach(^{
    minDate = [NSDate bos_dateInCalendar:gregorianCalendar fromDay:simulatedDay month:simulatedMonth year:simulatedEarlierYear];
    maxDate = [NSDate bos_dateInCalendar:gregorianCalendar fromDay:simulatedDay month:simulatedMonth year:simulatedLaterYear];
    sut = [[BoSWeekdayDatePickerDataGenerator alloc] initWithCalendar:gregorianCalendar minDate:minDate maxDate:maxDate];
  });

  afterEach(^{
    minDate = maxDate = nil;
    sut = nil;
  });

  context(@"when requested for years array", ^{
    it(@"should return array with all years from simulated earlier to simulated later inclusive ", ^{
      NSUInteger expectedCount = (simulatedLaterYear - simulatedEarlierYear) + 1u;
      expect([sut yearsArray]).to.haveCountOf(expectedCount);
    });
  });

  context(@"when requested for months array", ^{
    it(@"should return array from the simulated month onward to 12 (last month) for min year", ^{
      NSDateComponents *minComponents = [gregorianCalendar components:NSCalendarUnitMonth fromDate:minDate];
      NSUInteger expectedCount = (12u - minComponents.month) + 1u;

      expect([sut monthsArrayForDate:minDate]).to.haveCountOf(expectedCount);
    });

    it(@"should return array from 1 (first month) to the simulated month for max year", ^{
      NSDateComponents *maxDateComponents = [gregorianCalendar components:NSCalendarUnitMonth fromDate:maxDate];

      expect([sut monthsArrayForDate:maxDate]).to.haveCountOf((NSUInteger)maxDateComponents.month);
    });
  });

  context(@"when requested for days array", ^{
    __block BoSDateUnitsUtility *daysUtility = nil;

    beforeAll(^{
      daysUtility = [BoSDateUnitsUtility new];
    });

    afterAll(^{
      daysUtility = nil;
    });

    it(@"should return array from the simulated day onward for min year, simulated month", ^{
      NSDateComponents *minComponents = [gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:minDate];

      NSUInteger overallNumberOfDays = (NSUInteger)[daysUtility numberOfDaysForMonthNumber:minComponents.month yearNumber:minComponents.year];
      NSUInteger expectedCount = (overallNumberOfDays - minComponents.day) + 1u;
      expect([sut daysArrayForDate:minDate]).to.haveCountOf(expectedCount);
    });

    it(@"should return array to the simulated day for max year, simulated month", ^{
      NSDateComponents *maxComponents = [gregorianCalendar components:NSCalendarUnitDay fromDate:maxDate];

      expect([sut daysArrayForDate:maxDate]).to.haveCountOf((NSUInteger)maxComponents.day);
    });
  });
});

SpecEnd
