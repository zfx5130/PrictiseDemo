//
//  QRRequestNoviceMark.m
//  qulicai
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestNoviceMark.h"

@implementation QRRequestNoviceMark

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/product/noviceMark";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId
             };
}

@end
