//
//  ProductBuySuccessViewController.m
//  qulicai
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ProductBuySuccessViewController.h"
#import "ResetPasswordViewController.h"
#import "QRBuyHistoryViewController.h"

@interface ProductBuySuccessViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UIButton *configButton;

@end

@implementation ProductBuySuccessViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (NSString *)currentTime {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 2];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd hh:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

- (void)setupViews {
    if (self.isPickupSuccess) {
        self.titleLabel.text = @"提现成功!";
        self.secondLabel.text = [NSString stringWithFormat:@"预计到账时间为%@",[self currentTime]];
        [self.configButton setTitle:@"返回首页"
                           forState:UIControlStateNormal];
    } else if (self.isBuySuccess) {
        self.titleLabel.text = @"购买成功!";
        self.secondLabel.text = [NSString stringWithFormat:@"认购金额(元)   %@",self.money];
        [self.configButton setTitle:@"确定"
                           forState:UIControlStateNormal];
    } else if (self.isChargeSuccess) {
        self.titleLabel.text = @"充值成功!";
        self.secondLabel.text = @"快去选购定期产品赚钱吧！";
        [self.configButton setTitle:@"前往选购"
                           forState:UIControlStateNormal];
    }
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)config:(UIButton *)sender {
    
    if (self.isPickupSuccess) {
        //提现成功跳转
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if (self.isBuySuccess) {
        //购买成功跳转
        QRBuyHistoryViewController *historyController = [[QRBuyHistoryViewController alloc] init];
        historyController.isPresent = YES;
        historyController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:historyController
                                             animated:YES];
        
    } else if (self.isChargeSuccess) {
        //充值成功跳转
        self.tabBarController.selectedIndex = 1;
        [self.navigationController popViewControllerAnimated:NO];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end
