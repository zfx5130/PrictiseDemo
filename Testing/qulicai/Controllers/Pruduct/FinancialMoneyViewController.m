//
//  FinancialMoneyViewController.m
//  qulicai
//
//  Created by admin on 2017/10/9.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "FinancialMoneyViewController.h"

@interface FinancialMoneyViewController ()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end

@implementation FinancialMoneyViewController

#pragma mark - lifeCycle

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
    self.moneyLabel.font = FontNumberDinBoldWithSize(26.0f);
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
