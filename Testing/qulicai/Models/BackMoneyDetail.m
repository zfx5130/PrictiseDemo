//
//  BackMoneyDetail.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BackMoneyDetail.h"

@implementation BackMoneyDetail

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"planPeriod" : @"body.planPeriod",
             @"planEndTime" : @"body.planEndTime",
             @"planTotalMoney" : @"body.planTotalMoney",
             @"planTotalRate" : @"body.planTotalRate",
             @"planTotalMoneyAndRate" : @"body.planTotalMoneyAndRate",
             @"planStatus" : @"body.planStatus",
             @"code" : @"head.responseCode",
             @"desc" : @"head.responseDescription",
             @"statusType" : @"head.status",
             };
}




@end
