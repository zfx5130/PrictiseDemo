//
//  QRProjectDetailViewController.h
//  qulicai
//
//  Created by admin on 2017/10/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "WMPageController.h"
#import "ProductDetail.h"

static CGFloat const kWMHeaderViewHeight = 67;
#define kNavigationBarHeight  (IS_IPHONE_X ? 88 : 64)  //nav高度


@interface QRProjectDetailViewController : WMPageController

@property (nonatomic, assign) CGFloat viewTop;

@property (strong, nonatomic) ProductDetail *productDetail;

@property (copy, nonatomic) NSString *period;

@property (copy, nonatomic) NSString *productId;

@end

