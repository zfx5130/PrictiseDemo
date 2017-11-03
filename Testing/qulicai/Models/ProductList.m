//
//  ProductList.m
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ProductList.h"

@implementation ProductList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"products" : @"data.rows"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"products" : @"Product"
             };
}

@end
