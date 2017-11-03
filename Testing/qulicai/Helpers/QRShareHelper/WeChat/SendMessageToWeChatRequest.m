//
//  SendMessageToWeChatReqeust.m
//  zhixingche
//
//  Created by dev on 15/10/9.
//  Copyright © 2015年 yunzao. All rights reserved.
//

#import "SendMessageToWeChatRequest.h"

@implementation SendMessageToWeChatRequest

+ (SendMessageToWeChatRequest *)requestWithText:(NSString *)text
                                 OrMediaMessage:(WXMediaMessage *)message
                                          bText:(BOOL)bText
                                        InScene:(enum WXScene)scene {
    SendMessageToWeChatRequest *req = [[SendMessageToWeChatRequest alloc] init];
    req.bText = bText;
    req.scene = scene;
    if (bText)
        req.text = text;
    else
        req.message = message;
    return req;
}

@end
