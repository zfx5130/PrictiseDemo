//
//  YesterdayIncomeList.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "YesterdayIncomeList.h"

@implementation YesterdayIncomeList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"totalEarning" : @"body.totalEarning",
             @"totalYestEaring" : @"body.totalYestEaring",
             @"settleDate" : @"body.settleDate",
             @"incomes" : @"body.packs",
             @"code" : @"head.responseCode",
             @"desc" : @"head.responseDescription",
             @"statusType" : @"head.status"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"incomes" : @"YesterdayIncome"
             };
}

@end
