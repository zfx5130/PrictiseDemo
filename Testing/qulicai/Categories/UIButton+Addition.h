//
//  UIButton+Addition.h
//  pocket
//
//  Created by yangkun on 4/16/15.
//  Copyright (c) 2015 yangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addition)

+(UIButton *)buttonWithImagePath:(NSString *)imagePath target:(id)target selector:(SEL)selector;
+(UIButton *)buttonWithImage:(UIImage *)image target:(id)target selector:(SEL)selector;
+(UIButton *)buttonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target selector:(SEL)selector;
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color;

+(UIButton *)buttonWithTitle:(NSString *)title width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector;

+(UIButton *)buttonWithTitle:(NSString *)title width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector enable:(BOOL)enable;
+(UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector;
+(UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector enable:(BOOL)enable;


+(UIButton *)buttonWithTitle:(NSString *)title color:(UIColor *)color width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector;
+(UIButton *)buttonWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector;

@end
