//
//  ZHWebViewController.h
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SignStatusBlock)(BOOL isReload);
@interface ZHWebViewController : UIViewController

@property (copy, nonatomic) NSString *htmlText;

@property (copy, nonatomic) SignStatusBlock statusBlock;


@end

