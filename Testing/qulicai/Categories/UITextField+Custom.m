//
//  UITextField+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "UITextField+Custom.h"
#import "UIImage+Custom.h"
#import "NSString+Custom.h"

@implementation UITextField (Custom)

- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName
                                size:self.font.pointSize];
}

- (void)setDefaultPadding:(BOOL)defaultPadding {
    self.leftPadding = 8.0f;
    self.rightPadding = 8.0f;
}

- (BOOL)defaultPadding {
    return NO;
}

- (void)setLeftPadding:(CGFloat)leftPadding {
    [self addLeftPaddingWithFloat:leftPadding];
}

- (void)setRightPadding:(CGFloat)rightPadding {
    [self addRightPaddingWithFloat:rightPadding];
}

- (CGFloat)leftPadding {
    return 0;
}

- (CGFloat)rightPadding {
    return 0;
}

- (void)addLeftPaddingWithFloat:(CGFloat)padding {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                padding,
                                                                self.frame.size.height)];
    if (self.leftView) {
        self.leftView.frame = leftView.frame;
    } else {
        self.leftView = leftView;
    }
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)addRightPaddingWithFloat:(CGFloat)padding {
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - padding,
                                                                 0,
                                                                 padding,
                                                                 self.frame.size.height)];
    if (self.rightView) {
        self.rightView.frame = rightView.frame;
    } else {
        self.rightView = rightView;
    }
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (NSString *)leftLabelTitle {
    return nil;
}

- (NSString *)rightImageName {
    return nil;
}

- (void)setLeftLabelTitle:(NSString *)leftLabelTitle {
    CGSize size = [NSString sizeForFont:[UIFont systemFontOfSize:16.0f]
                                   text:NSLocalizedString(leftLabelTitle, nil)
                                maxSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                               0.0f,
                                                               size.width + 8.0f,
                                                               self.frame.size.height)];
    label.text = NSLocalizedString(leftLabelTitle, nil);
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor redColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    
    UIView *leftView = [[UIView alloc] initWithFrame:label.frame];
    [leftView addSubview:label];
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    [self updateHorizontalPaddings];
}

- (void)setRightImageName:(NSString *)rightImageName {
    UIImage *image = [UIImage imageNamed:rightImageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f,
                              0.0f,
                              30.0f,
                              image.size.height);
    [button setImage:image
            forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(touchRightButton:)
     forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    self.rightView = button;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (BOOL)toggledSecureEntry {
    return NO;
}

- (void)touchRightButton:(UIButton *)sender {
    [self becomeFirstResponder];
}

- (void)setToggledSecureEntry:(BOOL)toggledSecureEntry {
    if (!toggledSecureEntry) {
        return;
    }
    UIImage *image = [UIImage imageNamed:@"secure_text_entry_Image"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f,
                              0.0f,
                              image.size.width,
                              image.size.height);
    self.secureTextEntry = YES;
    [button setImage:image
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"no_secure_text_entry_Image"]
            forState:UIControlStateSelected];
    [button addTarget:self
               action:@selector(toggleSecureEntry:)
     forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    
    UIView *rightView = [[UIView alloc] initWithFrame:button.frame];
    [rightView addSubview:button];
    
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    [self updateHorizontalPaddings];
}

- (void)toggleSecureEntry:(UIButton *)button {
    button.selected = !button.selected;
    self.secureTextEntry = !button.selected;
}

- (UIColor *)placeHolderColor {
    return nil;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    if (![placeHolderColor isKindOfClass:[UIColor class]] || !self.placeholder.length) {
        return;
    }
//    UIColor *color = RGBAColor(201.0f, 211.0f, 221.0f, 0.54f);
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : placeHolderColor
                                 };
    self.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:self.placeholder
                                    attributes:attributes];
}

- (void)updateHorizontalPaddings {
    CGFloat maxPadding = MAX(CGRectGetWidth(self.leftView.frame), CGRectGetWidth(self.rightView.frame));
    self.leftPadding = maxPadding;
    self.rightPadding = maxPadding;
}

@end
