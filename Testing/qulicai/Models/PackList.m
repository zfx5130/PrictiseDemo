//
//  PackList.m
//  qulicai
//
//  Created by 赵富星 on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "PackList.h"

@implementation PackList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"total" : @"body.total",
             @"packs" : @"body.rows",
             @"code" : @"head.responseCode",
             @"desc" : @"head.responseDescription",
             @"statusType" : @"head.status"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"packs" : @"ProductPack"
             };
}

@end
