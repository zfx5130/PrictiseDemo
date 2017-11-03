//
//  UITextView+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "UITextView+Custom.h"

@implementation UITextView (Custom)

- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName
                                size:self.font.pointSize];
}

- (NSString *)placeHolder {
    return nil;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    self.delegate = self;
}

- (UIColor *)placeHolderColor
{
    return nil;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    self.delegate = self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placeHolder]) {
        textView.text = nil;
        textView.textColor = self.textColor;
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (!textView.text.length) {
        textView.text = self.placeHolder;
        textView.textColor = self.placeHolderColor ? self.placeHolderColor : [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

@end
