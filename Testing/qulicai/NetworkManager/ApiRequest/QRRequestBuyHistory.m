//
//  QRRequestBuyHistory.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestBuyHistory.h"

@implementation QRRequestBuyHistory

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/asset/userProduct";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId ,
             @"status" : @(self.statusType),
             @"token" : self.token,
             @"currentPage" : @(self.currentPage),
             @"pageSize" : @(self.pageSize)
             };
}


@end
