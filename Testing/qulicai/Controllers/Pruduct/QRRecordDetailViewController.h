//
//  QRRecordDetailViewController.h
//  qulicai
//
//  Created by admin on 2017/10/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "WMPageController.h"
#import "BuyHistory.h"

static CGFloat const kWMHeaderViewHeight = 67;
#define kNavigationBarHeight  (IS_IPHONE_X ? 88 : 64)  //nav高度

@interface QRRecordDetailViewController : WMPageController

@property (nonatomic, assign) CGFloat viewTop;

@property (copy, nonatomic) NSString *period;

@property (strong, nonatomic) BuyHistory *buyHistory;


@end
