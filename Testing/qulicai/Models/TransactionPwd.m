//
//  TransactionPwd.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "TransactionPwd.h"

@implementation TransactionPwd

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"verify" : @"data.verify",
             @"token" : @"token"
             };
}

@end
