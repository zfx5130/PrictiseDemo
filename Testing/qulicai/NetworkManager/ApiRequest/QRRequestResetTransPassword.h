//
//  QRRequestResetTransPassword.h
//  qulicai
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestResetTransPassword : QRRequest

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *transactionPwd;

@property (copy, nonatomic) NSString *code;

@end
