//
//  QRRequestGetTransactionFlowing.h
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestGetTransactionFlowing : QRRequest

@property (copy,nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *currentPage;

@property (copy, nonatomic) NSString *pageSize;

@end
