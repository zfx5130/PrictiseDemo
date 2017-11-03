//
//  QRShareHelper.m
//  qulicai
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <TencentOpenAPI/TencentOAuth.h>
#import "WeChatShareRequestHandler.h"
#import "Tencent/TencentShareHelper.h"
#import "QRShareHelper.h"
#import "WXZTipView.h"
#import "WXApi.h"
#import "User.h"
#import "UserUtil.h"

@implementation QRShareHelper

- (instancetype)init {
    self = [super init];
    if (self) {
        //init
    }
    return self;
}

#pragma mark - Public

- (void)qr_shareWithType:(QRShareType)shareType {
    switch (shareType) {
            case QRShareTypeWeChat: {
                [self qr_WechatShare];
            }
            break;
            case QRShareTypeWeChatMoments: {
                [self qr_WeChatMomentsShare];
            }
            break;
            case QRShareTypeQQ: {
                [self qr_QQShare];
            }
            break;
            case QRShareTypeQQZone: {
                [self qr_QQZoneShare];
            }
            break;
        default:
            break;
    }
}

#pragma mark - is install

- (BOOL)isWeChatInstralled {
    BOOL isInstalled = [WXApi isWXAppInstalled];
    if (!isInstalled) {
        [WXZTipView showCenterWithText:@"请先安装微信客户端"];
    }
    return isInstalled;
}

- (BOOL)isQQInstalled {
    BOOL inInstalled = [TencentOAuth iphoneQQInstalled];
    if (!inInstalled) {
        [WXZTipView showCenterWithText:@"请先安装QQ客户端"];
    }
    return inInstalled;
}

- (UIImage *)sharingImage {
    return [UIImage imageNamed:@"about_logo_image"];
}

- (void)qr_WechatShare {
    if (![self isWeChatInstralled]) {
        return;
    }
    NSLog(@":微信分享:::");
    NSString *urlString = [NSString stringWithFormat:@"%@%@",QR_SHARE_URL,[UserUtil currentUser].userId];
    NSString *url = [NSString stringWithFormat:@"%@&type=1",urlString];
    [WeChatShareRequestHandler sendLinkURL:url
                                   TagName:nil
                                     Title:QR_SHARE_TITLE
                               Description:QR_SHATE_DESC
                                ThumbImage:[UIImage imageNamed:@"about_logo_image"]
                                   InScene:WXSceneSession];
}

- (void)qr_WeChatMomentsShare {
    if (![self isWeChatInstralled]) {
        return;
    }
    NSLog(@":微信朋友圈分享:::");
    NSString *urlString = [NSString stringWithFormat:@"%@%@",QR_SHARE_URL,[UserUtil currentUser].userId];
    NSString *url = [NSString stringWithFormat:@"%@&type=1",urlString];
    [WeChatShareRequestHandler sendLinkURL:url
                                   TagName:nil
                                     Title:QR_SHARE_TITLE
                               Description:QR_SHATE_DESC
                                ThumbImage:[UIImage imageNamed:@"about_logo_image"]
                                   InScene:WXSceneTimeline];
}

- (void)qr_QQShare {
    if (![self isQQInstalled]) {
        return;
    }
    NSLog(@":qq好友分享:::");
    NSString *urlString = [NSString stringWithFormat:@"%@%@",QR_SHARE_URL,[UserUtil currentUser].userId];
    NSString *url = [NSString stringWithFormat:@"%@&type=1",urlString];
    [[TencentShareHelper manager] shareNewsWithURL:[NSURL URLWithString:url]
                                             title:QR_SHARE_TITLE
                                       description:QR_SHATE_DESC
                                  previewImageData:UIImageJPEGRepresentation([self sharingImage], 0.5f)
                                        shareSence:TencentShareSenceQQ];
}

- (void)qr_QQZoneShare {
    if (![self isQQInstalled]) {
        return;
    }    
    NSLog(@":qq空间分享:::");
    NSString *urlString = [NSString stringWithFormat:@"%@%@",QR_SHARE_URL,[UserUtil currentUser].userId];
    NSString *url = [NSString stringWithFormat:@"%@&type=1",urlString];
    [[TencentShareHelper manager] shareNewsWithURL:[NSURL URLWithString:url]
                                             title:QR_SHARE_TITLE
                                       description:QR_SHATE_DESC
                                  previewImageData:UIImageJPEGRepresentation([self sharingImage], 0.5f)
                                        shareSence:TencentShareSenceQzone];
}

@end
