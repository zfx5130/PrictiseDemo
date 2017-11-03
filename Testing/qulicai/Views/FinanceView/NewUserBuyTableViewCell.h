//
//  NewUserBuyTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserBuyTableViewCell : UITableViewCell
//年收益
@property (weak, nonatomic) IBOutlet UILabel *yearSaleLabel;
//余额
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;


@property (weak, nonatomic) IBOutlet UIImageView *firstUseTagImageView;

@property (weak, nonatomic) IBOutlet UIView *fuLiUseHolderView;

@end
