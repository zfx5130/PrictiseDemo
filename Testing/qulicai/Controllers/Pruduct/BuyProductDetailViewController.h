//
//  BuyProductDetailViewController.h
//  qulicai
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyHistory.h"

@interface BuyProductDetailViewController : UIViewController

@property (copy, nonatomic) NSString *period;

@property (strong, nonatomic) BuyHistory *buyHistory;

@end
