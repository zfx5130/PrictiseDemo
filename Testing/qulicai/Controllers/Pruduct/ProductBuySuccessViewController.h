//
//  ProductBuySuccessViewController.h
//  qulicai
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductBuySuccessViewController : UIViewController

//提现成功
@property (assign, nonatomic) BOOL isPickupSuccess;

//购买成功
@property (assign, nonatomic) BOOL isBuySuccess;

//充值成功
@property (assign, nonatomic) BOOL isChargeSuccess;

@property (copy, nonatomic) NSString *money;

@end
