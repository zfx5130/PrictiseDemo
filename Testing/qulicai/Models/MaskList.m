//
//  MaskList.m
//  qulicai
//
//  Created by 赵富星 on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MaskList.h"

@implementation MaskList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"masks" : @"data.rows"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"masks" : @"ProductMask"
             };
}

@end
