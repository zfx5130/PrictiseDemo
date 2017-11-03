//
//  QRRequestResetTransPassword.m
//  qulicai
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestResetTransPassword.h"

@implementation QRRequestResetTransPassword

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/resetTransactionPwd";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId,
             @"newPwd" : self.transactionPwd,
             @"token" : self.token,
             @"code" : self.code
             };
}

@end
