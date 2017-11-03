//
//  ForgetPasswordViewController.h
//  qulicai
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordViewController : UIViewController

//是否是修改交易密码
@property (assign, nonatomic) BOOL isTradingPw;

//是否提现交易密码
@property (assign, nonatomic) BOOL isPickUpPw;

////是否购买时交易密码
@property (assign, nonatomic) BOOL isBuyRechargePw;

//注册页面忘记密码跳转
@property (assign, nonatomic) BOOL isRegisterSwip;

@end
