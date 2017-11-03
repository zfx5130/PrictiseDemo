//
//  QRRequestSetingTranPassword.m
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestSetingTranPassword.h"

@implementation QRRequestSetingTranPassword

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/setTransactionPwd";
}

- (id)requestArgument {
    return @{
          @"userId" : self.userId ,
          @"transactionPwd" : self.transactionPwd,
          @"token" : self.token
             };
}

@end
