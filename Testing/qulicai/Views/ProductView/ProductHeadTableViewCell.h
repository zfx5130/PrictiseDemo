//
//  ProductHeadTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductHeadTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *yearIncomeLabel;

@property (weak, nonatomic) IBOutlet UILabel *periodsDayLabel;

@property (weak, nonatomic) IBOutlet UILabel *backMoneyTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *periodImageHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *startMoneyTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *detailButton;


@end
