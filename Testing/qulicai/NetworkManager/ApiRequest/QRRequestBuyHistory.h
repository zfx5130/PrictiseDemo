//
//  QRRequestBuyHistory.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

typedef enum : NSUInteger {
    HistoryStatusHolding = 1, //持有中
    HistoryStatusEnded = 2, //已完成
} HistoryStatus;

@interface QRRequestBuyHistory : QRRequest

@property (copy, nonatomic) NSString *userId;

@property (assign, nonatomic) HistoryStatus statusType;

@property (assign, nonatomic) NSInteger currentPage;

@property (assign, nonatomic) NSInteger pageSize;

@end
