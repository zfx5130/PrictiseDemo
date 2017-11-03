//
//  PickUpSuccessViewController.m
//  qulicai
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "PickUpSuccessViewController.h"
#import "TotalPropertyViewController.h"

@interface PickUpSuccessViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *tomorrowTimeLabel;

@end

@implementation PickUpSuccessViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSString *tomorrowTime = [NSString stringWithTimeInterval:tomorrowInterval];
    
    
    self.currentTimeLabel.text = [NSString getStringWithString:currentTime];
    self.tomorrowTimeLabel.text = [NSString getStringWithString:tomorrowTime];
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
