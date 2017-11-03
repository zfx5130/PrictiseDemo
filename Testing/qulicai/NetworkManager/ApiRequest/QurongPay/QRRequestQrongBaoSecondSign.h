//
//  QRRequestQrongBaoSecondSign.h
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestQrongBaoSecondSign : QRRequest

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *userName;

//0趣理财
@property (assign, nonatomic) NSInteger appType;
//0融宝
@property (assign, nonatomic) NSInteger payType;

@property (copy, nonatomic) NSString *bindId;

@property (copy, nonatomic) NSString *totalFee;

@end
