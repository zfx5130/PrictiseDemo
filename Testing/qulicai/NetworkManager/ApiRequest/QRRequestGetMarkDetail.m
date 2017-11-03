//
//  QRRequestGetMarkDetail.m
//  qulicai
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetMarkDetail.h"

@implementation QRRequestGetMarkDetail

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/product/markInfo";
}

- (id)requestArgument {
    return @{
             @"markId" : self.markId
             };
}

@end
