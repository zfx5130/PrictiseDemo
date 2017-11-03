//
//  SenderVerifyButton.h
//  SenderVerifyCode
//
//  Created by dev on 15/9/24.
//  Copyright © 2015年 dev. All rights reserved.
//

extern NSString *const kSendVerifyCodeTime;
extern NSString *const kAcceptVerifyCodePhone;

#import <UIKit/UIKit.h>

@interface SendVerifyCodeButton : UIButton

/**
 *  发送验证码
 *
 *  @param phone 发送对应的手机号
 */

- (void)sendVerifyCodeWithPhone:(NSString *)phone
                     isBankCode:(BOOL)isBankCode;

/**
 *  验证码是否已经发送
 *
 *  @param phone 发送的手机号
 *
 *  @return 返回结果状态
 */
- (BOOL)canSenderVerifyCodeWithPhone:(NSString *)phone;

@end
