//
//  QRRequestGetLLKey.m
//  qulicai
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetLLKey.h"

@implementation QRRequestGetLLKey

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"service";
}

- (id)requestArgument {
    return @{
             @"head" : @{ @"serviceName" : @"getLLKey" },
             @"body" : @{ @"sign" : self.sign}
             };
}

@end
