//
//  UIColor+Custom.h
//  bike
//
//  Created by dev on 15/6/24.
//  Copyright (c) 2015年 yunzao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Custom)

- (UIColor *)getColor:(NSString *)hexColor;

+ (UIColor*)gradientFromColor:(UIColor*)fromColor
                      toColor:(UIColor*)toColor
                     withSize:(CGSize)size;

//242 89 47
+ (UIColor *)appDefaultColor;

//244 244 244
+ (UIColor *)appTableViewBgColor;

@end
