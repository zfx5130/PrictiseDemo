//
//  Bank.m
//  qulicai
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "Bank.h"

@implementation Bank

MJExtensionCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"bankId" : @"id",
             @"bankStatusType" : @"status"
             };
}

@end
