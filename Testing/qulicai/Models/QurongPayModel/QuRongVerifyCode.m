//
//  QuRongVerifyCode.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QuRongVerifyCode.h"

@implementation QuRongVerifyCode

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"phone" : @"data.phone",
             @"order_no" : @"data.order_no",
             @"result_code" : @"data.result_code",
             @"result_msg" : @"data.result_msg",
             };
}

@end
