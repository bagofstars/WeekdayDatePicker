//
//  BoSArrayOfComponentsFactorySpec.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 18/02/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "OCMock.h"
#import "BoSArrayOfComponentsFactory.h"
#import "NSDateComponents+BoSComponentValue.h"


SpecBegin(BoSArrayOfComponentsFactory)

id(^mockDateComponentWithUnitAndReturnedValue)(NSCalendarUnit, NSInteger) = ^id(NSCalendarUnit unit, NSInteger value) {
  id mockComponent = OCMClassMock([NSDateComponents class]);
  OCMStub([mockComponent bos_valueForComponent:unit]).andReturn(value);
  return mockComponent;
};

void (^verifyElementsOfArrayWithStartValue)(NSArray *, int) = ^(NSArray *verifiedArray, int startValue) {
  int expectedValue = startValue;
  for (NSString *textValue in verifiedArray) {
    expect([textValue intValue]).to.equal(expectedValue);
    expectedValue++;
  }
};

describe(@"BoSArrayOfComponentsFactory when verifies valuesOfUnit:fromComponent:toComponent:", ^{
  __block id startComponentMock = nil;
  __block id endComponentMock = nil;
  __block BoSArrayOfComponentsFactory *sut = nil;

  beforeEach(^{
    sut = [BoSArrayOfComponentsFactory new];
  });

  afterEach(^{
    [startComponentMock stopMocking];
    [endComponentMock stopMocking];
    sut = nil;
  });

  it(@"should return valid array of years", ^{
    NSCalendarUnit testedUnit = NSCalendarUnitYear;
    int startYear = 2000;

    startComponentMock = mockDateComponentWithUnitAndReturnedValue(testedUnit, startYear);
    endComponentMock = mockDateComponentWithUnitAndReturnedValue(testedUnit, 2010);

    NSArray *resultArray = [sut valuesOfUnit:testedUnit fromComponent:startComponentMock toComponent:endComponentMock];

    expect(resultArray).to.haveCountOf(11);
    verifyElementsOfArrayWithStartValue(resultArray, startYear);
  });

  it(@"should return array with one month", ^{
    NSCalendarUnit testedUnit = NSCalendarUnitMonth;
    int startAndEndYear = 2012;

    startComponentMock = mockDateComponentWithUnitAndReturnedValue(testedUnit, startAndEndYear);
    endComponentMock = mockDateComponentWithUnitAndReturnedValue(testedUnit, startAndEndYear);

    NSArray *resultArray = [sut valuesOfUnit:testedUnit fromComponent:startComponentMock toComponent:endComponentMock];

    expect(resultArray).to.haveCountOf(1);
    verifyElementsOfArrayWithStartValue(resultArray, startAndEndYear);
  });

  it(@"should throw an assert when 'toComponent' is earlier than 'fromComponent' ", ^{
    NSCalendarUnit testedUnit = NSCalendarUnitYear;
    startComponentMock = mockDateComponentWithUnitAndReturnedValue(testedUnit, 2020);
    endComponentMock = mockDateComponentWithUnitAndReturnedValue(testedUnit, 2010);

    expect(^{
      [sut valuesOfUnit:testedUnit fromComponent:startComponentMock toComponent:endComponentMock];
    }).to.raise(NSInternalInconsistencyException);
  });
});


