//
//  QRRequestLoanContract.m
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestLoanContract.h"

@implementation QRRequestLoanContract

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/asset/loanContract";
}

- (id)requestArgument {
    return @{
             @"userId" : self.userId ,
             @"payInfoId" : self.payInfoId,
             @"token" : self.token,
             @"currentPage" : @(self.currentPage),
             @"pageSize" : @(self.pageSize)
             };
}


@end
