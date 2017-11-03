//
//  QRrequestVerifyTrasPwd.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRrequestVerifyTrasPwd.h"

@implementation QRrequestVerifyTrasPwd

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/verifyTransactionPwd";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId ,
             @"transactionPwd" : self.transactionPwd,
             @"token" : self.token
             };
}


@end
