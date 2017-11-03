//
//  UIScrollView+Custom.m
//  zhixingche
//
//  Created by satgi on 9/8/15.
//  Copyright (c) 2015 yunzao. All rights reserved.
//

#import "UIScrollView+Custom.h"
#import "UIColor+Custom.h"

@implementation UIScrollView (Custom)


- (void)addHeaderControlWithtarget:(id)target
                          selector:(SEL)selector {
    MJRefreshStateHeader *stateHeader =
    [MJRefreshStateHeader headerWithRefreshingTarget:target
                                    refreshingAction:selector];
    
    stateHeader.lastUpdatedTimeLabel.hidden = YES;
    stateHeader.stateLabel.font = [UIFont systemFontOfSize:14.0f];
    stateHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13.0f];
    stateHeader.stateLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
    self.mj_header = stateHeader;
}

- (void)addHeaderControlWithIdleTitle:(NSString *)idleTitle
                         pullingTitle:(NSString *)pullingTitle
                      refreshingTitle:(NSString *)refreshingTitle
                               target:(id)target
                             selector:(SEL)selector {
    
    MJRefreshStateHeader *stateHeader =
    [MJRefreshStateHeader headerWithRefreshingTarget:target
                                    refreshingAction:selector];
    [stateHeader setTitle:idleTitle
                 forState:MJRefreshStateIdle];
    [stateHeader setTitle:pullingTitle
                 forState:MJRefreshStatePulling];
    [stateHeader setTitle:refreshingTitle
                 forState:MJRefreshStateRefreshing];
    stateHeader.lastUpdatedTimeLabel.hidden = YES;
    stateHeader.stateLabel.font = [UIFont systemFontOfSize:14.0f];
    stateHeader.backgroundColor = [UIColor clearColor];
    stateHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13.0f];
    stateHeader.stateLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
    self.mj_header = stateHeader;
    
}

- (void)addFooterRefreshControlIdleTitle:(NSString *)idleTitle
                              noMoreData:(NSString *)noMoreData
                         refreshingTitle:(NSString *)refreshingTitle
                                  target:(id)target
                                 selector:(SEL)selector
                             autoRefresh:(BOOL)autoRefresh {
    MJRefreshAutoNormalFooter *footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target
                                         refreshingAction:selector];
    [footer setTitle:idleTitle
            forState:MJRefreshStateIdle];
    [footer setTitle:refreshingTitle
            forState:MJRefreshStateRefreshing];
    [footer setTitle:noMoreData
            forState:MJRefreshStateNoMoreData];
    footer.automaticallyRefresh = autoRefresh;
    footer.stateLabel.font = [UIFont systemFontOfSize:14.0f];
    footer.stateLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
    self.mj_footer = footer;
    
}

- (void)addBackFooterRefreshControlIdleTitle:(NSString *)idleTitle
                                  noMoreData:(NSString *)noMoreData
                             refreshingTitle:(NSString *)refreshingTitle
                                pullingTitle:(NSString *)pullingTitle
                                      target:(id)target
                                    selector:(SEL)selector
                                      bottom:(CGFloat)bottomPadding {
    
    MJRefreshBackNormalFooter *footer =
    [MJRefreshBackNormalFooter footerWithRefreshingTarget:target
                                         refreshingAction:selector];
    [footer setTitle:idleTitle
            forState:MJRefreshStateIdle];
    [footer setTitle:refreshingTitle
            forState:MJRefreshStateRefreshing];
    [footer setTitle:noMoreData
            forState:MJRefreshStateNoMoreData];
    [footer setTitle:pullingTitle
            forState:MJRefreshStatePulling];
    
    footer.stateLabel.font = [UIFont systemFontOfSize:14.0f];
    footer.stateLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
    self.contentInset = UIEdgeInsetsMake(0, 0, bottomPadding, 0);
    self.mj_footer.ignoredScrollViewContentInsetBottom = bottomPadding;
    footer.arrowView.image = [UIImage imageNamed:@""];
    self.mj_footer = footer;
    //footer.automaticallyRefresh = autoRefresh;
}


- (CGRect)zoomedRectOfUIView:(UIView *)view {
    NSLog(@"%@", NSStringFromCGRect(view.frame));
    CGRect zoomedRect;
    if (view.frame.origin.x == 0) {
        zoomedRect.origin.x = - self.contentOffset.x;
    } else {
        zoomedRect.origin.x = self.contentOffset.x ? - self.contentOffset.x * (0.5 + 0.5 * view.bounds.size.width / self.bounds.size.width) : view.frame.origin.x;
    }
    if (view.frame.origin.y == 0) {
        zoomedRect.origin.y = - self.contentOffset.y;
    } else {
        zoomedRect.origin.y = self.contentOffset.y ? - self.contentOffset.y * (0.5 + 0.5 * view.bounds.size.height / self.bounds.size.height) : view.frame.origin.y;
    }
    zoomedRect.size = view.bounds.size;
//    zoomedRect.origin.x *= self.zoomScale;
//    zoomedRect.origin.y *= self.zoomScale;
    zoomedRect.size.width *= self.zoomScale;
    zoomedRect.size.height *= self.zoomScale;
    return zoomedRect;
}

@end
