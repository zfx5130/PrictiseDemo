//
//  QRRequestLLPayBinQuery.m
//  qulicai
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestLLPayBinQuery.h"

@implementation QRRequestLLPayBinQuery

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"pay/queryBankCar";
}

- (NSString *)baseUrl {
    return QR_PAY_URL;
}

- (id)requestArgument {
    NSLog(@"网关查询银行卡信息::baseUrl:::::%@",self.baseUrl);
    return @{
             @"cardNo" : self.cardNo,
             @"userName" : self.userName,
             @"appType" : @(self.appType),
             @"payType" : @(self.payType),
             @"userId" : self.userId
             };
}


@end
