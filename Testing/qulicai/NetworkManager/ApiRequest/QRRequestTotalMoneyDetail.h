//
//  QRRequestTotalMoneyDetail.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestTotalMoneyDetail : QRRequest

@property (copy, nonatomic) NSString *currentPage;

@property (copy, nonatomic) NSString *pageSize;

@property (copy, nonatomic) NSString *userId;

@end
