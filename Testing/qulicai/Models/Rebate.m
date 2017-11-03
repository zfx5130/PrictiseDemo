//
//  Rebate.m
//  qulicai
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "Rebate.h"

@implementation Rebate

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"rebate" : @"data.rebate"
             };
}

@end
