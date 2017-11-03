//
//  QRRequestLockAction.m
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestLockAction.h"

@implementation QRRequestLockAction

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/active/lockActive";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId,
             @"token" : self.token,
             @"amount" : self.amount,
             @"address" : self.address,
             @"name" : self.name,
             @"phone" : self.phone
             };
}

@end
