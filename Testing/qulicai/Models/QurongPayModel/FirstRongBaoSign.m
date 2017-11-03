//
//  FirstRongBaoSign.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "FirstRongBaoSign.h"

@implementation FirstRongBaoSign

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"bank_code" : @"data.bank_code",
             @"bank_name" : @"data.bank_name",
             @"result_code" : @"data.result_code",
             @"result_msg" : @"data.result_msg",
             @"order_no" : @"data.order_no",
             @"bind_id" : @"data.bind_id",
             @"certificate" : @"data.certificate"
             };
}


@end
