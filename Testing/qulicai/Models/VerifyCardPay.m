//
//  VerifyCardPay.m
//  qulicai
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "VerifyCardPay.h"

@implementation VerifyCardPay

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"bank_code" : @"data.bank_code",
             @"bank_name" : @"data.bank_name",
             @"result_code" : @"data.result_code",
             @"result_msg" : @"data.result_msg",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             };
}

@end
