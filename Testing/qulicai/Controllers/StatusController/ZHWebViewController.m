//
//  ZHWebViewController.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ZHWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZHWebViewController ()
<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *zhWebView;

@property (strong, nonatomic) JSContext *context;

@property (assign, nonatomic) BOOL isFirstLoading;

@end

@implementation ZHWebViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"招商权限认证";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    
    NSString *firstStr = @"<style>.box{margin-top:150px;width:100%;text-align:center;height:100px}h1{font-size:16px}.button_p2p{border:none;background-color:#F2592F;color:#ffffff;width:150px;height:30px;line-height:30px;border-radius:20px;margin-top:30px;padding:0}</style><div class='box'><h1>请点击按钮进行招商银行卡密码验证</h1>";
    NSString *lastStr = @"</div>";
    [self.zhWebView loadHTMLString:[NSString stringWithFormat:@"%@%@%@",firstStr,self.htmlText,lastStr]
                           baseURL:nil];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    //判断是否是单击
    NSLog(@"::-::--:::%@",request.URL.absoluteString);
    if ([request.URL.absoluteString isEqual:@"iosqulicai://com.qurong.qulicai.www"]) {
        if (self.statusBlock && !self.isFirstLoading) {
            self.isFirstLoading = YES;
            self.statusBlock(YES);
            [self dismissViewControllerAnimated:NO
                                     completion:nil];
        }
    }
    return YES;
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self dismissViewControllerAnimated:NO
                             completion:nil];
}

@end
