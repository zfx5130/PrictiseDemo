//
//  QRRequestGetUserInfo.m
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetUserInfo.h"

@implementation QRRequestGetUserInfo

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/appUserInfo";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId,
             @"token" : self.token
             };
}

@end
