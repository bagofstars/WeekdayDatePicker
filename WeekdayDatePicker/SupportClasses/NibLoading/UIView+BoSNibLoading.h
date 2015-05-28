//
//  UIView+BoSNibLoading.h
//  GymSpotter
//
//  Created by Marcin Hawro on 03/02/2014.
//  Copyright (c) 2014 Bag of Stars. All rights reserved.
//

#import <UIKit/UIView.h>

@interface UIView (NibLoading)

+ (instancetype)loadFromNib;

+ (instancetype)loadFromNibNamed:(NSString *)nibName;
- (instancetype)initWithNibNamed:(NSString *)nibName;

@end
