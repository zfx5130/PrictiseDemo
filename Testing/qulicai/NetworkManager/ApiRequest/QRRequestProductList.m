//
//  QRRequestProductList.m
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestProductList.h"

@implementation QRRequestProductList

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/product/productList";
}

- (id)requestArgument {
    return @{};
}

@end
