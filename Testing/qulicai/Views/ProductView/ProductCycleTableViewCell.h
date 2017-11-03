//
//  ProductCycleTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditChangeBlock)(NSString *text);

@interface ProductCycleTableViewCell : UITableViewCell
<UITextViewDelegate>

@property (copy, nonatomic) EditChangeBlock changeBlock;
//可购余额
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

//全额购买
@property (weak, nonatomic) IBOutlet UIButton *allbuyButton;

//全部转入
@property (weak, nonatomic) IBOutlet UIButton *balanceBuyButton;

//充值
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;

//30
@property (weak, nonatomic) IBOutlet UIView *balanceHolderView;


//账户余额
@property (weak, nonatomic) IBOutlet UILabel *accountBalanceLabel;

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@property (weak, nonatomic) IBOutlet UIView *balanceTopView;

@property (weak, nonatomic) IBOutlet UIView *balanceBottomView;

@property (weak, nonatomic) IBOutlet UIView *errorView;

@property (weak, nonatomic) IBOutlet UIView *incomeView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@end
