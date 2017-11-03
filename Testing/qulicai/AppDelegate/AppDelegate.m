//
//  AppDelegate.m
//  qulicai
//
//  Created by admin on 2017/8/2.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+AppService.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configQRNetwork];
    [self setNavBarAppearence];
    [self setupBugTags];
    [self initService];
    [self monitorNetworkStatus];
    [self setupShares];
    [self addUmeng];
    sleep(0.5);
    return YES;
}

#pragma mark - Private

- (void)setupShares {
    [WXApi registerApp:WECHAT_APP_ID];
    TencentOAuth *oAuth = [[TencentOAuth alloc] initWithAppId:QQ_APPID
                                                  andDelegate:nil];
    NSLog(@"oauth::::%@",oAuth);
}

#pragma mark -lifecycle

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
