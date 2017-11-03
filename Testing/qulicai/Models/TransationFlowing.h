//
//  TransationFlowing.h
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

typedef enum : NSUInteger {
    TrancationFlowingTypeUserdCharged = 0, //充值
    TrancationFlowingTypeCharge = 1, //用户充值
    TrancationFlowingTypePickup = 2, //用户提现
    TrancationFlowingTypeBackMoney = 3, //用户提现失败，退款
    TrancationFlowingTypeRegularInterest = 10, //定期标利息结算
    TrancationFlowingTypePrincipalInterest = 11, //定期标本金结算
    TrancationFlowingTypeManualBidding = 30, //手动投标
    TrancationFlowingTypeAutomaticBid = 31, //自动投标
    
} TrancationFlowingType;

@interface TransationFlowing : NSObject

@property (copy, nonatomic) NSString *appUserId;

@property (assign, nonatomic) CGFloat money;

@property (assign, nonatomic) TrancationFlowingType type;

@property (copy, nonatomic) NSString *transactionDate;

@property (copy, nonatomic) NSString *stautsName;

@property (copy, nonatomic) NSString *statusTypeString;

@property (assign, nonatomic) CGFloat amount;

@property (copy, nonatomic) NSString *status;

@property (copy, nonatomic) NSString *signalType;

@property (copy, nonatomic) NSString *gmtCreated;


@end
