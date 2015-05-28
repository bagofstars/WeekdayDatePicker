//
//  BoSWeekdayDatePickerComponentsOrderManagerSpec.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 05/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "BoSWeekdayDatePickerComponentsOrderManager.h"

SpecBegin(BoSWeekdayDatePickerComponentsOrderManager)

describe(@"BoSWeekdayDatePickerComponentsOrderManager", ^{

  __block BoSWeekdayDatePickerComponentsOrderManager *sut = nil;
  
  beforeEach(^{
    sut = [BoSWeekdayDatePickerComponentsOrderManager new];
  });
  
  afterEach(^{
    sut = nil;
  });
  
  context(@"given that date format template string is ill-formed", ^{
    it(@"should throw an exception", ^{
      expect(^{
        [sut reloadRowsWithDateFormatTemplate:nil];
      }).to.raise(NSInternalInconsistencyException);
    });

    it(@"should throw an exception", ^{
      expect(^{
        [sut reloadRowsWithDateFormatTemplate:@""];
      }).to.raise(NSInternalInconsistencyException);
    });

    it(@"should throw an exception", ^{
      expect(^{
        [sut reloadRowsWithDateFormatTemplate:@"ddMM"];
      }).to.raise(NSInternalInconsistencyException);
    });

    it(@"should throw an exception", ^{
      expect(^{
        [sut reloadRowsWithDateFormatTemplate:@"ddyyyy"];
      }).to.raise(NSInternalInconsistencyException);
    });

    it(@"should throw an exception", ^{
      expect(^{
        [sut reloadRowsWithDateFormatTemplate:@"MMyyyy"];
      }).to.raise(NSInternalInconsistencyException);
    });
    
    it(@"should throw an exception", ^{
      expect(^{
        [sut reloadRowsWithDateFormatTemplate:@"EEEE hhmmss"];
      }).to.raise(NSInternalInconsistencyException);
    });
    
  });

  context(@"given that date format template string is valid", ^{
    it(@"should order rows in day, month, year for 'ddMMyyyy' format", ^{
      [sut reloadRowsWithDateFormatTemplate:@"ddMMyyyy"];

      expect(sut.daysRowNumber).to.equal(1);
      expect(sut.monthRowNumber).to.equal(2);
      expect(sut.yearRowNumber).to.equal(3);
    });

    it(@"should order rows in day, year, month for 'ddyyyyMM' format", ^{
      [sut reloadRowsWithDateFormatTemplate:@"ddyyyyMM"];

      expect(sut.daysRowNumber).to.equal(1);
      expect(sut.yearRowNumber).to.equal(2);
      expect(sut.monthRowNumber).to.equal(3);
    });

    it(@"should order rows in month, day, year for 'MMddyyyy' format", ^{
      [sut reloadRowsWithDateFormatTemplate:@"MMddyyyy"];

      expect(sut.monthRowNumber).to.equal(1);
      expect(sut.daysRowNumber).to.equal(2);
      expect(sut.yearRowNumber).to.equal(3);
    });

    it(@"should order rows in month, day, year for 'MMyyyydd' format", ^{
      [sut reloadRowsWithDateFormatTemplate:@"MMyyyydd"];

      expect(sut.monthRowNumber).to.equal(1);
      expect(sut.yearRowNumber).to.equal(2);
      expect(sut.daysRowNumber).to.equal(3);
    });

    it(@"should order rows in year, month, day for 'yyyyMMdd' format", ^{
      [sut reloadRowsWithDateFormatTemplate:@"yyyyMMdd"];

      expect(sut.yearRowNumber).to.equal(1);
      expect(sut.monthRowNumber).to.equal(2);
      expect(sut.daysRowNumber).to.equal(3);
    });

    it(@"should order rows in year, day, month for 'yyyyddMM' format", ^{
      [sut reloadRowsWithDateFormatTemplate:@"yyyyddMM"];

      expect(sut.yearRowNumber).to.equal(1);
      expect(sut.daysRowNumber).to.equal(2);
      expect(sut.monthRowNumber).to.equal(3);
    });
  });

});

SpecEnd
