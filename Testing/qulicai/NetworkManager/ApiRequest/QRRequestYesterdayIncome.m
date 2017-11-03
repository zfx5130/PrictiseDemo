//
//  QRRequestYesterdayIncome.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestYesterdayIncome.h"

@implementation QRRequestYesterdayIncome

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/asset/transactionFlowing";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId,
             @"currentPage" : self.currentPage,
             @"pageSize" : self.pageSize,
             @"token" : self.token
             };
}

@end
