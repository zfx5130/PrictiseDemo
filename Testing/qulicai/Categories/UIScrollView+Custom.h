//
//  UIScrollView+Custom.h
//  zhixingche
//
//  Created by satgi on 9/8/15.
//  Copyright (c) 2015 yunzao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MJRefresh.h>

@interface UIScrollView (Custom)

- (void)addHeaderControlWithtarget:(id)target
                          selector:(SEL)selector;

- (void)addHeaderControlWithIdleTitle:(NSString *)idleTitle
                         pullingTitle:(NSString *)pullingTitle
                      refreshingTitle:(NSString *)refreshingTitle
                               target:(id)target
                             selector:(SEL)selector;

- (void)addBackFooterRefreshControlIdleTitle:(NSString *)idleTitle
                                  noMoreData:(NSString *)noMoreData
                             refreshingTitle:(NSString *)refreshingTitle
                                pullingTitle:(NSString *)pullingTitle
                                      target:(id)target
                                    selector:(SEL)selector
                                      bottom:(CGFloat)bottomPadding;

- (void)addFooterRefreshControlIdleTitle:(NSString *)idleTitle
                              noMoreData:(NSString *)noMoreData
                         refreshingTitle:(NSString *)refreshingTitle
                                  target:(id)target
                                selector:(SEL)selector
                             autoRefresh:(BOOL)autoRefresh;

- (CGRect)zoomedRectOfUIView:(UIView *)view;

@end
