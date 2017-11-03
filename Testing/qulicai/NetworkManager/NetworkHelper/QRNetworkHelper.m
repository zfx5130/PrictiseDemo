//
//  QRNetworkHelper.m
//  qulicai
//
//  Created by admin on 2017/10/10.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRNetworkHelper.h"
#import <AFNetworking.h>

@implementation QRNetworkHelper

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(QRNetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(QRNetworkStatusUnknown) : nil;
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(QRNetworkStatusNotReachable) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(QRNetworkStatusReachableViaWWAN) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(QRNetworkStatusReachableViaWiFi) : nil;
                    break;
            }
        }];
    });
}

/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

@end
