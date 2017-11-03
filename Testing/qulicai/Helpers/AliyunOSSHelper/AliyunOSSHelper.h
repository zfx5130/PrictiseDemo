//
//  AliyunOSSHelper.h
//  qulicai
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UploadSuccessBlock)(NSString *imageUrl, BOOL isSucceed);

@interface AliyunOSSHelper : NSObject

@property (copy, nonatomic) UploadSuccessBlock successBlock;

/**
 上传图片

 @param image 图片
 */
- (void)updateImageToAliyunOSSWithImage:(UIImage *)image;


/**
 *  压缩图片尺寸
 *
 *  @param image   图片
 *  @param newSize 大小
 *
 *  @return 真实图片
 */
- (UIImage *)imageWithImageSimple:(UIImage*)image
                     scaledToSize:(CGSize)newSize;

/**
 *  返回当前时间
 *
 *  @return return value description
 */
- (NSString *)getTimeNow;

@end
