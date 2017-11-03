//
//  QRRequestLogin.h
//  qulicai
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestLogin : QRRequest

@property (copy, nonatomic) NSString *mobilePhone;

@property (copy, nonatomic) NSString *password;
//设备型号
@property (copy, nonatomic) NSString *unitType;

//登录方式 0.密码登录 1.验证码登录
@property (assign, nonatomic) NSInteger loginType;

@end
