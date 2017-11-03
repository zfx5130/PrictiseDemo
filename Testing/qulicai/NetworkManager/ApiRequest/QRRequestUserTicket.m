//
//  QRRequestUserTicket.m
//  qulicai
//
//  Created by admin on 2017/11/1.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestUserTicket.h"

@implementation QRRequestUserTicket

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/ticket/userTicket";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId,
             @"status" : self.status,
             @"token" : self.token
             };
}

@end
