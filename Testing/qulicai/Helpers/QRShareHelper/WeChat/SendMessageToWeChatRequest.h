//
//  SendMessageToWeChatReqeust.h
//  zhixingche
//
//  Created by dev on 15/10/9.
//  Copyright © 2015年 yunzao. All rights reserved.
//

#import "WXApiObject.h"

@interface SendMessageToWeChatRequest : SendMessageToWXReq

+ (SendMessageToWeChatRequest *)requestWithText:(NSString *)text
                                 OrMediaMessage:(WXMediaMessage *)message
                                          bText:(BOOL)bText
                                        InScene:(enum WXScene)scene;
@end
