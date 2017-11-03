//
//  FinanceActionViewController.m
//  qulicai
//
//  Created by admin on 2017/10/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "FinanceActionViewController.h"
#import "NSString+Custom.h"

@interface FinanceActionViewController ()
<WKUIDelegate>

@property (strong, nonatomic) UIButton *leftBackButton;

@end

@implementation FinanceActionViewController


#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.UIDelegate = self;
   // [self wr_setNavBarBackgroundAlpha:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupLeftNavigationBar];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //[self wr_setNavBarTitleColor:[UIColor clearColor]];
    //[self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - WKUIDelegate

-(void)setupNavigation {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacer setWidth:-4];
    UIImage *image = [UIImage imageNamed:@"forget_back_image"];//back_image
    self.leftBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBackButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.leftBackButton addTarget:self action:@selector(leftBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBackButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.leftBackButton];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spacer, rightBarButton, nil];
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > 0) {
//        CGFloat alpha = offsetY  / 64;
//        [self wr_setNavBarBackgroundAlpha:alpha];
//        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
//        [self.leftBackButton setBackgroundImage:[UIImage imageNamed:@"forget_back_image"]
//                                       forState:UIControlStateNormal];
//        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
//    } else {
//        [self wr_setNavBarBackgroundAlpha:0];
//        [self wr_setNavBarTitleColor:[UIColor clearColor]];
//        [self.leftBackButton setBackgroundImage:[UIImage imageNamed:@"back_image"]
//                                       forState:UIControlStateNormal];
//        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
//}

#pragma mark - Public

- (void)setupLeftNavigationBar {
    [self wr_setNavBarTintColor:RGBColor(51.0f, 51.0f, 51.0f)];
    [self setupNavigation];
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
