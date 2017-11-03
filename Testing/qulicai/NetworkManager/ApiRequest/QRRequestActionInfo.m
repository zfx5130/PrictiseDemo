//
//  QRRequestActionInfo.m
//  qulicai
//
//  Created by admin on 2017/9/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestActionInfo.h"

@implementation QRRequestActionInfo

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/active/activeInfo";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId,
             @"token" : self.token,
             };
}

@end
