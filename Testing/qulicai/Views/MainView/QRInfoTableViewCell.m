//
//  QRInfoTableViewCell.m
//  qulicai
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRInfoTableViewCell.h"

@implementation QRInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (IS_IPHONE_5) {
        self.leftTopConstraint.constant = 15.0f;
        self.centerTopConstraint.constant = 15.0f;
        self.rightTopConstraint.constant = 15.0f;
    }
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

@end
