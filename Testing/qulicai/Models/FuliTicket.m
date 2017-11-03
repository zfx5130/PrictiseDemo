//
//  FuliTicket.m
//  qulicai
//
//  Created by admin on 2017/11/1.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "FuliTicket.h"

@implementation FuliTicket

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"tickets" : @"data",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"tickets" : @"Ticket"
             };
}

@end
