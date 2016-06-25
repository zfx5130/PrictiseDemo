//
//  IntroductionViewController.m
//  DuiBa
//
//  Created by dev on 6/6/16.
//  Copyright © 2016 Caiziyi coporation. All rights reserved.
//

#import "IntroductionViewController.h"
#import "DBViewController.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self skipToWebViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)skipToWebViewController {
    DBViewController *webView =
    [[DBViewController alloc] initWithTitle:@"简介"
                                  URLString:@"http://home.duiba.com.cn/ios_introduction.html"
                    navigationButtonsHidden:YES];
    [self.navigationController pushViewController:webView
                                         animated:NO];
}

@end
