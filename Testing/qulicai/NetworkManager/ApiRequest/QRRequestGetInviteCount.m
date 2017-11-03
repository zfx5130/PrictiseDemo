//
//  QRRequestGetInviteCount.m
//  qulicai
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetInviteCount.h"

@implementation QRRequestGetInviteCount

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/active/inviteCount";
}

- (id)requestArgument {
    return @{};
}


@end
