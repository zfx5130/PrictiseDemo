//
//  ProductPack.m
//  qulicai
//
//  Created by 赵富星 on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ProductPack.h"

@implementation ProductPack

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"productPackId" : @"id",
             @"cardId" : @"appUserTemp.cardId",
             @"mobilePhone" : @"appUserTemp.mobilePhone",
             @"name" : @"appUserTemp.name",
             @"realName" : @"appUserTemp.realName",
             @"userId" : @"appUserTemp.userId",
             @"appBanks" : @"appUserTemp.appBanks",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"appBanks" : @"Bank"
             };
}

@end
