//
//  ExpectedTotal.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ExpectedTotal.h"

@implementation ExpectedTotal

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"revenue" : @"data.revenue",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token"
             };
}

@end
