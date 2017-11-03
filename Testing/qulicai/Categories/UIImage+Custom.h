//
//  UIImage+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^ImageBlock)(UIImage *image, NSError *error);

@interface UIImage (Custom)

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)QRCodeImageFromContent:(NSString *)content
                               size:(CGSize)size;

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

+ (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur;

+ (UIImage *)imageWithName:(NSString *)name
             renderingMode:(UIImageRenderingMode)renderingMode;

+ (UIImage *)imageWithCaptureView:(UIView *)theView;

+ (UIImage *)imageWithImageOne:(UIImage *)imageOne
                      imageTwo:(UIImage *)imageTwo;

+ (UIImage *)imageGradientFromColors:(NSArray *)colors bounds:(CGRect)bounds;

+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;

+ (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(CGFloat)dWidth height:(CGFloat)dHeight;

+ (UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;

+ (UIImage *)dataURL2Image:(NSString *)imgSrc;
@end
