//
//  AppDelegate.m
//  DuiBa
//
//  Created by czy on 16/3/21.
//  Copyright © 2016年 Caiziyi coporation. All rights reserved.
//

#import "AppDelegate.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   // [self setupGloalUI];
    [NSThread sleepForTimeInterval:2.0];
    [_window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kNetworkChangeNotification object:nil];
    return YES;
}

//网络状态改变
- (void)networkStateChange
{
    self.conn = [Reachability reachabilityForInternetConnection];
    self.status = [self.conn currentReachabilityStatus];
    [self netWithStaus:self.status];
}

- (void)netWithStaus:(NetworkStatus)status {
    if (status == NotReachable) {
        [self netWorkText:@"没有可用网络,请检查网络设置!"];
    } else if (status == ReachableViaWiFi) {
        
    } else if (status == ReachableViaWWAN) {
        [self netWorkText:@"当前非wifi连接!"];
    }
    
}


- (void)netWorkText:(NSString *)text {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:text
                                                  delegate:self
                                         cancelButtonTitle:@"知道了"
                                         otherButtonTitles:nil];
    [alert show];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

#pragma mark - Private

- (void)setupGloalUI {
    UIImage *indicatorImage = [UIImage imageNamed:@"back_indicator"];
    [[UINavigationBar appearance] setBackIndicatorImage:indicatorImage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:indicatorImage];
    UIColor *color =
    [UIColor colorWithRed: 125 / 255.0  green:230 / 255.0f blue:225 / 255.0 alpha:1.0];
    NSDictionary *barButtonTextAttributes = @{
                                              NSForegroundColorAttributeName : color,
                                              NSFontAttributeName : [UIFont systemFontOfSize:14.0f]
                                              };
    [[UIBarButtonItem appearance] setTitleTextAttributes:barButtonTextAttributes
                                                forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(- MAXFLOAT, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
