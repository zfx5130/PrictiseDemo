//
//  QRRequestGetAuthProductList.m
//  qulicai
//
//  Created by admin on 2017/11/1.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetAuthProductList.h"

@implementation QRRequestGetAuthProductList

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/product/auth/productList";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId,
             @"token" : self.token,
             };
}

@end
