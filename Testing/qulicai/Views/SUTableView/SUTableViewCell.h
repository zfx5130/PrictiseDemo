//
//  SUTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *optionLabel;


@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
