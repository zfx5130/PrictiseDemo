//
//  CompanyData.m
//  qulicai
//
//  Created by admin on 2017/9/25.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "CompanyData.h"

@implementation CompanyData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"rate" : @"data.rate",
             @"count" : @"data.count",
             @"sum" : @"data.sum"
             };
}

@end
