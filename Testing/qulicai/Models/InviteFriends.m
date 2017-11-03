//
//  InviteFriends.m
//  qulicai
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "InviteFriends.h"

@implementation InviteFriends

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"friends" : @"data",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"friends" : @"Friends"
             };
}

@end
