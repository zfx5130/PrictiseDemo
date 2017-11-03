//
//  QRRequestGetFriendsList.m
//  qulicai
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetFriendsList.h"

@implementation QRRequestGetFriendsList

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/active/inviteFriends";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId,
             @"token" : self.token
             };
}

@end
