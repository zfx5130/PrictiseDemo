//
//  ContractList.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ContractList.h"

@implementation ContractList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"bodys" : @"data.rows",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"bodys" : @"Contract"
             };
}

@end
