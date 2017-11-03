//
//  QRRequestFirstPaySign.h
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestFirstPaySign : QRRequest

@property (copy, nonatomic) NSString *cardNo;

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *userName;

//0趣理财
@property (assign, nonatomic) NSInteger appType;

//0融宝
@property (assign, nonatomic) NSInteger payType;

//持卡人姓名
@property (copy, nonatomic) NSString *owner;

//证件号
@property (copy, nonatomic) NSString *certNo;

//手机号
@property (copy, nonatomic) NSString *phone;

//金额
@property (copy, nonatomic) NSString *totalFee;


@end
