//
//  PackBuySuccessViewController.m
//  qulicai
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "PackBuySuccessViewController.h"
#import "QRBuyHistoryViewController.h"
#import "NSDate+Custom.h"

@interface PackBuySuccessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *tomorrowLabel;

@property (weak, nonatomic) IBOutlet UILabel *tomorrowTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *periodTimeLabel;

@end

@implementation PackBuySuccessViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval currentInterval = [date timeIntervalSince1970];
    NSString *currentTime = [NSString stringWithTimeInterval:currentInterval];
    
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 1];
    NSTimeInterval tomorrowInterval = [tomorrowDate timeIntervalSince1970];
    NSString *tomorrowTime =
    [[[NSString stringWithTimeInterval:tomorrowInterval] componentsSeparatedByString:@" "] firstObject];
    self.currentTimeLabel.text = [NSString getStringWithString:currentTime];
    self.tomorrowTimeLabel.text = @"开始计算收益";
    
    NSString *weekDay = [NSDate weekdayStringFromDate:tomorrowDate];
    self.tomorrowLabel.text =
    [NSString getStringWithString:[NSString stringWithFormat:@"%@ %@",tomorrowTime ,weekDay]];
    
    NSString *lastPeriodValue =
    [[A0SimpleKeychain keychain] stringForKey:QR_PRODUCT_PERIOD];
    if (!lastPeriodValue.length) {
        lastPeriodValue = @"30";
    }
    NSDate *periodDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * ([lastPeriodValue integerValue] + 1)];
    NSString *lastWeekDay =
    [NSDate weekdayStringFromDate:periodDate];
    NSTimeInterval periodInterval = [periodDate timeIntervalSince1970];
    NSString *periodTime =
    [[[NSString stringWithTimeInterval:periodInterval] componentsSeparatedByString:@" "] firstObject];
    self.periodTimeLabel.text =
    [NSString getStringWithString:[NSString stringWithFormat:@"%@ %@", periodTime, lastWeekDay]];
    
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)config:(UIButton *)sender {
    QRBuyHistoryViewController *historyController = [[QRBuyHistoryViewController alloc] init];
    historyController.isPresent = YES;
    historyController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:historyController
                                         animated:YES];
}


@end
