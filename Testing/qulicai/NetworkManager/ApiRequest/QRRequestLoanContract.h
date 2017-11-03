//
//  QRRequestLoanContract.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestLoanContract : QRRequest

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *payInfoId;

@property (assign, nonatomic) NSInteger currentPage;

@property (assign, nonatomic) NSInteger pageSize;

@end
