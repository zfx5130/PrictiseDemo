//
//  QRWebViewController.h
//  qulicai
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 qurong. All rights reserved.
//

//#import <TOWebViewController/TOWebViewController.h>
#import <DZNWebViewController.h>

@interface QRWebViewController : DZNWebViewController

- (instancetype)initWithTitle:(NSString *)title
                    URLString:(NSString *)URLString;

@end
