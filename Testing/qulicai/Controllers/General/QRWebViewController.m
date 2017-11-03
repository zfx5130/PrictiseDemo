//
//  QRWebViewController.m
//  qulicai
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRWebViewController.h"
#import "NSString+Custom.h"

@interface QRWebViewController ()
<WKUIDelegate>

@end

@implementation QRWebViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.UIDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupLeftNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - WKUIDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    //NSLog(@"::::::::::%@------",@(offsetY));
    if (offsetY >= 0) {
        CGFloat alpha = 1;
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

#pragma mark - Public

- (void)setupLeftNavigationBar {
    [self wr_setNavBarTintColor:RGBColor(51.0f, 51.0f, 51.0f)];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

- (instancetype)initWithTitle:(NSString *)title
                    URLString:(NSString *)URLString {
    self = [super initWithURL:[NSURL URLWithString:URLString]];
    if (self) {
        self.webTitle = title;
        self.hideBarsWithGestures = NO;
        self.showPageTitleAndURL = YES;
        self.supportedWebNavigationTools = DZNWebNavigationToolNone;
        self.supportedWebActions = DZNWebActionNone;
    }
    return self;
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
