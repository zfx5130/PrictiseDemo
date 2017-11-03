//
//  WeChatAPIManager.h
//  zhixingche
//
//  Created by satgi on 9/23/15.
//  Copyright © 2015 yunzao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WXApi.h"

@protocol WeChatAPIManagerDelegate <NSObject>

@optional

// Requests
- (void)managerDidReceiveGetMessageRequest:(GetMessageFromWXReq *)request;

- (void)managerDidReceiveShowMessageRequest:(ShowMessageFromWXReq *)request;

- (void)managerDidReceiveLaunchMessageRequest:(LaunchFromWXReq *)request;

// Responses
- (void)managerDidReceiveAuthMessageResponse:(SendAuthResp *)response;

- (void)managerDidReceiveMessageResponse:(SendMessageToWXResp *)response;

@end

@interface WeChatAPIManager : NSObject
<WXApiDelegate>

@property (weak, nonatomic) id<WeChatAPIManagerDelegate> delegate;

+ (instancetype)manager;

@end
