//
//  ActionInfo.m
//  qulicai
//
//  Created by admin on 2017/9/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ActionInfo.h"

@implementation ActionInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"address" : @"data.address",
             @"amount" : @"data.amount",
             @"surplusAmount" :  @"data.surplusAmount",
             @"type" : @"data.type",
             @"status" : @"data.status",
             @"gmtCreated" : @"data.gmtCreated"
             };
}


@end
