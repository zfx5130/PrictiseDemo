//
//  InviteCount.m
//  qulicai
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "InviteCount.h"

@implementation InviteCount

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"inviteCount" : @"data.inviteCount"
             };
}

@end
