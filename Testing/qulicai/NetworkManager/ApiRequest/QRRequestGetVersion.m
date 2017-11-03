//
//  QRRequestGetVersion.m
//  qulicai
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetVersion.h"

@implementation QRRequestGetVersion

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/config/version";
}

- (id)requestArgument {
    
    return @{
             @"name" : @"ios"
             };
}


@end
