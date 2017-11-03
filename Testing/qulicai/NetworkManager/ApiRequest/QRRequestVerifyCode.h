//
//  QRRequestVerifyCode.h
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

typedef enum : NSUInteger {
    VerifyCodeTypeLoginPW = 0, //忘记登录密码
    VerifyCodeTypeTransPW = 1,//找回交易密码
    VerifyCodeTypeRegister = 2, //注册
    VerifyCodeTypeVerifyLogin = 3, //验证码登录
} VerifyCodeType;

@interface QRRequestVerifyCode : QRRequest

@property (copy, nonatomic) NSString *mobilePhone;

@property (assign, nonatomic) VerifyCodeType codeType;

@end
