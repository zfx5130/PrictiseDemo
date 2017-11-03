//
//  UITextField+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Custom)

@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, assign) BOOL defaultPadding;
@property (nonatomic, assign) CGFloat leftPadding;
@property (nonatomic, assign) CGFloat rightPadding;
@property (nonatomic, copy) NSString *leftLabelTitle;
@property (nonatomic, copy) NSString *rightImageName;
@property (nonatomic, assign) BOOL toggledSecureEntry;
@property (nonatomic, copy) UIColor *placeHolderColor;

@end
