//
//  QRRequestUserAvatar.m
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestUserAvatar.h"

@implementation QRRequestUserAvatar

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/modifyHeadPortrait";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId ,
             @"headPortrait" : self.headPortrait,
             @"token" : self.token
             };
}


@end
