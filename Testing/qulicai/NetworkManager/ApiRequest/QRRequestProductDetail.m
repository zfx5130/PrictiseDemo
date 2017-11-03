//
//  QRRequestProductDetail.m
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestProductDetail.h"

@implementation QRRequestProductDetail

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/product/productIntroduction";
}

- (id)requestArgument {
    return @{
             @"id" : self.productId
             };
}


@end
