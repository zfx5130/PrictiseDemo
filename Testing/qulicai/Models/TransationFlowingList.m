//
//  TransationFlowingList.m
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "TransationFlowingList.h"

@implementation TransationFlowingList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"flowings" : @"data.rows",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"flowings" : @"TransationFlowing"
             };
}

@end
