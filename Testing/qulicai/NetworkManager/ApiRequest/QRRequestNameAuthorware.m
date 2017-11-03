//
//  QRRequestNameAuthorware.m
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestNameAuthorware.h"

@implementation QRRequestNameAuthorware

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/realNameAuth";
}

- (id)requestArgument {
    return @{
              @"userId" : self.userId,
              @"idCard" : self.idCard,
              @"name" : self.userName,
              @"token" : self.token
             };
}


@end
