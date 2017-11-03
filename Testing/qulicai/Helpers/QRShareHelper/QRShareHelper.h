//
//  QRShareHelper.h
//  qulicai
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    QRShareTypeWeChat = 1,   //微信
    QRShareTypeWeChatMoments, //朋友圈
    QRShareTypeQQ, //QQ好友
    QRShareTypeQQZone //QQ空间
} QRShareType;

@interface QRShareHelper : NSObject

//分享
- (void)qr_shareWithType:(QRShareType)shareType;

@end
