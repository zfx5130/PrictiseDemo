//
//  MarkDetailInfo.m
//  qulicai
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MarkDetailInfo.h"

@implementation MarkDetailInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"markId" : @"data.markId",
             @"age" : @"data.age",
             @"amount" : @"data.amount",
             @"allloanTimes" : @"data.allloanTimes",
             @"apr" : @"data.apr",
             @"bankCard" : @"data.bankCard",
             @"borrowId" : @"data.borrowId",
             @"contractNo" : @"data.contractNo",
             @"insertTime" : @"data.insertTime",
             @"isRefuse" : @"data.isRefuse",
             @"nomarlTimes" : @"data.nomarlTimes",
             @"outoftimeTimes" : @"data.outoftimeTimes",
             @"packId" : @"data.packId",
             @"peroid" : @"data.peroid",
             @"repaymentUserName" : @"data.repaymentUserName",
             @"sex" : @"data.sex",
             @"soldOutTime" : @"data.soldOutTime",
             @"source" : @"data.source",
             @"sourceName" : @"data.sourceName",
             @"status" : @"data.status",
             @"userCardId" : @"data.userCardId",
             @"userId" : @"data.userId",
             @"userMobilePhone" : @"data.userMobilePhone",
             @"userName" : @"data.userName",
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token"
             };
}

@end
