//
//  PruductDetailViewController.h
//  qulicai
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface PruductDetailViewController : UIViewController

@property (copy, nonatomic) NSString *period;

@property (copy, nonatomic) NSString *productId;

@property (assign, nonatomic) NSInteger type;

@end
