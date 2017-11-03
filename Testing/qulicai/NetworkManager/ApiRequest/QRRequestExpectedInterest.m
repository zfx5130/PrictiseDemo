//
//  QRRequestExpectedInterest.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestExpectedInterest.h"

@implementation QRRequestExpectedInterest

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/asset/expectedRevenue";
}

- (id)requestArgument {
    return @{
              @"userId" : self.userId,
              @"token" : self.token
             };
}

@end
