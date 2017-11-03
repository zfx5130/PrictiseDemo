//
//  ProductPriceView.m
//  niaobushi
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 yangkun. All rights reserved.
//

#import "ProductPasswordView.h"

@implementation ProductPasswordView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil];
        self.view.frame = frame;
        [self addSubview:self.view];
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - Private

- (void)setupViews {
    [self.passwordView beginInput];
    
    __weak typeof(self) weakSelf = self;
    self.passwordView.PasswordCompeleteBlock = ^(NSString *password) {
        if (weakSelf.pwBlock) {
            weakSelf.pwBlock(password);
        }
    };
}

@end
