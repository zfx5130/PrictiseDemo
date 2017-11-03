//
//  TransationFlowing.m
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "TransationFlowing.h"

@implementation TransationFlowing

- (NSString *)stautsName {
    TrancationFlowingType type = self.type;
    switch (type) {
        case TrancationFlowingTypeUserdCharged: {
            return @"用户充值";
        }
            break;
        case TrancationFlowingTypeCharge: {
            return self.status.length == 0 ? @"用户充值" : @"用户提现";
        }
            break;
        case TrancationFlowingTypePickup: {
            return @"用户提现";
        }
            break;
        case TrancationFlowingTypeBackMoney: {
            return @"用户提现失败退款";
        }
            break;
        case TrancationFlowingTypeRegularInterest: {
            return @"定期标利息结算";
        }
            break;
        case TrancationFlowingTypePrincipalInterest: {
            return @"定期标本金结算";
        }
            break;
        case TrancationFlowingTypeManualBidding: {
            return @"手动投标";
        }
            break;
        case TrancationFlowingTypeAutomaticBid: {
            return @"自动投标";
        }
            break;
        default:
            break;
    }
    return @"用户充值";
}

- (NSString *)statusTypeString {
    NSString *name = @"";
    if (self.type == 0 && [self.status isEqualToString:@"0"]) {
        name = @"正在充值中";
    } else if (self.type == 0 && [self.status isEqualToString:@"1"]) {
        name = @"";
    } else if (self.type == 0 && [self.status isEqualToString:@"2"]) {
        name = @"充值失败";
    } else if (self.type == 1 && [self.status isEqualToString:@"0"]) {
        name = @"提现处理中";
    } else if (self.type == 1 && [self.status isEqualToString:@"1"]) {
        name = @"";
    } else if (self.type == 1 && [self.status isEqualToString:@"2"]) {
        name = @"提现失败";
    }
    return name;
}

- (NSString *)signalType {
    TrancationFlowingType type = self.type;
    switch (type) {
        case TrancationFlowingTypeUserdCharged: {
            return @"+";
        }
            break;
        case TrancationFlowingTypeCharge: {
            NSString *signStr = @"";
            if (!self.status.length) {
                signStr = @"+";
            } else {
                if ([self.status isEqualToString:@"1"]) {
                    signStr = @"-";
                }
            }
            return signStr;
        }
            break;
        case TrancationFlowingTypePickup: {
            return @"-";
        }
            break;
        case TrancationFlowingTypeBackMoney: {
            return @"";
        }
            break;
        case TrancationFlowingTypeRegularInterest: {
            return @"";
        }
            break;
        case TrancationFlowingTypePrincipalInterest: {
            return @"";
        }
            break;
        case TrancationFlowingTypeManualBidding: {
            return @"";
        }
            break;
        case TrancationFlowingTypeAutomaticBid: {
            return @"";
        }
            break;
        default:
            break;
    }
    return @"";
}

@end
