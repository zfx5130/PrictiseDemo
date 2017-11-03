//
//  ActionPriceView.m
//  qulicai
//
//  Created by admin on 2017/9/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ActionPriceView.h"

@implementation ActionPriceView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil];
        self.aView.frame = frame;
        [self addSubview:self.aView];
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setupViews {
    self.cancleButton.layer.cornerRadius = 20.0f;
    self.cancleButton.layer.masksToBounds = YES;

    if (IS_IPHONE_6) {
        self.tilteBottonConstraint.constant = 10.0f;
    }
    if (IS_IPHONE_5) {
        self.phoneLeftConstraint.constant  = 83.0f;
        self.tilteBottonConstraint.constant = 8.0f;
    }
}
@end
