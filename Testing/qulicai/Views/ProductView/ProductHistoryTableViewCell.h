//
//  ProductHistoryTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductHistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *holdMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleDescLabel;

@end
