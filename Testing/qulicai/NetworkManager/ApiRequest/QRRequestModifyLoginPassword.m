//
//  QRRequestModifyLoginPassword.m
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestModifyLoginPassword.h"

@implementation QRRequestModifyLoginPassword

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/modifyPwd";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId ,
             @"pwd" : self.loginPwd,
             @"newPwd" : self.lastestPwd,
             @"token" : self.token
             };
}


@end
