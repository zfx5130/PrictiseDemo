//
//  BuyFailViewController.m
//  qulicai
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BuyFailViewController.h"
#import "QRResultAnimationView.h"

@interface BuyFailViewController ()

@property (weak, nonatomic) IBOutlet UIView *failView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorInfoLabel;

@end

@implementation BuyFailViewController

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
    [self showFail];
}

- (void)showFail {
    QRResultAnimationView *failView =
    [[QRResultAnimationView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0f, 50.0f) resultType:ShowResultTypeFail];
    [self.failView addSubview:failView];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.errorInfoLabel.text = @"购买失败！";
        NSString *errorMessage = self.errorMessage.length > 0 ? self.errorMessage : @"交易失败";
        weakSelf.errorLabel.text = errorMessage;
    });
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)config:(UIButton *)sender {
    self.tabBarController.selectedIndex = 1;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
