//
//  QRRequestSetingTranPassword.h
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestSetingTranPassword : QRRequest

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *transactionPwd;

@end
