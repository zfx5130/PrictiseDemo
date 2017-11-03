//
//  ASPopupView.h
//  ASPopupView
//
//  Created by Cyrus on 16/4/13.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASPopupAction;

@interface ASPopupView : UIView

/** 保存当前的视图控制器，用来dismiss */
@property (nonatomic, weak, nullable)UIViewController *controller;

- (_Nonnull instancetype)init;


@end
