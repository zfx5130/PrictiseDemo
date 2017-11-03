//
//  PropertyHeadTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyHeadTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *propertyCircleView;

@property (weak, nonatomic) IBOutlet UILabel *totalPropertyLabel;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *regularLabel;

@end
