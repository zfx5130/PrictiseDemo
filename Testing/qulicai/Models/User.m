//
//  Login.m
//  qulicai
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "User.h"

@implementation User 

MJExtensionCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"appBanks" : @"data.banks",
             @"createTime" : @"data.userInfo.createTime",
             @"accumulatedIncome" : @"data.userInfo.accumulatedIncome",
             @"dailyEarnings" : @"data.userInfo.dailyEarnings",
             @"currentMoney" : @"data.userInfo.currentMoney",
             @"regularMoney" : @"data.userInfo.regularMoney",
             @"freezeMoney" : @"data.userInfo.freezeMoney",
             @"payPwd" : @"data.userInfo.payPwd",
             @"availableMoney" : @"data.userInfo.availableMoney",
             @"totalMoney" : @"data.userInfo.totalMoney",
             @"authStatusType" : @"data.userInfo.authentication",
             @"addTime" : @"data.userInfo.addTime",
             @"loginStatus" : @"data.userInfo.loginStatus",
             @"payStatus" : @"data.userInfo.payStatus",
             @"version" : @"data.userInfo.version",
             @"mobilePhone" : @"data.userInfo.mobilePhone",
             @"realName" : @"data.userInfo.realName",
             @"loginFailCounts" : @"data.userInfo.loginFailCounts",
             @"nickName" : @"data.userInfo.nickName",
             @"userId": @"data.userInfo.userId",
             @"cardId" : @"data.userInfo.cardId",
             @"headPortrait" : @"data.userInfo.headPortrait",
             @"unusedCount" : @"data.userInfo.unusedCount",
             @"totalFinancialGold" : @"data.userInfo.totalFinancialGold",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"appBanks" : @"Bank"
             };
}

- (NSString *)description {
    return [NSString stringWithFormat:@"head:::%@::::name::%@::phone:::%@:password:::%@:totalMoney::::%@", [super description], self.nickName, self.mobilePhone, self.realName, @(self.totalMoney)];
}

@end

