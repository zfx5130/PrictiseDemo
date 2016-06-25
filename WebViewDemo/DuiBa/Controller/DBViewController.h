//
//  DBViewController.h
//  DuiBa
//
//  Created by czy on 16/6/3.
//  Copyright © 2016年 Caiziyi coporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOWebViewController.h"

@interface DBViewController : TOWebViewController

- (instancetype)initWithTitle:(NSString *)title
                    URLString:(NSString *)URLString;

- (instancetype)initWithTitle:(NSString *)title
                    URLString:(NSString *)URLString
      navigationButtonsHidden:(BOOL)navigationButtonsHidden;
@end
