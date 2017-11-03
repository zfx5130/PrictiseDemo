//
//  LoginPasswordErrorView.m
//  qulicai
//
//  Created by admin on 2017/10/25.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "LoginPasswordErrorView.h"

@implementation LoginPasswordErrorView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil];
        self.aView.frame = frame;
        [self addSubview:self.aView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