describe(@"BoSArrayOfComponentsFactory when verifies valuesOfUnit:fromComponent:", ^{
  __block NSCalendarUnit verifiedUnit;
  __block id verifiedComponent = nil;
  __block BoSArrayOfComponentsFactory *sut = nil;

  beforeEach(^{
    sut = [BoSArrayOfComponentsFactory new];
  });

  afterEach(^{
    [verifiedComponent stopMocking];
    verifiedComponent = nil;
    sut = nil;
  });

  context(@"against days", ^{
    beforeEach(^{
      verifiedComponent = OCMClassMock([NSDateComponents class]);
    });

    beforeAll(^{
      verifiedUnit = NSCalendarUnitDay;
    });

    it(@"should return array of days from 22 to 28 for February non leap year", ^{
      OCMStub([verifiedComponent bos_valueForComponent:verifiedUnit]).andReturn(22);
      OCMStub([verifiedComponent month]).andReturn(2);
      OCMStub([verifiedComponent year]).andReturn(2017);

      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit fromComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(7);
      verifyElementsOfArrayWithStartValue(generatedArray, 22);

      expect(generatedArray.lastObject).to.equal(@"28");
    });

    it(@"should return array of days from 22 to 29 for February leap year", ^{
      OCMStub([verifiedComponent bos_valueForComponent:verifiedUnit]).andReturn(22);
      OCMStub([verifiedComponent month]).andReturn(2);
      OCMStub([verifiedComponent year]).andReturn(2016);

      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit fromComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(8);
      verifyElementsOfArrayWithStartValue(generatedArray, 22);

      expect(generatedArray.lastObject).to.equal(@"29");
    });

    it(@"should return array with one days for 30th of April", ^{
      OCMStub([verifiedComponent bos_valueForComponent:verifiedUnit]).andReturn(30);
      OCMStub([verifiedComponent month]).andReturn(4);

      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit fromComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(1);
      expect(generatedArray.lastObject).to.equal(@"30");
    });

    it(@"should throw an assert if max day out of range", ^{
      expect(^{
        OCMStub([verifiedComponent bos_valueForComponent:verifiedUnit]).andReturn(32);
        OCMStub([verifiedComponent month]).andReturn(1);
        [sut valuesOfUnit:verifiedUnit fromComponent:verifiedComponent];
      }).to.raise(NSInternalInconsistencyException);
    });
  });

  context(@"against months", ^{
    beforeAll(^{
      verifiedUnit = NSCalendarUnitMonth;
    });

    it(@"should return array of months from 10 to 12", ^{
      verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 10);
      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit fromComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(3);
      verifyElementsOfArrayWithStartValue(generatedArray, 10);
    });

    it(@"should return array with month 12 (December)", ^{
      verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 12);
      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit fromComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(1);
      verifyElementsOfArrayWithStartValue(generatedArray, 12);
    });

    it(@"should throw an assert if max month out of range", ^{
      expect(^{
        verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 13);
        OCMStub([verifiedComponent day]).andReturn(1);
        
        [sut valuesOfUnit:verifiedUnit fromComponent:verifiedComponent];
      }).to.raise(NSInternalInconsistencyException);
    });
  });
});


describe(@"BoSArrayOfComponentsFactory when verifies valuesOfUnit:toComponent:", ^{
  __block NSCalendarUnit verifiedUnit;
  __block id verifiedComponent = nil;
  __block BoSArrayOfComponentsFactory *sut = nil;

  beforeEach(^{
    sut = [BoSArrayOfComponentsFactory new];
  });

  afterEach(^{
    [verifiedComponent stopMocking];
    verifiedComponent = nil;
    sut = nil;
  });

  context(@"against days", ^{
    beforeAll(^{
      verifiedUnit = NSCalendarUnitDay;
    });

    it(@"should return array of days from 1 to 18", ^{
      verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 18);
      OCMStub([verifiedComponent month]).andReturn(1);
      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit toComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(18);
      verifyElementsOfArrayWithStartValue(generatedArray, 1);
    });

    it(@"should return array with day 1", ^{
      verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 1);
      OCMStub([verifiedComponent month]).andReturn(1);
      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit toComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(1);
      verifyElementsOfArrayWithStartValue(generatedArray, 1);
    });

    it(@"should throw an assert if max day out of range", ^{
      expect(^{
        verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 32);
        OCMStub([verifiedComponent month]).andReturn(1);
        
        [sut valuesOfUnit:verifiedUnit toComponent:verifiedComponent];
      }).to.raise(NSInternalInconsistencyException);
    });
  });

  context(@"against months", ^{
    beforeAll(^{
      verifiedUnit = NSCalendarUnitMonth;
    });

    it(@"should return array of months from 1 to 5", ^{
      verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 5);
      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit toComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(5);
      verifyElementsOfArrayWithStartValue(generatedArray, 1);
    });

    it(@"should return array with month 1", ^{
      verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 1);
      NSArray *generatedArray = [sut valuesOfUnit:verifiedUnit toComponent:verifiedComponent];

      expect(generatedArray).to.haveCountOf(1);
      verifyElementsOfArrayWithStartValue(generatedArray, 1);
    });

    it(@"should throw an assert if max month out of range", ^{
      expect(^{
        verifiedComponent = mockDateComponentWithUnitAndReturnedValue(verifiedUnit, 13);
        OCMStub([verifiedComponent day]).andReturn(1);
        
        [sut valuesOfUnit:verifiedUnit toComponent:verifiedComponent];
      }).to.raise(NSInternalInconsistencyException);
    });
  });
});


