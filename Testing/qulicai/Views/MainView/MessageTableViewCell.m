//
//  MessageTableViewCell.m
//  qulicai
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

- (void)renderUiiWithStatus:(BOOL)status {
    self.messageTagImageView.hidden = status;
    self.contentView.backgroundColor = status ? RGBColor(244.0f, 244.0f, 244.0f) : [UIColor whiteColor];
    self.messageTitleLabel.textColor = status ? RGBColor(102.0f, 102.0f, 102.0f) : RGBColor(51.0f, 51.0f, 51.0f);
    self.messageTitleLabel.font = status ? [UIFont systemFontOfSize:16.0f] : [UIFont boldSystemFontOfSize:16.0f];
    self.messageContentLabel.textColor = status ? RGBColor(153.0f, 153.0f, 153.0f) : RGBColor(102.0f, 102.0f, 102.0f);
}

@end
