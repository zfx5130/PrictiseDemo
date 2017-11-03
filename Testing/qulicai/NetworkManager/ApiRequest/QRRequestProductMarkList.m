//
//  QRRequestProductMarkList.m
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestProductMarkList.h"

@implementation QRRequestProductMarkList

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/product/productBorrower";
}

- (id)requestArgument {
    return @{
             @"id" : self.productId
             };
}


@end
