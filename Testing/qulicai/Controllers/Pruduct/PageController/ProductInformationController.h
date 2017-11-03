//
//  YYPageViewController.h
//  YYPageController
//
//  Created by sky　 on 2017/4/28.
//  Copyright © 2017年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"

@interface ProductInformationController : UIViewController

@property (strong, nonatomic) ProductDetail *productDetail;

@property (copy, nonatomic) NSString *period;

@property (copy, nonatomic) NSString *productId;

@end
