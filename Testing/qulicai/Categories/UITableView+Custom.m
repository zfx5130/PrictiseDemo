//
//  UITableView+Custom.m
//  zhixingche
//
//  Created by dev on 15/8/5.
//  Copyright (c) 2015年 yunzao. All rights reserved.
//

#import "UITableView+Custom.h"

@implementation UITableView (Custom)

- (void)registerCellWithClass:(Class)cellClass
          withReuseIdentifier:(NSString *)reuseIdentifier {
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass)
                                bundle:nil];
    [self registerNib:nib
    forCellReuseIdentifier:reuseIdentifier];
}

@end
