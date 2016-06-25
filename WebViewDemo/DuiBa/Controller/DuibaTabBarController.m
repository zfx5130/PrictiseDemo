//
//  DuibaTabBarController.m
//  DuiBa
//
//  Created by czy on 16/6/3.
//  Copyright © 2016年 Caiziyi coporation. All rights reserved.
//

#import "DuibaTabBarController.h"
#import "DBViewController.h"

@interface DuibaTabBarController ()
<UITabBarControllerDelegate>

@end

@implementation DuibaTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    return ![tabBarController.selectedViewController isEqual:viewController];
}

@end
