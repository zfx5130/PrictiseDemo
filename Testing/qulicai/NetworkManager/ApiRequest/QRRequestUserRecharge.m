//
//  QRRequestUserRecharge.m
//  qulicai
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestUserRecharge.h"
#import "NSString+Custom.h"

@implementation QRRequestUserRecharge

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"service";
}

- (id)requestArgument {
    NSString *order = [NSString stringWithFormat:@"CZ%@",[NSString timeStamp]];
    self.no_order = order;
    return @{
             @"head" : @{ @"serviceName" : @"recharge" },
             @"body" : @{ @"userId" : self.userId, @"bankNo" : self.banNo, @"bankName" : self.bankName, @"money" : self.money, @"no_order" : self.no_order }
             };
}


@end