describe(@"BoSArrayOfComponentsFactory when verifies arrayOfMonthsForYear:", ^{
  __block BoSArrayOfComponentsFactory *sut = nil;

  beforeEach(^{
    sut = [BoSArrayOfComponentsFactory new];
  });

  afterEach(^{
    sut = nil;
  });

  it(@"should return array of 12 numbers from 1 to 12", ^{
    NSArray *generatedArray = [sut arrayOfMonthsForYear:2025];

    expect(generatedArray).to.haveCountOf(12);
    verifyElementsOfArrayWithStartValue(generatedArray, 1);
  });
});


describe(@"BoSArrayOfComponentsFactory when verifies arrayOfDaysForDateComponent:", ^{
  __block BoSArrayOfComponentsFactory *sut = nil;
  __block id componentMock = nil;

  beforeEach(^{
    sut = [BoSArrayOfComponentsFactory new];
    componentMock = OCMStrictClassMock([NSDateComponents class]);
  });

  afterEach(^{
    [componentMock stopMocking];
    componentMock = nil;
    sut = nil;
  });

  it(@"should return array of 28 days for February in non-leap year", ^{
    OCMStub([componentMock month]).andReturn(2);
    OCMStub([componentMock year]).andReturn(2017);

    NSArray *generatedArray = [sut arrayOfDaysForDateComponent:componentMock];

    expect(generatedArray).to.haveCountOf(28);
    verifyElementsOfArrayWithStartValue(generatedArray, 1);
  });

  it(@"should return array of 29 days for February in leap year", ^{
    OCMStub([componentMock month]).andReturn(2);
    OCMStub([componentMock year]).andReturn(2016);

    NSArray *generatedArray = [sut arrayOfDaysForDateComponent:componentMock];

    expect(generatedArray).to.haveCountOf(29);
    verifyElementsOfArrayWithStartValue(generatedArray, 1);
  });

  it(@"should return array of 30 days for June", ^{
    OCMStub([componentMock month]).andReturn(6);
    OCMStub([componentMock year]).andReturn(0);

    NSArray *generatedArray = [sut arrayOfDaysForDateComponent:componentMock];

    expect(generatedArray).to.haveCountOf(30);
    verifyElementsOfArrayWithStartValue(generatedArray, 1);
  });

  it(@"should return array of 31 days for December", ^{
    OCMStub([componentMock month]).andReturn(12);
    OCMStub([componentMock year]).andReturn(0);

    NSArray *generatedArray = [sut arrayOfDaysForDateComponent:componentMock];

    expect(generatedArray).to.haveCountOf(31);
    verifyElementsOfArrayWithStartValue(generatedArray, 1);
  });

  it(@"should throw an assert when input component is missing month unit value", ^{
    expect(^{ [sut arrayOfDaysForDateComponent:componentMock]; }).to.raise(NSInternalInconsistencyException);
  });

  it(@"should throw an assert when input component represents February but is missing year unit value", ^{
    OCMStub([componentMock month]).andReturn(2);

    expect(^{ [sut arrayOfDaysForDateComponent:componentMock]; }).to.raise(NSInternalInconsistencyException);
  });
});


SpecEnd
