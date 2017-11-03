//
//  QRRequestFirstPaySign.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestFirstPaySign.h"

@implementation QRRequestFirstPaySign

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"pay/debitResult";
}

- (NSString *)baseUrl {
    return QR_PAY_URL;
}

- (id)requestArgument {
    NSLog(@"储蓄卡签约接口-第一次签约::baseUrl:::::%@",self.baseUrl);
    return @{
             @"cardNo" : self.cardNo,
             @"userName" : self.userName,
             @"appType" : @(self.appType),
             @"payType" : @(self.payType),
             @"userId" : self.userId,
             @"owner" : self.owner,
             @"certNo" : self.certNo,
             @"phone" : self.phone,
             @"totalFee" : self.totalFee
             };
}


@end
