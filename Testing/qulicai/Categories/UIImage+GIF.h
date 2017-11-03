//
//  UIImage+GIF.h
//  SVProgressHUD
//
//  Created by hulinEasy on 2017/3/21.
//
//

#import <UIKit/UIKit.h>

typedef void (^GIFimageBlock)(UIImage *GIFImage);
@interface UIImage (GIF)

/** 根据本地GIF图片名 获得GIF image对象 */

+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */

+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */

+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;


+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;


@end
