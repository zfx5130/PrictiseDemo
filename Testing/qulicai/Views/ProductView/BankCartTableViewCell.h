//
//  BankCartTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftBankImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftBankNameLabel;


@property (weak, nonatomic) IBOutlet UIImageView *rightBankImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightBankNameLabel;


@end

