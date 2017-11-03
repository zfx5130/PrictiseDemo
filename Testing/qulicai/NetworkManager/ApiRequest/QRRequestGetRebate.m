//
//  QRRequestGetRebate.m
//  qulicai
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetRebate.h"

@implementation QRRequestGetRebate

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/user/rebate";
}

- (id)requestArgument {
    return @{};
}


@end
