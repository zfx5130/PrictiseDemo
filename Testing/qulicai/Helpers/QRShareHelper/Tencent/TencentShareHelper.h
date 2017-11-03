//
//  TencentShareHelper.h
//  zhixingche
//
//  Created by dev on 16/1/14.
//  Copyright © 2016年 yunzao. All rights reserved.
//

typedef enum : NSUInteger {
    /**
     *  分享到QQ
     */
    TencentShareSenceQQ,
    
    /**
     *  分享到空间
     */
    TencentShareSenceQzone
    
} TencentShareSence;

typedef enum : NSUInteger {
    /**
     *  音频分享
     */
    TencentShareTypeAudio,
    /**
     *  视频分享
     */
    TencentShareTypeVideo
    
} TencentShareType;

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface TencentShareHelper : NSObject <QQApiInterfaceDelegate>

+ (instancetype)manager;

/**
 *  纯文本分享(QQ)
 *
 *  @param text 分享文本内容
 */
- (void)shareTextWithText:(NSString *)text;

/**
 *  纯图片分享(QQ)
 *
 *  @param imageData        image data
 *  @param previewImageData preview data
 *  @param title            title
 *  @param description      description
 */
- (void)shareImageWithImageData:(NSData *)imageData
               previewImageData:(NSData *)previewImageData
                          title:(NSString *)title
                    description:(NSString *)description;

/**
 *  多图分享至QQ收藏(QQ)
 *
 *  @param imageData        image data
 *  @param previewImageData preview image data
 *  @param title            title
 *  @param description      description
 *  @param imageDataArray       image data array
 */
- (void)shareImagesToQQCollectWithImageData:(NSData *)imageData
                           previewImageData:(NSData *)previewImageData
                                      title:(NSString *)title
                                description:(NSString *)description
                             imageDataArray:(NSArray<NSData *> *)imageDataArray;

/**
 *  新闻分享
 *
 *  @param url             分享跳转URL
 *  @param title           title
 *  @param description     description
 *  @param previewImageURL 预览图URL地址
 *  @param shareType       tencent share type
 */
- (void)shareNewsWithURL:(NSURL *)url
                   title:(NSString *)title
             description:(NSString *)description
         previewImageURL:(NSURL *)previewImageURL
              shareSence:(TencentShareSence)shareSence;

/**
 *  新闻分享
 *
 *  @param url              分享跳转URL
 *  @param title            title
 *  @param description      description
 *  @param previewImageData 预览图data
 *  @param shareSence       share sence
 */
- (void)shareNewsWithURL:(NSURL *)url
                   title:(NSString *)title
             description:(NSString *)description
        previewImageData:(NSData *)previewImageData
              shareSence:(TencentShareSence)shareSence;

/**
 *  媒体分享(音频/视频)
 *
 *  @param url             分享跳转url
 *  @param title           title
 *  @param description     description
 *  @param previewImageURL 分享预览图URL地址
 *  @param mediaURL        网络流媒体地址
 *  @param shareSence      shareSence
 *  @param shareType       shareType
 */
- (void)shareMediaWithURl:(NSURL *)url
                    title:(NSString *)title
              description:(NSString *)description
          previewImageURL:(NSURL *)previewImageURL
                 mediaURL:(NSURL *)mediaURL
               shareSence:(TencentShareSence)shareSence
                shareType:(TencentShareType)shareType;

/**
 *  媒体分享(音频/视频)
 *
 *  @param url              分享跳转url
 *  @param title            title
 *  @param description      description
 *  @param previewImageData 分享预览图data
 *  @param mediaURL         网络流媒体地址
 *  @param shareSence       share sence
 *  @param shareType        share type
 */
- (void)shareMediaWithURl:(NSURL *)url
                    title:(NSString *)title
              description:(NSString *)description
         previewImageData:(NSData *)previewImageData
                 mediaURL:(NSURL *)mediaURL
               shareSence:(TencentShareSence)shareSence
                shareType:(TencentShareType)shareType;

@end
