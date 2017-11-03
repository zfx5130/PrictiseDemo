//
//  UIView+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

static NSUInteger const kBorderTagTop = 2122;
static NSUInteger const kBorderTagBottom = 2123;
static NSUInteger const kBorderTagLeft = 2124;
static NSUInteger const kBorderTagRight = 2125;

#import "UIView+Custom.h"

@implementation UIView (Custom)

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return nil;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = [self borderWidthWithScale:borderWidth];
}

- (CGFloat)borderWidth {
    return 0;
}

- (void)setDefaultBorder:(BOOL)defaultBorder {
    if (defaultBorder) {
        self.layer.borderWidth = [self borderWidthWithScale:kDefaultBorderWidth];
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
}

- (BOOL)defaultBorder {
    return NO;
}

- (CGFloat)radius {
    return self.layer.cornerRadius;
}

- (void)setRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
}

- (void)addDefaultLineAtEdge:(BorderEdge)edge {
    [self addLineAtEdge:edge
                  color:[UIColor redColor]
                  width:kDefaultBorderWidth];
}

- (void)addLinesExcludingEdge:(BorderEdge)edge {
    [self addLinesExcludingEdge:edge
                          color:[UIColor redColor]
                          width:kDefaultBorderWidth];
}

- (void)addLinesExcludingEdge:(BorderEdge)edge
                        color:(UIColor *)color
                        width:(CGFloat)width {
    NSArray *edges = @[
                       @(BorderEdgeTop),
                       @(BorderEdgeBottom),
                       @(BorderEdgeLeft),
                       @(BorderEdgeRight)
                       ];
    for (id edgeObject in edges) {
        if ([edgeObject integerValue] != edge) {
            [self addLineAtEdge:[edgeObject integerValue]
                          color:color
                          width:width];
        }
    }
}

- (void)addLineAtEdge:(BorderEdge)edge
                color:(UIColor *)color
                width:(CGFloat)width {
    CGSize viewSize = self.frame.size;
    UIView *line = [[UIView alloc] init];
    CGRect lineRect;
    UIViewAutoresizing autoresizing;
    NSUInteger tag;
    switch (edge) {
        case BorderEdgeTop:
            lineRect = CGRectMake(0, 0,
                                  viewSize.width, width);
            autoresizing = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
            tag = kBorderTagTop;
            break;
        case BorderEdgeBottom:
            lineRect = CGRectMake(0, viewSize.height - width,
                                  viewSize.width, width);
            autoresizing = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
            tag = kBorderTagBottom;
            break;
        case BorderEdgeLeft:
            lineRect = CGRectMake(0, 0,
                                  width, viewSize.height);
            autoresizing = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
            tag = kBorderTagLeft;
            break;
        case BorderEdgeRight:
            lineRect = CGRectMake(viewSize.width - width, 0,
                                  width, viewSize.height);
            autoresizing = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
            tag = kBorderTagRight;
            break;
        default:
            break;
    }
    
    BOOL hasLine = [self viewWithTag:tag] != nil;
    if (hasLine) {
        line = [self viewWithTag:tag];
    }
    
    line.frame = lineRect;
    line.autoresizingMask = autoresizing;
    line.backgroundColor = color;
    line.tag = tag;
    
    if (!hasLine) {
        [self addSubview:line];
    }
}

- (void)removeAllEdgeLines {
    NSArray *edgeLineTags = @[
                              @(kBorderTagTop),
                              @(kBorderTagLeft),
                              @(kBorderTagRight),
                              @(kBorderTagBottom)
                              ];
    for (NSNumber *tag in edgeLineTags) {
        UIView *view = [self viewWithTag:[tag integerValue]];
        if (view) {
            [view removeFromSuperview];
        }
    }
}

- (void)addTapGestureForDismissingKeyboard {
    [self addTapGestureForDismissingKeyboardCancelsInView:YES];
}

- (void)addTapGestureForDismissingKeyboardCancelsInView:(BOOL)cancelsInView {
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(dismissKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.cancelsTouchesInView = cancelsInView;
    [self addGestureRecognizer:tapGesture];
}

#pragma mark - Helpers

- (void)dismissKeyboard {
    [self endEditing:YES];
}

- (CGFloat)borderWidthWithScale:(CGFloat)width {
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat convertedWidth;
    
    // HD retina screen (e.g. iPhone 6 Plus)
    if (fabs(scale) > fabs(2.0f)) {
        convertedWidth = width;
        
    // retina screen
    } else if (fabs(scale) == fabs(2.0)) {
        convertedWidth = width;
        
    // non-retina screen
    } else {
        convertedWidth = width * 2.0f;
    }
    return convertedWidth;
}

- (void)addShadowWithShadowRadius:(CGFloat)shadowRadius
                        withColor:(UIColor *)color {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowPath = shadowPath.CGPath;
    self.backgroundColor = [UIColor clearColor];
}

-(void)addShakeAnimation {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = self.transform.tx;
    
    //    animation.delegate = self;
    animation.duration = 0.5;
    animation.values = @[ @(currentTx), @(currentTx + 10), @(currentTx-8), @(currentTx + 8), @(currentTx -5), @(currentTx + 5), @(currentTx) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"kAFViewShakerAnimationKey"];
    
}

@end
