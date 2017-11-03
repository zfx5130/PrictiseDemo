//
//  QRRequestLockAction.h
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestLockAction : QRRequest

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *amount;

@property (copy, nonatomic) NSString *address;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *phone;

@end

