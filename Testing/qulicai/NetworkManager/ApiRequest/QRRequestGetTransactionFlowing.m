//
//  QRRequestGetTransactionFlowing.m
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestGetTransactionFlowing.h"

@implementation QRRequestGetTransactionFlowing

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
