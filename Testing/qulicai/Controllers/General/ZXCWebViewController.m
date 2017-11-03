//
//  ZXCWebViewController.m
//  zhixingche
//
//  Created by satgi on 9/26/15.
//  Copyright © 2015 yunzao. All rights reserved.
//

#import "ZXCWebViewController.h"
#import "NSString+Custom.h"

@interface ZXCWebViewController ()
<UIScrollViewDelegate>

@end

@implementation ZXCWebViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backIndicatorImage = [UIImage imageNamed:@"forget_back_image"];
    UIBarButtonItem *backIndicatorBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:backIndicatorImage
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(dimiss)];
    self.applicationLeftBarButtonItems = @[backIndicatorBarButtonItem];
    [self wr_setNavBarShadowImageHidden:YES];
    [self wr_setNavBarTintColor:RGBColor(51.0f, 51.0f, 51.0f)];
    self.navigationItem.hidesBackButton = YES;
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    self.fd_interactivePopDisabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.webView.scrollView.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
   // self.navigationItem.hidesBackButton = NO;
}

- (void)viewDidLayoutSubviews {
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0) {
        CGFloat alpha = 1;
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

#pragma mark - Public

- (instancetype)initWithTitle:(NSString *)title
                    URLString:(NSString *)URLString {
    self = [super initWithURLString:URLString];
    if (self) {
        self.navigationItem.title = title;
        self.showPageTitles = NO;
        self.loadingBarTintColor = [UIColor appDefaultColor];
        self.buttonTintColor = [UIColor appDefaultColor];
        self.showActionButton = NO;
        self.navigationButtonsHidden = YES;
    }
    return self;
}

- (void)dimiss {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
