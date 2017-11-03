//
//  QRRequestQrongBaoSecondSign.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestQrongBaoSecondSign.h"

@implementation QRRequestQrongBaoSecondSign

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"pay/bindCardResult";
}

- (NSString *)baseUrl {
    return QR_PAY_URL;
}

- (id)requestArgument {
    NSLog(@"储蓄卡签约接口-第二次签约::baseUrl:::::%@",self.baseUrl);
    return @{
             @"userName" : self.userName,
             @"appType" : @(self.appType),
             @"payType" : @(self.payType),
             @"userId" : self.userId,
             @"totalFee" : self.totalFee,
             @"bindId" : self.bindId
             };
}

@end
