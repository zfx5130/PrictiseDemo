//
//  QRRequestLogin.m
//  qulicai
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestLogin.h"

@implementation QRRequestLogin

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/login";
}

- (id)requestArgument {
    return @{
             @"mobilePhone" : self.mobilePhone,
             @"code" : self.password,
             @"type" : @(self.loginType),
             @"unitType" : @"iOS"
             };
}

@end
