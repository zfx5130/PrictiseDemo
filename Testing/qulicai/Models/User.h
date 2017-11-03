//
//  Login.h
//  qulicai
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSUInteger, AuthenticationStatusType) {
    AuthenticationStatusSuccess = 0, //已认证
    AuthenticationStatusFail //未认证
};

@class User;
@interface User : BaseModel

@property (copy, nonatomic) NSString *userId;

//昵称
@property (copy, nonatomic) NSString *nickName;

//真实名字
@property (copy, nonatomic) NSString *realName;

//手机号
@property (copy, nonatomic) NSString *mobilePhone;

//注册时间
@property (copy, nonatomic) NSString *addTime;

//登录状态 1.锁定 0 解锁
@property (assign, nonatomic) NSInteger loginStatus;

//交易状态 1.锁定 0 解锁
@property (assign, nonatomic) NSInteger payStatus;

//版本
@property (copy, nonatomic) NSString *version;

@property (assign,  nonatomic) NSInteger loginFailCounts;

//是否实名认证
@property (assign, nonatomic) AuthenticationStatusType authStatusType;

//总金额
@property (assign, nonatomic) CGFloat totalMoney;

//是否设置过交易密码 yes no
@property (assign, nonatomic) BOOL payPwd;

//可用余额
@property (assign, nonatomic) CGFloat availableMoney;

//冻结金额
@property (assign, nonatomic) CGFloat freezeMoney;

//定期本金
@property (assign, nonatomic) CGFloat regularMoney;

//活期本金
@property (assign, nonatomic) CGFloat currentMoney;

//每日收益
@property (assign, nonatomic) CGFloat dailyEarnings;

//累计收益
@property (assign, nonatomic) CGFloat accumulatedIncome;

//注册时间
@property (copy, nonatomic) NSString *createTime;

//身份证号
@property (copy, nonatomic) NSString *cardId;

//头像
@property (copy, nonatomic) NSString *headPortrait;

//银行列表
@property (copy, nonatomic) NSArray *appBanks;

//未使用的卡卷数
@property (assign, nonatomic) NSInteger unusedCount;

//理财金
@property (assign, nonatomic) NSInteger totalFinancialGold;

@end
