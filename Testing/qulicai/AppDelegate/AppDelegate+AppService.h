//
//  AppDelegate+AppService.h
//  qulicai
//
//  Created by admin on 2017/10/10.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

//初始化服务
- (void)initService;

//网络监听
- (void)monitorNetworkStatus;

//统一设置导航条
- (void)setNavBarAppearence;

//设置YYNetwork网络
- (void)configQRNetwork;

//设置bugtags
- (void)setupBugTags;

//添加友盟统计
- (void)addUmeng;

@end
