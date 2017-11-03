//
//  UIColor+Custom.m
//  bike
//
//  Created by dev on 15/6/24.
//  Copyright (c) 2015年 yunzao. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)


- (UIColor *)getColor:(NSString *)hexColor {
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

+ (UIColor*)gradientFromColor:(UIColor*)fromColor
                      toColor:(UIColor*)toColor
                     withSize:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors =
    [NSArray arrayWithObjects:(id)fromColor.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef gradient =
    CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context,
                                gradient,
                                CGPointMake(0.5f * size.width, 0.0f),
                                CGPointMake(0.5f * size.width, size.height),
                                0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)appDefaultColor {
    return RGBColor(242.0f, 89.0f, 47.0f);
}

+ (UIColor *)appTableViewBgColor {
    return RGBColor(244.0f, 244.0f, 244.0f);
}

@end
