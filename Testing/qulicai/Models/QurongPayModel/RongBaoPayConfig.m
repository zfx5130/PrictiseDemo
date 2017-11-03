//
//  RongBaoPayConfig.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "RongBaoPayConfig.h"

@implementation RongBaoPayConfig

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"bank_card_type" : @"data.bank_card_type",
             @"bank_code" : @"data.bank_code",
             @"bank_name" : @"data.bank_name",
             @"bind_id" : @"data.bind_id",
             @"card_last" : @"data.card_last",
             @"phone" : @"data.phone",
             @"order_no" : @"data.order_no",
             @"result_code" : @"data.result_code",
             @"result_msg" : @"data.result_msg",
             };
}


@end
