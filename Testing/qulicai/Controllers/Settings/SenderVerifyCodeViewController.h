//
//  SenderVerifyCodeViewController.h
//  qulicai
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SenderVerifyCodeViewController : UIViewController

@property (copy, nonatomic) NSString *periodMoney;
@property (copy, nonatomic) NSString *productId;
//余额小于购买金额时传入的总金额
@property (copy, nonatomic) NSString *totalMoney;
//充值金额
@property (copy, nonatomic) NSString *money;

//订单号
@property (copy, nonatomic) NSString *orderNo;
//第一次预留的手机号
@property (copy, nonatomic) NSString *phone;

@property (assign, nonatomic) BOOL isRecharge;
@property (copy, nonatomic) NSString *ticketId;

@end
