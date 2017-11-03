//
//  QRRequestGetActionList.m
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetActionList.h"

@implementation QRRequestGetActionList

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/active/winnerList";
}

- (id)requestArgument {
    return @{};
}

@end
