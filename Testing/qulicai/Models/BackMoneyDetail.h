//
//  BackMoneyDetail.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface BackMoneyDetail : BaseModel

//期数
@property (copy, nonatomic) NSString *planPeriod;

//以及还款时间
@property (copy, nonatomic) NSString *planEndTime;

//到期本息
@property (assign, nonatomic) CGFloat planTotalMoney;

//到期收益
@property (assign, nonatomic) CGFloat planTotalRate;

//还款金额(本息)
@property (assign, nonatomic) CGFloat planTotalMoneyAndRate;

// 0待还款 1已还款
@property (assign, nonatomic) NSInteger planStatus;


@end
