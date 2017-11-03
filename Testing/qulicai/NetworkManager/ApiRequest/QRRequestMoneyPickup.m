//
//  QRRequestMoneyPickup.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestMoneyPickup.h"

@implementation QRRequestMoneyPickup

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/asset/handleWithdraw";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId ,
             @"bankNo" : self.bankNo ,
             @"amount" : @(self.money),
             @"token" : self.token
             };
}


@end
