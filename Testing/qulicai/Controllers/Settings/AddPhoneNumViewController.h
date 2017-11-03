//
//  AddPhoneNumViewController.h
//  qulicai
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerifyCardPay.h"

@interface AddPhoneNumViewController : UIViewController

@property (strong, nonatomic) VerifyCardPay *cardPay;

@property (copy, nonatomic) NSString *periodMoney;
@property (copy, nonatomic) NSString *productId;
@property (copy, nonatomic) NSString *totalMoney;
//充值money
@property (copy, nonatomic) NSString *money;

@property (copy, nonatomic) NSString *bankCardNo;

@property (assign, nonatomic) BOOL isRecharge;
@property (copy, nonatomic) NSString *ticketId;

@end
