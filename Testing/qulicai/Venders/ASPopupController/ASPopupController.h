//
//  ASPopupController.h
//  ASPopupController
//
//  Created by Cyrus on 16/3/26.
//  Copyright © 2016年 Cyrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPopupHeader.h"

@class ASPopupView;

/** 灰色背景透明度 */
static const CGFloat as_backgroundAlpha = 0.6;

@interface ASPopupController : UIViewController

/** alert 视图 */
@property (nonnull, nonatomic, strong)UIView *alertView;

/** 半透明背景 */
@property (nonnull, nonatomic, strong)UIView *backgroundView;

/** present 转场风格 */
@property (nonatomic, assign)ASPopupPresentStyle presentStyle;

/** dismiss 转场风格 */
@property (nonatomic, assign)ASPopupDismissStyle dismissStyle;

- (void)setAlertViewCornerRadius:(CGFloat)cornerRadius;

/**
 *    标准初始化方法
 *
 *    @param title        标题
 *    @param message      消息
 *    @param presentStyle present 转场风格
 *    @param dismissStyle dismiss 转场风格
 *
 *    @return alert控制器
 */
+ (_Nonnull instancetype)alertWithPresentStyle:(ASPopupPresentStyle)presentStyle
                                  dismissStyle:(ASPopupDismissStyle)dismissStyle
                                     alertView:(UIView * _Nonnull)alertView;

@end
