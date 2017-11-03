//
//  QRActionView.m
//  qulicai
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRActionView.h"

@implementation QRActionView

#pragma mark - Life cycle

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
    self.aView.frame = self.frame;
}

#pragma mark - Private

- (void)setupViews {
    self.backHolderView.layer.cornerRadius = 10.0f;
    self.backHolderView.layer.masksToBounds = YES;
}

- (IBAction)dimissButtonWasPressed:(UIButton *)sender {
    if (self.zhPopController) {
        [self.zhPopController dismiss];
    }
}


@end
