//
//  MainHeadView.m
//  qulicai
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MainHeadView.h"

@implementation MainHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil];
        self.aView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.aView];
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.aView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)setupView {
}


@end
