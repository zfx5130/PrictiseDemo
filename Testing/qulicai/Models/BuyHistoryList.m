//
//  BuyHistoryList.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BuyHistoryList.h"

@implementation BuyHistoryList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"historyList" : @"data.rows"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"historyList" : @"BuyHistory"
             };
}

@end
