//
//  WeChatAPIManager.m
//  zhixingche
//
//  Created by satgi on 9/23/15.
//  Copyright © 2015 yunzao. All rights reserved.
//

#import "WeChatAPIManager.h"

@interface WeChatAPIManager()

@end

@implementation WeChatAPIManager

+ (instancetype)manager {
    static WeChatAPIManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (void)dealloc {
    _delegate = nil;
}

#pragma mark - WXApiDelegate

- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidReceiveGetMessageRequest:)]) {
            [self.delegate managerDidReceiveGetMessageRequest:(GetMessageFromWXReq *)req];
        }
    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidReceiveShowMessageRequest:)]) {
            [self.delegate managerDidReceiveShowMessageRequest:(ShowMessageFromWXReq *)req];
        }
    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidReceiveLaunchMessageRequest:)]) {
            [self.delegate managerDidReceiveLaunchMessageRequest:(LaunchFromWXReq *)req];
        }
    }
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidReceiveMessageResponse:)]) {
            [self.delegate managerDidReceiveMessageResponse:(SendMessageToWXResp *)resp];
        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidReceiveAuthMessageResponse:)]) {
            [self.delegate managerDidReceiveAuthMessageResponse:(SendAuthResp *)resp];
        }
    }
}

@end
