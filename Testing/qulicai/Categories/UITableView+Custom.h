//
//  UITableView+Custom.h
//  zhixingche
//
//  Created by dev on 15/8/5.
//  Copyright (c) 2015年 yunzao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIScrollView+Custom.h"

@interface UITableView (Custom)

- (void)registerCellWithClass:(Class)cellClass
          withReuseIdentifier:(NSString *)reuseIdentifier;

@end
