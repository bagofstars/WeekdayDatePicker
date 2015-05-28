//
//  BoSDataFormatStringFilter.m
//  WeekdayDatePicker
//
//  Created by Marcin Hawro on 11/04/2015.
//  Copyright (c) 2015 Marcin Hawro. All rights reserved.
//

#import <Foundation/NSException.h>
#import <Foundation/NSCharacterSet.h>
#import <Foundation/NSArray.h>
#import "BoSDataFormatStringFilter.h"

static NSString * const BoSApostropheString = @"'";

FOUNDATION_EXTERN NSString * const BoSFormatCharacterForDays;
FOUNDATION_EXTERN NSString * const BoSFormatCharacterForMonths;
FOUNDATION_EXTERN NSString * const BoSFormatCharacterForYears;

@implementation BoSDataFormatStringFilter

- (NSString *)filteredDateFormatString:(NSString *)dateFormatString
{
  NSParameterAssert(dateFormatString.length);

  dateFormatString = [self clearTextBetweenApostrophes:dateFormatString];
  dateFormatString = [self removeAllCharactersExceptDayMonthYearRepresentation:dateFormatString];

  return dateFormatString;
}


#pragma mark - Private methods

- (NSString *)removeAllCharactersExceptDayMonthYearRepresentation:(NSString *)sourceString
{
  NSParameterAssert(sourceString.length);

  NSString *desiredCharacters = [NSString stringWithFormat:@"%@%@%@", BoSFormatCharacterForDays, BoSFormatCharacterForMonths, BoSFormatCharacterForYears];
  NSCharacterSet *charactersToRemove = [[NSCharacterSet characterSetWithCharactersInString:desiredCharacters] invertedSet];

  return [[sourceString componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
}

- (NSString *)clearTextBetweenApostrophes:(NSString *)sourceString
{
  BOOL textContainApostrophes = [sourceString rangeOfString:BoSApostropheString].location != NSNotFound;
  if (!textContainApostrophes) {
    return sourceString;
  }

  NSArray *tokenizedTextArray = [sourceString componentsSeparatedByString:BoSApostropheString];
  NSMutableString *textWithoutApostrophes = [NSMutableString string];

  [tokenizedTextArray enumerateObjectsUsingBlock:^(NSString *token, NSUInteger idx, BOOL *stop) {
    if (!(idx & 1)) {
      [textWithoutApostrophes appendString:token];
    }
  }];

  return textWithoutApostrophes.copy;
}

@end
