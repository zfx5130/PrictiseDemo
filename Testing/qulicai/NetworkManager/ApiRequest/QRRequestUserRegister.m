//
//  QRRequestUserRegister.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestUserRegister.h"

@implementation QRRequestUserRegister

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/phoneRegister";
}

- (id)requestArgument {
    return @{
             @"mobilePhone" : self.mobilePhone,
             @"pwd" : self.password,
             @"code" : self.code
             };
}


@end
