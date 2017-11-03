//
//  AppDelegate+AppService.m
//  qulicai
//
//  Created by admin on 2017/10/10.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "QRNetworkHelper.h"
#import <Bugtags/Bugtags.h>
#import <YTKNetworkConfig.h>
#import <YTKNetworkAgent.h>
#import "QRRequestHeader.h"
#import "WeChatAPIManager.h"
#import "TencentShareHelper.h"
#import <UMMobClick/MobClick.h>

@implementation AppDelegate (AppService)

#pragma mark - 网络监听

- (void)initService {
    AddNotificationCenter(netWorkStateChange:, KNotificationNetWorkStateChange);
}

- (void)monitorNetworkStatus {
    
    [QRNetworkHelper networkStatusWithBlock:^(QRNetworkStatusType networkStatus) {
        switch (networkStatus) {
                // 未知网络
            case QRNetworkStatusUnknown:
                NSLog(@"网络环境：未知网络");
                // 无网络
            case QRNetworkStatusNotReachable:
                NSLog(@"网络环境：无网络");
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationNetWorkStateChange object:@NO];
                break;
                // 手机网络
            case QRNetworkStatusReachableViaWWAN:
                NSLog(@"网络环境：手机自带网络");
                // 无线网络
                [self showSuccessProgressHud:@"已切换蜂窝网络"];
                break;
            case QRNetworkStatusReachableViaWiFi:
                NSLog(@"网络环境：WiFi");
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationNetWorkStateChange object:@YES];
                break;
        }
        
    }];
}

- (void)netWorkStateChange:(NSNotification *)notification {
    BOOL isNetWork = [notification.object boolValue];
    if (isNetWork) {
        NSLog(@"网络正常");
        [self showSuccessProgressHud:@"已连接 WIFI"];
    } else {
        [self showErrorProgressHud:@"无可用网络"];
    }
}

- (void)showErrorProgressHud:(NSString *)title {
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD showErrorWithStatus:title];
    [SVProgressHUD dismissWithDelay:0.6];
}

- (void)showSuccessProgressHud:(NSString *)title {
    [SVProgressHUD setForegroundColor:[UIColor appDefaultColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"success_image"]];
    [SVProgressHUD showSuccessWithStatus:title];
    [SVProgressHUD dismissWithDelay:0.6];
}

#pragma mark - BugTags

- (void)setupBugTags {
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingUserSteps = YES;//测
    [Bugtags startWithAppKey:BUGTAGS_KEY
             invocationEvent:BTGInvocationEventShake
                     options:options];
}

#pragma mark - setNavBarAppearence

- (void)setNavBarAppearence {
    // 设置导航栏默认的背景颜色
    //[UIColor wr_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    // [UIColor wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    // [UIColor wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [UIColor wr_setDefaultStatusBarStyle:UIStatusBarStyleDefault];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [UIColor wr_setDefaultNavBarShadowImageHidden:YES];
}

#pragma mark - ConfifNetwork

- (void)configQRNetwork {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = kBaseUrl;
}

#pragma mark - Share

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url
                delegate:[WeChatAPIManager manager]];
    [QQApiInterface handleOpenURL:url
                         delegate:[TencentShareHelper manager]];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

    [WXApi handleOpenURL:url
                delegate:[WeChatAPIManager manager]];
    [QQApiInterface handleOpenURL:url
                         delegate:[TencentShareHelper manager]];
    return YES;
}

#pragma mark - Ument

- (void)addUmeng {
    UMConfigInstance.appKey = QR_UMENT_TEST;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
}

@end
