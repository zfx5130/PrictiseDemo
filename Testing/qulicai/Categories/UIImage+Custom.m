//
//  UIImage+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "UIImage+Custom.h"

@implementation UIImage (Custom)

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [UIImage imageWithColor:color
                              size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)QRCodeImageFromContent:(NSString *)content
                               size:(CGSize)size {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data
              forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1.0f
                                   orientation:UIImageOrientationUp];
    
    
    UIGraphicsBeginImageContext(size);
    CGContextRef resizedContext = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(resizedContext, kCGInterpolationNone);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return resizedImage;
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter =
    [CIFilter filterWithName:@"CIGaussianBlur"
               keysAndValues:kCIInputImageKey, inputImage,@"inputRadius", @(blur),nil];
    
    CIImage *outputImage = filter.outputImage;
    CGImageRef outImage = [context createCGImage:outputImage
                                        fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

+ (UIImage *)imageWithName:(NSString *)name
             renderingMode:(UIImageRenderingMode)renderingMode {
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:renderingMode];
    return image;
}

+ (UIImage *)imageWithCaptureView:(UIView *)theView {
    CGRect rect = theView.frame;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(rect.size , NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithImageOne:(UIImage *)imageOne
                      imageTwo:(UIImage *)imageTwo {
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(imageOne.size, NO, scale);
    [imageOne drawInRect:CGRectMake(0, 0, imageOne.size.width, imageOne.size.height)];
    [imageTwo drawInRect:CGRectMake(0, 0, imageTwo.size.width, imageTwo.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)imageGradientFromColors:(NSArray *)colors bounds:(CGRect)bounds{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return gradientImage;
}

+ (UIImage *)imageGradientFromColors:(NSArray *)colors
                              bounds:(CGRect)bounds
                        shadowOffset:(CGSize)shadowOffset {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    UIGraphicsBeginImageContext(gradientLayer.bounds.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return gradientImage;
}

+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr {
    if (!_encodedImageStr.length) {
        return nil;
    }
    NSData *_decodedImageData =
    [[NSData alloc] initWithBase64EncodedString:_encodedImageStr
                                        options:0];
    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}

+ (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(CGFloat)dWidth height:(CGFloat)dHeight {
    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
    imageCope = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCope;
}

+ (UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb {
    if (!image) {
        return image;
    }
    if (kb<1) {
        return image;
    }
    kb*=1024;
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

+ (UIImage *)dataURL2Image:(NSString *)imgSrc {
    NSURL *url = [NSURL URLWithString: imgSrc];
    NSData *data = [NSData dataWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData: data];
    return image;
}

@end
