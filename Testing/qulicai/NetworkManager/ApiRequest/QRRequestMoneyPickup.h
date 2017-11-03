//
//  QRRequestMoneyPickup.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestMoneyPickup : QRRequest

@property (assign, nonatomic) CGFloat money;

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *bankNo;

@end
