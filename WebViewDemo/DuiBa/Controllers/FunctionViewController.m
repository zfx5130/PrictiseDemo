//
//  FunctionViewController.m
//  DuiBa
//
//  Created by dev on 6/6/16.
//  Copyright © 2016 Caiziyi coporation. All rights reserved.
//

#import "FunctionViewController.h"
#import "DBViewController.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

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
    [[DBViewController alloc] initWithTitle:@"功能"
                                  URLString:@"http://home.duiba.com.cn/ios_gongneng.html"
                    navigationButtonsHidden:YES];
    [self.navigationController pushViewController:webView
                                         animated:NO];
    
}
@end
