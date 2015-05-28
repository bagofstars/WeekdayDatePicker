//
//  UIView+NibLoading.m
//  GymSpotter
//
//  Created by Marcin Hawro on 03/02/2014.
//  Copyright (c) 2014 Bag of Stars. All rights reserved.
//

#import <Foundation/NSBundle.h>
#import <UIKit/UINibLoading.h>

#import "UIView+BoSNibLoading.h"

@implementation UIView (NibLoading)

+ (instancetype)loadFromNib
{
  return [UIView loadFromNibNamed:NSStringFromClass(self.class)];
}

+ (instancetype)loadFromNibNamed:(NSString *)nibName
{
  return [[self alloc] initWithNibNamed:nibName];
}

- (instancetype)initWithNibNamed:(NSString *)nibName
{
  NSArray *loadedObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];

  for (UIView *loadedView in loadedObjects) {
    if ([loadedView isKindOfClass:self.class]) {
      return loadedView;
    }
  }

  NSAssert(NO, @"Nib %@ is missing", nibName);
  return nil;
}

@end
