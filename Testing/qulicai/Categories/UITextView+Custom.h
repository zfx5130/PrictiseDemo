//
//  UITextView+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Custom)
<UITextViewDelegate>

@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, strong) UIColor *placeHolderColor;

@end
