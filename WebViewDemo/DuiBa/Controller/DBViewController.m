//
//  DBViewController.m
//  DuiBa
//
//  Created by czy on 16/6/3.
//  Copyright © 2016年 Caiziyi coporation. All rights reserved.
//

#import "DBViewController.h"
#import "UIViewController+Custom.h"
#import "LoadFailView.h"
#import "Reachability.h"

@interface DBViewController ()

@property (strong, nonatomic) UIButton *backItemButton;
@property (retain, nonatomic) LoadFailView *noNetView;

@end

@implementation DBViewController

#pragma mark - Lifecycle

- (instancetype)initWithTitle:(NSString *)title
                    URLString:(NSString *)URLString {
    self = [self initWithTitle:title
                     URLString:URLString
       navigationButtonsHidden:NO];
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                    URLString:(NSString *)URLString
      navigationButtonsHidden:(BOOL)navigationButtonsHidden {
    self = [super initWithURLString:URLString];
    if (self) {
        self.showPageTitles = YES;
        self.showUrlWhileLoading = NO;
        self.navigationButtonsHidden = navigationButtonsHidden;
        UIColor *color =
        [UIColor colorWithRed: 29/255.0  green:171/255.0f blue:163/255.0 alpha:1.0];
        self.loadingBarTintColor = color;
        self.buttonTintColor = color;
        self.disableContextualPopupMenu = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.noNetView = [[LoadFailView alloc] initWithFrame:self.view.bounds];
//    [self.webView addSubview:self.noNetView];
//    [self.webView bringSubviewToFront:self.noNetView];
//    self.noNetView.hidden = YES;
    
//    if (kStatus == NotReachable) { //断网情况
//        self.noNetView.hidden = NO;
//        [self.noNetView.noNetBtn addTarget:self action:@selector(reloadAction:) forControlEvents:UIControlEventTouchUpInside];
//    }else {
        if (self.webView.canGoBack) {
            [self setupNavigationBackButtonItemWithStatus:YES];
        }
        [self.webView reload];
//    }

}

////重新加载方法
//- (void)reloadAction:(id)sender{
//    [self.webView reload];
//}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupNavigationBackButtonItemWithStatus:(BOOL)canGoBack {
    self.backItemButton =
    [UIButton buttonWithType:UIButtonTypeSystem];
    self.backItemButton.frame = CGRectMake(0, 0, 50, 25);
    [self.backItemButton setTitle:@"返回"
                         forState:UIControlStateNormal];
    [self.backItemButton setImage:[UIImage imageNamed:@"back_indicator"]
                         forState:UIControlStateNormal];
    self.backItemButton.imageEdgeInsets = UIEdgeInsetsMake(4, -10, 4, 10);
    self.backItemButton.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 10);
    UIColor *color =
    [UIColor colorWithRed: 29 / 255.0  green:171 / 255.0f blue:163 / 255.0 alpha:1.0];
    [self.backItemButton setTintColor:color];
    self.backItemButton.hidden = canGoBack ? NO : YES;
    [self.self.backItemButton addTarget:self
                                 action:@selector(backButtonWasPressed:)
                       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:self.backItemButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
}

#pragma mark - UIWebViewDeletate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [self setupNavigationBackButtonItemWithStatus:YES];
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.noNetView.hidden = YES;
    if (!webView.canGoBack) {
        [self setupNavigationBackButtonItemWithStatus:NO];
    }
}

#pragma mark - Handlers

- (void)backButtonWasPressed:(UIBarButtonItem *)barItem {
    [self.webView goBack];
    if (!self.webView.canGoBack) {
        [self setupNavigationBackButtonItemWithStatus:NO];
        [self.webView reload];
    }
}

@end
