//
//  QRRequestRongBaoPayConfig.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestRongBaoPayConfig.h"

@implementation QRRequestRongBaoPayConfig

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"pay/confirmSubmitpay";
}

- (NSString *)baseUrl {
    return QR_PAY_URL;
}

- (id)requestArgument {
    NSLog(@"支付确认接口::baseUrl:::::%@",self.baseUrl);
    return @{
             @"userName" : self.userName,
             @"appType" : @(self.appType),
             @"payType" : @(self.payType),
             @"userId" : self.userId,
             @"orderNo" : self.orderNo,
             @"checkCode" : self.checkCode,
             @"totalFee" : self.totalFee
             };
}

@end
