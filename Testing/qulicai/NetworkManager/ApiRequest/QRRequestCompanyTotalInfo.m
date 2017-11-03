//
//  QRRequestCompanyTotalInfo.m
//  qulicai
//
//  Created by admin on 2017/9/25.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestCompanyTotalInfo.h"

@implementation QRRequestCompanyTotalInfo

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/product/accumulative";
}

- (id)requestArgument {
    return @{};
}

@end
