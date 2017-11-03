//
//  QuRongVerifyCode.h
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface QuRongVerifyCode : BaseModel

@property (copy, nonatomic) NSString *phone;

@property (copy, nonatomic) NSString *order_no;

@property (copy, nonatomic) NSString *result_code;

@property (copy, nonatomic) NSString *result_msg;

@end
