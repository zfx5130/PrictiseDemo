//
//  QRRequestBackMoneyDetail.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestBackMoneyDetail.h"

@implementation QRRequestBackMoneyDetail

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"service";
}

- (id)requestArgument {
    return @{
             @"head" : @{ @"serviceName" : @"getRepaymentPlan" },
             @"body" : @{ @"packId" : self.packId}
             };
}


@end
