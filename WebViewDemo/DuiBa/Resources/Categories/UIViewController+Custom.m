//
//  UIViewController+Custom.m
//  DuiBa
//
//  Created by dev on 6/6/16.
//  Copyright © 2016 Caiziyi coporation. All rights reserved.
//

#import "UIViewController+Custom.h"

@implementation UIViewController (Custom)

- (void)addBackButton {
    UIColor *color =
    [UIColor colorWithRed: 125 / 255.0  green:230 / 255.0f blue:225 / 255.0 alpha:1.0];
    [self.navigationController.navigationBar setTintColor:color];
}

@end
