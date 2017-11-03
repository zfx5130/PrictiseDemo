//
//  UILabel+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)

@property (nonatomic, copy) NSString *fontName;

- (CGSize)sizeForFont:(UIFont *)font
                 text:(NSString *)text;

- (void)addFont:(UIFont *)font
        forText:(NSString *)text;

- (void)addColor:(UIColor *)color
         forText:(NSString *)text;

- (void)addAttributes:(NSDictionary *)attributes
              forText:(NSString *)text;

- (void)addAttributes:(NSDictionary *)attributes
              forText:(NSString *)text
        compareOption:(NSStringCompareOptions)compareOption;

- (void)addFontGradientLayerWithColors:(NSArray *)colors
                             superView:(UIView *)superView;

- (void)addColor:(UIColor *)color
    forAttributedText:(NSString *)text;

- (void)addFont:(UIFont *)font
forAttributeText:(NSString *)text;

//中划线
- (void)addStrikeLineWithStr:(NSString *)str;

//下划线
- (void)addUnderLineWithStr:(NSString *)str;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label
                      WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label
                      WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label
              withLineSpace:(float)lineSpace
                  WordSpace:(float)wordSpace;


@end
