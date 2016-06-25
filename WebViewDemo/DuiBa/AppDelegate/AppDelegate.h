//
//  AppDelegate.h
//  DuiBa
//
//  Created by czy on 16/3/21.
//  Copyright © 2016年 Caiziyi coporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *conn;
@property (nonatomic) NetworkStatus status;

@end

