//
//  QRNetworkHelper.h
//  qulicai
//
//  Created by admin on 2017/10/10.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, QRNetworkStatusType) {
    /** 未知网络*/
    QRNetworkStatusUnknown,
    /** 无网络*/
    QRNetworkStatusNotReachable,
    /** 手机网络*/
    QRNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    QRNetworkStatusReachableViaWiFi
};

typedef void(^QRNetworkStatus)(QRNetworkStatusType status);

@interface QRNetworkHelper : NSObject

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;

/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(QRNetworkStatus)networkStatus;

@end
