//
//  ASPopupView.m
//  ASPopupView
//
//  Created by Cyrus on 16/4/13.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import "ASPopupView.h"

@implementation ASPopupView

/** 初始化方法 */
- (_Nonnull instancetype)init {
    self = [super init];
    if (!self) { return nil; };
    
    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 250) / 2, ([UIScreen mainScreen].bounds.size.height - 150) / 2, 250, 150);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self addGestureRecognizer:tapGesture];
    return self;
}

- (void)tapGesture {
    if (_controller) {
        [_controller dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
