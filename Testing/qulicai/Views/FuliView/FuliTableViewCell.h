//
//  FuliTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuliTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@property (weak, nonatomic) IBOutlet UILabel *welfareLabel;

@property (weak, nonatomic) IBOutlet UIImageView *fuliImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *limitMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *expireTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *descContentLabel;

@end
