//
//  AddBankCardViewController.h
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBankCardViewController : UIViewController

@property (copy, nonatomic) NSString *money;

//购买的时候充值的钱
@property (copy, nonatomic) NSString *periodMoney;
@property (copy, nonatomic) NSString *productId;
//购买时总moeny
@property (copy, nonatomic) NSString *totalMoney;

@property (assign, nonatomic) BOOL isRecharge;

@property (copy, nonatomic) NSString *ticketId;
@end
