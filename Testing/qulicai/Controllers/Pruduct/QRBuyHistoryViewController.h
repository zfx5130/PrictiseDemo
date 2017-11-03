//
//  QRRecordDetailViewController.h
//  qulicai
//
//  Created by admin on 2017/10/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "WMPageController.h"

static CGFloat const kWMHeaderViewHeight = 167;
#define kNavigationBarHeight  (IS_IPHONE_X ? 88 : 64)  //nav高度

@interface QRBuyHistoryViewController : WMPageController

@property (nonatomic, assign) CGFloat viewTop;

@property (assign, nonatomic) BOOL isPresent;

@end

