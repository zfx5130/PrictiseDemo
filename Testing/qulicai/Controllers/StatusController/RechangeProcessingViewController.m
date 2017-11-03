//
//  RechangeProcessingViewController.m
//  qulicai
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "RechangeProcessingViewController.h"
#import "TotalPropertyViewController.h"

@interface RechangeProcessingViewController ()

@end

@implementation RechangeProcessingViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

#pragma mark - Private

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)config:(UIButton *)sender {
    TotalPropertyViewController *propertyController = [[TotalPropertyViewController alloc] init];
    propertyController.hidesBottomBarWhenPushed = YES;
    propertyController.isBankHanding = YES;
    [self.navigationController pushViewController:propertyController
                                         animated:YES];
}

@end
