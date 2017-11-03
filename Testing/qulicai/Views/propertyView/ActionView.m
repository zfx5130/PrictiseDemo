//
//  ActionView.m
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ActionView.h"

@implementation ActionView

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
    [self.addressTextField becomeFirstResponder];
    self.textView =
    [[YYTextView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, self.addressHolderView.frame.size.width, 150.0f)];
    self.textView.placeholderText = @"请填写详细地址";
    self.textView.placeholderFont = [UIFont systemFontOfSize:16.0f];
    self.textView.textColor = RGBColor(51.0f, 51.0f, 51.0f);
    self.textView.font = [UIFont systemFontOfSize:16.0f];
    [self.addressHolderView addSubview:self.textView];
    self.textView.clearsOnInsertion = YES;
    //self.textView.delegate = self;
}

@end
