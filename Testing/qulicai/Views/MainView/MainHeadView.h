//
//  MainHeadView.h
//  qulicai
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHeadView : UIView

@property (strong, nonatomic) IBOutlet UIView *aView;

@property (weak, nonatomic) IBOutlet UIButton *lookButton;

@property (weak, nonatomic) IBOutlet UILabel *yesterdayEarningLabel;

@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *regularLabel;

@property (weak, nonatomic) IBOutlet UILabel *sendMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *pickupButton;

@property (weak, nonatomic) IBOutlet UIButton *chargeButton;

@property (weak, nonatomic) IBOutlet UIView *loginHolderView;

@property (weak, nonatomic) IBOutlet UIView *noLoginHolderView;

@property (weak, nonatomic) IBOutlet UIButton *openAccountButton;

@property (weak, nonatomic) IBOutlet UIButton *ablanceTagButton;

@property (weak, nonatomic) IBOutlet UIButton *totalButton;

@property (weak, nonatomic) IBOutlet UIButton *finanalMoneyButton;

@property (weak, nonatomic) IBOutlet UIButton *yesterdayIncomeButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *oldAccountLabel;


@property (weak, nonatomic) IBOutlet UILabel *noLoginRateLabel;

@property (weak, nonatomic) IBOutlet UILabel *noLoginMoneyLabel;

@end
