//
//  QRRequestModifyTransPassword.m
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestModifyTransPassword.h"

@implementation QRRequestModifyTransPassword

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/modifyTransactionPwd";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId ,
             @"pwd" : self.transactionPwd,
             @"newPwd" : self.lastestTransactionPwd,
             @"token" : self.token
             };
}


@end
