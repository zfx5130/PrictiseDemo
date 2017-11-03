//
//  ConfigPayViewController.h
//  qulicai
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"

@class Ticket;
@interface ConfigPayViewController : UIViewController

@property (strong, nonatomic) ProductDetail *product;

@property (copy, nonatomic) NSString *period;

@property (copy, nonatomic) NSString *productId;

@property (copy, nonatomic) NSString *money;

@property (strong, nonatomic) Ticket *ticket;

@end
