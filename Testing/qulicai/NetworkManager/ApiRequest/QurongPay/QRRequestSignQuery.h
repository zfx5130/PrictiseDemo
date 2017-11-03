//
//  QRRequestSignQuery.h
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestSignQuery : QRRequest

@property (copy, nonatomic) NSString *userId;

//0趣理财
@property (assign, nonatomic) NSInteger appType;
//0融宝
@property (assign, nonatomic) NSInteger payType;

@property (copy, nonatomic) NSString *orderNo;

@end
