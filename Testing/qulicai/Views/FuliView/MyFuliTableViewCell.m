//
//  MyFuliTableViewCell.m
//  qulicai
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MyFuliTableViewCell.h"

@implementation MyFuliTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.useButton.layer.cornerRadius = 15.0f;
    self.useButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

@end
