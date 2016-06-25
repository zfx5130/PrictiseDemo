//
//  JointViewController.m
//  DuiBa
//
//  Created by dev on 6/6/16.
//  Copyright © 2016 Caiziyi coporation. All rights reserved.
//

#import "JointViewController.h"
#import "DBViewController.h"

@interface JointViewController ()

@end

@implementation JointViewController

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
    [[DBViewController alloc] initWithTitle:@"对接"
                                  URLString:@"http://home.duiba.com.cn/ios_duijie.html"
                    navigationButtonsHidden:YES];
    [self.navigationController pushViewController:webView
                                         animated:NO];
}

@end
