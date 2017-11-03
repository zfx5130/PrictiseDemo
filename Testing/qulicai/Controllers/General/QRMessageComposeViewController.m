//
//  QRMessageComposeViewController.m
//  qulicai
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRMessageComposeViewController.h"

@interface QRMessageComposeViewController ()

@end

@implementation QRMessageComposeViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createNavigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - handlers

- (void)createNavigationController {
    UINavigationItem *messageNavigationItem = [[self.viewControllers lastObject] navigationItem];
    messageNavigationItem.title = @"通讯录分享";
    UIButton *cancelButton = [[UIButton alloc] init];
    cancelButton.frame = CGRectMake(0, 5, 45, 45);
    [cancelButton setImage:[UIImage imageNamed:@"forget_back_image"]
                  forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(back_mainVC)
           forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    messageNavigationItem.leftBarButtonItem = leftBarItem;
    
}

- (void)back_mainVC {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}


@end
