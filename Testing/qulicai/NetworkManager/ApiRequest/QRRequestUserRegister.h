//
//  QRRequestUserRegister.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestUserRegister : QRRequest

@property (copy, nonatomic) NSString *mobilePhone;

@property (copy, nonatomic) NSString *password;

@property (copy, nonatomic) NSString *code;

@end
