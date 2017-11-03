//
//  EmptyPropertyTableViewCell.m
//  qulicai
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "EmptyPropertyTableViewCell.h"

@implementation EmptyPropertyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (IS_IPHONE_6P) {
        self.emptyImageTopConstraint.constant = 85.0f;
    } else if (IS_IPHONE_5) {
        
    }
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

@end
