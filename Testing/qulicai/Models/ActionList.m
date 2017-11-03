//
//  ActionList.m
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ActionList.h"

@implementation ActionList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"actions" : @"data",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"actions" : @"Actions"
             };
}

@end
