//
//  QRReuqestZhaoShangCard.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRReuqestZhaoShangCard.h"

@implementation QRReuqestZhaoShangCard

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"pay/kamiAuthorization";
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
             @"bindId" : self.bindId,
             @"orderNo" : self.orderNo,
             @"return_url" : self.return_url
             };
}

@end
