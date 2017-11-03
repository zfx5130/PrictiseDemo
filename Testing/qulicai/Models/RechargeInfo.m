//
//  RechargeInfo.m
//  qulicai
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "RechargeInfo.h"

@implementation RechargeInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"code" : @"head.responseCode",
             @"desc" : @"head.responseDescription",
             @"statusType" : @"head.status"
             };
}

@end
