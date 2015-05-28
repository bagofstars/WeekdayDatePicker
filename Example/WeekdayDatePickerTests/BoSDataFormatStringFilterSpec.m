//
//  BoSDataFormatStringFilterSpec.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 11/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "BoSDataFormatStringFilter.h"

FOUNDATION_EXTERN NSString * const BoSFormatCharacterForDays;
FOUNDATION_EXTERN NSString * const BoSFormatCharacterForMonths;
FOUNDATION_EXTERN NSString * const BoSFormatCharacterForYears;

SpecBegin(BoSDataFormatStringFilter)

describe(@"BoSDataFormatStringFilter", ^{

  __block BoSDataFormatStringFilter *sut = nil;
  
  beforeEach(^{
    sut = [BoSDataFormatStringFilter new];
  });
  
  afterEach(^{
    sut = nil;
  });

  it(@"should correctly filter all date format strings for all available locales", ^{
    NSString *allowedDateCharacters = [NSString stringWithFormat:@"%@%@%@", BoSFormatCharacterForDays, BoSFormatCharacterForMonths, BoSFormatCharacterForYears];
    NSCharacterSet *forbiddenCharacters = [[NSCharacterSet characterSetWithCharactersInString:allowedDateCharacters] invertedSet];

    NSArray *allLocales = [NSLocale availableLocaleIdentifiers];
    for (NSString *localeString in allLocales) {
      NSString *formatStringForLocale = [NSDateFormatter dateFormatFromTemplate:@"ddMMyyyy" options:0 locale:[NSLocale localeWithLocaleIdentifier:localeString]];
      NSString *filteredString = [sut filteredDateFormatString:formatStringForLocale];

      BOOL containsDayFormatCharacter = ([filteredString rangeOfString:BoSFormatCharacterForDays].location != NSNotFound);
      expect(containsDayFormatCharacter).to.beTruthy();

      BOOL containsMonthFormatCharacter = ([filteredString rangeOfString:BoSFormatCharacterForMonths].location != NSNotFound);
      expect(containsMonthFormatCharacter).to.beTruthy();

      BOOL containsYearFormatCharacter = ([filteredString rangeOfString:BoSFormatCharacterForYears].location != NSNotFound);
      expect(containsYearFormatCharacter).to.beTruthy();

      BOOL containsAnyForbiddenCharacter = ([filteredString rangeOfCharacterFromSet:forbiddenCharacters].location != NSNotFound);
      expect(containsAnyForbiddenCharacter).to.beFalsy();
    }
  });
});

SpecEnd
