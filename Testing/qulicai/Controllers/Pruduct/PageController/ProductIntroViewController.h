//
//  ProductIntroViewController.h
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"
#import "BuyHistory.h"

@interface ProductIntroViewController : UIViewController

@property (strong, nonatomic) ProductDetail *productDetail;

@property (strong, nonatomic) BuyHistory *buyHistory;

@property (copy, nonatomic) NSString *period;

@end

