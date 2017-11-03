//
//  UIViewController+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "UIViewController+Custom.h"

#import "UILabel+Custom.h"
#import "UIImage+Custom.h"
#import "UIColor+Custom.h"
#import "UIImage+GIF.h"
#import "WXZTipView.h"

@implementation UIViewController (Custom)

+ (UIViewController *)currentViewController {
    NSArray *windows = [UIApplication sharedApplication].windows;
//    NSLog(@"%@", [UIApplication sharedApplication].keyWindow.rootViewController);
    for (UIWindow *window in windows) {
//        NSLog(@"%@", window.rootViewController);
        if (window.rootViewController) {
            return [UIViewController findBestViewController:window.rootViewController];
            break;
        }
    }
    
    return nil;
}

+ (UIViewController *)findBestViewController:(UIViewController *)viewController {
    if (viewController.presentedViewController) {
        return [UIViewController findBestViewController:viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *sourceViewController = (UISplitViewController *)viewController;
        if (sourceViewController.viewControllers.count) {
            return [UIViewController findBestViewController:sourceViewController.viewControllers.lastObject];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *sourceViewController = (UINavigationController *)viewController;
        if (sourceViewController.viewControllers.count) {
            return [UIViewController findBestViewController:sourceViewController.topViewController];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *sourceViewController = (UITabBarController *)viewController;
        if (sourceViewController.viewControllers.count) {
            return [UIViewController findBestViewController:sourceViewController.selectedViewController];
        } else {
            return viewController;
        }
    } else {
        return viewController;
    }
}

- (UIViewController *)rootPresentingViewController {
    
    UIViewController *rootPresentingViewController = self;
    
    if (!rootPresentingViewController.presentingViewController) {
        return nil;
    }
    
    while (rootPresentingViewController.presentingViewController) {
        rootPresentingViewController = rootPresentingViewController.presentingViewController;
    }
    
    return rootPresentingViewController;
}

- (void)addShadowForNavigationBar {
    UIImage *shadowImage = [UIImage imageWithColor:RGBAColor(229.0f, 234.0f, 240.0f, 1.0f)
                                              size:CGSizeMake(0.75f, 0.75f)];
//    [UIImage imageNamed:@"nav_shadow"]
    [self.navigationController.navigationBar setShadowImage:shadowImage];
    
}


- (UIWindow *)lastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}


- (NSString *)getCurrentLocaleName {
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *coutryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    NSString *displayName = [currentLocale displayNameForKey:NSLocaleCountryCode
                                                       value:coutryCode];
    return displayName;
}

- (NSString *)getCurrentLocaleCode {
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *coutryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    NSString *displayName = [currentLocale displayNameForKey:NSLocaleCountryCode
                                                       value:coutryCode];
    NSData *data =
    [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                    pathForResource:@"diallingcode"
                                    ofType:@"json"]];
    NSError *error = nil;
    NSArray *arrayCode =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:0
                                      error:&error];
    if (![arrayCode count]) {
        return @"+86";
    }
    NSString *code;
    for (NSDictionary *countryAttributes in arrayCode) {
        NSString *name = [currentLocale displayNameForKey:NSLocaleCountryCode
                                                    value:countryAttributes[@"code"]];
        if ([name isEqual:displayName]) {
            code = countryAttributes[@"dial_code"];
        }
    }
    return code;
}

- (void)showSVProgressHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:[UIColor appDefaultColor]];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD show];
}

- (void)dimissSVProgressHUD {
    [SVProgressHUD dismiss];
}

- (void)showSVProgressHUDWithStatus:(NSString *)status {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:[UIColor appDefaultColor]];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:status];
}

- (void)showSuccessWithTitle:(NSString *)title {
    [SVProgressHUD setForegroundColor:[UIColor appDefaultColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"success_image"]];
    [SVProgressHUD showSuccessWithStatus:title];
    [SVProgressHUD dismissWithDelay:0.6];
}

- (void)showErrorWithTitle:(NSString *)title {
    if (!title) {
        title = @"请求错误";
    }
    [WXZTipView showCenterWithText:title];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
//    //[SVProgressHUD setSuccessImage:[UIImage imageNamed:@"success_image"]];
//    [SVProgressHUD showErrorWithStatus:title];
//    [SVProgressHUD dismissWithDelay:0.6];
}

- (void)showTipErrorWithTitle:(NSString *)title {
    if (!title.length) {
        return;
    }
    [WXZTipView showCenterWithText:title];
}

@end
