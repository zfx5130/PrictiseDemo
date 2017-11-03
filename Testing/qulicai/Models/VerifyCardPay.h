//
//  VerifyCardPay.h
//  qulicai
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface VerifyCardPay : BaseModel

@property (copy, nonatomic) NSString *bank_code;

@property (copy, nonatomic) NSString *result_code;

@property (copy, nonatomic) NSString *bank_name;

@property (copy, nonatomic) NSString *result_msg;

@end
