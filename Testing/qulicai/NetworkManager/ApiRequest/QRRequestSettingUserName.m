//
//  QRRequestSettingUserName.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestSettingUserName.h"

@implementation QRRequestSettingUserName

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/setNickName";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId ,
             @"nickName" : self.nickName,
             @"token" : self.token
             };
}


@end
