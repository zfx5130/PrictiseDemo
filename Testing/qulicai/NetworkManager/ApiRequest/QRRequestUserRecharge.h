//
//  QRRequestUserRecharge.h
//  qulicai
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestUserRecharge : QRRequest

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *banNo;

@property (copy, nonatomic) NSString *bankName;

@property (assign, nonatomic) NSString *money;

//订单号 生成当前时间 + CZ
@property (copy, nonatomic) NSString *no_order;

//连连支付支付单号 暂未设置
@property (copy, nonatomic) NSString *oid_paybill;

@end
