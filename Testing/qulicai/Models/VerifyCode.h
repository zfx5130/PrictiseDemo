//
//  VerifyCode.h
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface VerifyCode : BaseModel

@property (copy, nonatomic) NSString *verifyCode;

@property (copy, nonatomic) NSString *mobilePhone;

@end
