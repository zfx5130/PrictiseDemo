//
//  AccountCertificationViewController.h
//  qulicai
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCertificationViewController : UIViewController

//购买的时候添加银行卡
@property (assign, nonatomic) BOOL isProductPush;

//充值第一次认证
@property (assign, nonatomic) BOOL isFirstRechargePush;

@property (copy, nonatomic) NSString *money;

@property (copy, nonatomic) NSString *periodMoney;
@property (copy, nonatomic) NSString *productId;
@property (copy, nonatomic) NSString *totalMoney;

@property (assign, nonatomic) BOOL isRecharge;
@property (copy, nonatomic) NSString *ticketId;

@end
