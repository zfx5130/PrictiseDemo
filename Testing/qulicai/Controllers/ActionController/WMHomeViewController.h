//
//  WMHomeViewController.h
//  Demo
//
//  Created by Mark on 16/7/25.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMPageController.h"

#define kNavigationBarHeight  (IS_IPHONE_X ? 88 : 64)  //nav高度

@interface WMHomeViewController : WMPageController

@property (nonatomic, assign) CGFloat viewTop;

@end
