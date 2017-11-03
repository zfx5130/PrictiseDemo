//
//  QRRequestRongBaoPayConfig.h
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestRongBaoPayConfig : QRRequest

@property (copy, nonatomic) NSString *userName;

@property (copy, nonatomic) NSString *userId;

//0趣理财
@property (assign, nonatomic) NSInteger appType;

//0融宝
@property (assign, nonatomic) NSInteger payType;

//订单号
@property (copy, nonatomic) NSString *orderNo;

//验证码
@property (copy, nonatomic) NSString *checkCode;

//金额
@property (copy, nonatomic) NSString *totalFee;

@end
