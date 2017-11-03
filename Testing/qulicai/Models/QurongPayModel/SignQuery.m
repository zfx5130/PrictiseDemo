//
//  SignQuery.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "SignQuery.h"

@implementation SignQuery

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"result_code" : @"data.resultCode",
             @"result_msg" : @"data.resultMsg",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             };
}

@end
