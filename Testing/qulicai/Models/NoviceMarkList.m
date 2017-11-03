//
//  NoviceMarkList.m
//  qulicai
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "NoviceMarkList.h"

@implementation NoviceMarkList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"products" : @"data"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"products" : @"Product"
             };
}

@end
