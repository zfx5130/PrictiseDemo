//
//  UIButton+Addition.m
//  pocket
//
//  Created by yangkun on 4/16/15.
//  Copyright (c) 2015 yangkun. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

+(UIButton *)buttonWithImagePath:(NSString *)imagePath target:(id)target selector:(SEL)selector {
    return [UIButton buttonWithImage:[UIImage imageNamed:imagePath] target:target selector:selector];
}

+(UIButton *)buttonWithImage:(UIImage *)image target:(id)target selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)buttonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:color forState:UIControlStateNormal];
    button.frame = frame;
    
    return button;
}

+(UIButton *)buttonWithTitle:(NSString *)title width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector {
    return [self buttonWithTitle:title width:width height:height target:target selector:selector enable:YES];
}

+(UIButton *)buttonWithTitle:(NSString *)title width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector enable:(BOOL)enable {
    return [self buttonWithTitle:title font:[UIFont boldSystemFontOfSize:14] width:width height:height target:target selector:selector enable:enable];
}

+(UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector {
    return [self buttonWithTitle:title font:font width:width height:height target:target selector:selector enable:YES];
}

+(UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector enable:(BOOL)enable {
    UIColor *buttonColor = enable ? [UIColor appDefaultColor] : [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
    return [self buttonWithTitle:title color:buttonColor font:font width:width height:height target:target selector:selector];
}

+(UIButton *)buttonWithTitle:(NSString *)title color:(UIColor *)color width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector {
    return [self buttonWithTitle:title color:color font:[UIFont boldSystemFontOfSize:14] width:width height:height target:target selector:selector];
}

+(UIButton *)buttonWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height target:(id)target selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, width, height)];
    [button setBackgroundColor:color];
    button.layer.cornerRadius = 2.0;
    button.layer.masksToBounds = YES;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
