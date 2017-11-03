//
//  ProductDetail.m
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ProductDetail.h"

@implementation ProductDetail

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"activeRate" : @"data.activeRate",
             @"yearRate" : @"data.yearRate",
             @"lowestAmount" : @"data.lowestAmount",
             @"ableAmount" : @"data.ableAmount"
             };
}

@end
