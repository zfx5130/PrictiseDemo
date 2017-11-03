//
//  UIViewController+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Custom)

+ (UIViewController *)currentViewController;
- (UIViewController *)rootPresentingViewController;

- (void)addShadowForNavigationBar;

- (UIWindow *)lastWindow;

- (NSString *)getCurrentLocaleName;

- (NSString *)getCurrentLocaleCode;


- (void)showSVProgressHUDWithStatus:(NSString *)status;

- (void)showSVProgressHUD;

- (void)dimissSVProgressHUD;

- (void)showSuccessWithTitle:(NSString *)title;

- (void)showErrorWithTitle:(NSString *)title;

- (void)showTipErrorWithTitle:(NSString *)title;

@end
