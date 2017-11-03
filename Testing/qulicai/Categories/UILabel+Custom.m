//
//  UILabel+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "UILabel+Custom.h"
#import "NSString+Custom.h"

@implementation UILabel (Custom)

- (NSString *)translateKey {
    return nil;
}

- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName
                                size:self.font.pointSize];
}

- (CGSize)sizeForFont:(UIFont *)font
                 text:(NSString *)text {
    CGSize textSize;
    if ([text respondsToSelector:@selector(sizeWithAttributes:)]) {
        textSize = [text sizeWithAttributes:@{
                                              NSFontAttributeName : font
                                              }];
    }
    return textSize;
}

- (void)addFont:(UIFont *)font
        forText:(NSString *)text {
    if (!font || !text.length) {
        return;
    }
    NSMutableDictionary *attributes = [@{
                                        NSFontAttributeName : font
                                        } mutableCopy];
    if (self.font.pointSize * 0.5f - font.pointSize > 0) {
        attributes[NSBaselineOffsetAttributeName] =
        @(self.font.pointSize * 0.5f - font.pointSize);
    }
    [self addAttributes:attributes
                forText:text];
}

- (void)addColor:(UIColor *)color
         forText:(NSString *)text {
    if (!color || !text.length) {
        return;
    }
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : color
                                 };
    [self addAttributes:attributes
                forText:text];
}

- (void)addAttributes:(NSDictionary *)attributes
              forText:(NSString *)text {
    NSAttributedString *attributedString =
    [self.text attributedString:attributes
                        forText:text];
    self.attributedText = attributedString;
}

- (void)addAttributes:(NSDictionary *)attributes
              forText:(NSString *)text
        compareOption:(NSStringCompareOptions)compareOption {
    NSAttributedString *attributedString =
    [self.text attributedString:attributes
                        forText:text
                  compareOption:compareOption];
    self.attributedText = attributedString;
}

- (void)addFontGradientLayerWithColors:(NSArray *)colors
                             superView:(UIView *)superView {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.frame;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [superView.layer addSublayer:gradientLayer];
    gradientLayer.mask = self.layer;
    self.frame = gradientLayer.bounds;
}

- (void)addColor:(UIColor *)color
forAttributedText:(NSString *)text {
    if (!color || !text.length) {
        return;
    }
    NSMutableAttributedString *attString =
    [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange colorRange = [self.text rangeOfString:text];
    [attString addAttribute:NSForegroundColorAttributeName
                      value:color
                      range:colorRange];
    self.attributedText = attString;
}

- (void)addFont:(UIFont *)font
forAttributeText:(NSString *)text {
    if (!font || !text.length) {
        return;
    }
    NSMutableAttributedString *attString =
    [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange colorRange = [self.text rangeOfString:text];
    [attString addAttribute:NSFontAttributeName
                      value:font
                      range:colorRange];
    self.attributedText = attString;
}

- (void)addStrikeLineWithStr:(NSString *)str {
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
    self.attributedText = attribtStr;
}

- (void)addUnderLineWithStr:(NSString *)str {
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
    self.attributedText = attribtStr;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label
                      WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label
                      WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label
              withLineSpace:(float)lineSpace
                  WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

@end
