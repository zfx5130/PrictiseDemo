//
//  QRRequestLLPayBinQuery.h
//  qulicai
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestLLPayBinQuery : QRRequest

@property (copy, nonatomic) NSString *cardNo;

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *userName;

//0趣理财
@property (assign, nonatomic) NSInteger appType;
//0融宝
@property (assign, nonatomic) NSInteger payType;

@end
