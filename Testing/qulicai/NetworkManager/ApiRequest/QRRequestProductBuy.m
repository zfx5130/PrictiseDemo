//
//  QRRequestProductBuy.m
//  qulicai
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequestProductBuy.h"

@implementation QRRequestProductBuy


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"qlc/product/buy";
}

- (id)requestArgument {
    
    return @{
             @"userId" : self.userId,
             @"id" : self.productId,
             @"token" : self.token,
             @"amount" : self.amount,
             @"ticketId" : self.ticketId,
             @"unitType" : @"iOS"
             };
}


@end
