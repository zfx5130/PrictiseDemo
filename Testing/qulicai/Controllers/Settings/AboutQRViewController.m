//
//  AboutQRViewController.m
//  qulicai
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "AboutQRViewController.h"
#import "QRWebViewController.h"
#import "SuggestViewController.h"
#import "UserUtil.h"
#import "User.h"

@interface AboutQRViewController ()
<UIScrollViewDelegate>

@end

@implementation AboutQRViewController

#pragma mark - lifeCycle

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
    self.navigationItem.title = @"关于趣理财";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    //NSLog(@"::::::::%@:::",@(offsetY));
    if (offsetY >= 0) {
        CGFloat alpha = 1;
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

#pragma mark - Handlers

- (IBAction)qrInfo:(UIButton *)sender {
    NSString *urlString = @"http://h5.qulicai8.com:3478/qlc_company.html";//@"https://www.qulicai8.com/#/companyAndproduct";
    QRWebViewController *webViewController = [[QRWebViewController alloc] initWithTitle:@"公司简介"
                                                                              URLString:urlString];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}

- (IBAction)suggest:(UIButton *)sender {
    if ([UserUtil isLoginIn]) {
        SuggestViewController *suggestController = [[SuggestViewController alloc] init];
        [self.navigationController pushViewController:suggestController
                                             animated:YES];
    } else {
        [self login];
    }
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
