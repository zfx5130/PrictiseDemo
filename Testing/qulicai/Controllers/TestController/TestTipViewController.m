//
//  TestTipViewController.m
//  qulicai
//
//  Created by admin on 2017/10/9.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "TestTipViewController.h"
#import "zhPopupController.h"
#import "QRShareView.h"
#import "WMHomeViewController.h"

@interface TestTipViewController ()

@property (strong, nonatomic) zhPopupController *zhController;

@end

@implementation TestTipViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Share

- (IBAction)fuli:(UIButton *)sender {
    WMHomeViewController *homeController = [[WMHomeViewController alloc] init];
    [self.navigationController pushViewController:homeController animated:YES];
}


- (IBAction)share:(UIButton *)sender {
    self.zhController = [[zhPopupController alloc] init];
    QRShareView *aView = [[QRShareView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 360)];
    aView.backgroundColor = [UIColor purpleColor];
    aView.currentController = self;
    aView.zhPopController = self.zhController;
    self.zhController.layoutType = zhPopupLayoutTypeBottom;
    [self.zhController presentContentView:aView];
}


- (IBAction)action:(UIButton *)sender {
    
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
