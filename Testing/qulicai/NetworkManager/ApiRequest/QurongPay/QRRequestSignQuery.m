//
//  QRRequestSignQuery.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestSignQuery.h"

@implementation QRRequestSignQuery

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"pay/selectKamiresult";
}

- (NSString *)baseUrl {
    return QR_PAY_URL;
}

- (id)requestArgument {
    NSLog(@"查询卡密认证::baseUrl:::::%@",self.baseUrl);
    return @{
             @"appType" : @(self.appType),
             @"payType" : @(self.payType),
             @"userId" : self.userId,
             @"orderNo" : self.orderNo,
             };
}

@end
