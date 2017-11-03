//
//  ProductCycleTableViewCell.m
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ProductCycleTableViewCell.h"

@implementation ProductCycleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

- (IBAction)editChanged:(UITextField *)sender {
    if (self.changeBlock) {
        self.changeBlock(sender.text);
    }
}

@end
