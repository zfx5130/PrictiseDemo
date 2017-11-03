//
//  QRRequestRongBaoResendSMS.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestRongBaoResendSMS.h"

@implementation QRRequestRongBaoResendSMS

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"pay/reSendSmsResult";
}

- (NSString *)baseUrl {
    return QR_PAY_URL;
}

- (id)requestArgument {
    NSLog(@"重新发送验证码接口::baseUrl:::::%@",self.baseUrl);
    return @{
             @"userName" : self.userName,
             @"appType" : @(self.appType),
             @"payType" : @(self.payType),
             @"userId" : self.userId,
             @"orderNo" : self.orderNo,
             };
}

@end
