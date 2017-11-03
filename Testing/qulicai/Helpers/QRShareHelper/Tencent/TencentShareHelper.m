//
//  TencentShareHelper.m
//  zhixingche
//
//  Created by dev on 16/1/14.
//  Copyright © 2016年 yunzao. All rights reserved.
//

static NSString *kRequestResultSuccess = @"分享内容发送成功";
static NSString *kRequestResultNotInstalled = @"设备没有安装QQ";
static NSString *kRequestResultNotSupportApi = @"QQ不支持这个API";
static NSString *kRequestResultMessageTypeInvalid = @"信息类型无效";
static NSString *kRequestResultMessageContentNull = @"信息内容为空";
static NSString *kRequestResultMessageContentInvalid = @"信息内容无效";
static NSString *kRequestResultNotRegisterQQ = @"没有注册QQ";
static NSString *kRequestReusltShareAsync = @"异步分享";
static NSString *kRequestResultNotSupportErrorShow = @"QQ不支持错误展示";
static NSString *kRequestResultSendFail = @"分享内容发送失败";
static NSString *kRequestResultQzoneNotSupportTextType = @"qzone分享不支持text类型分享";
static NSString *kRequestResultQzoneNotSupportImage = @"qzone分享不支持image类型分享";

#import "TencentShareHelper.h"

@implementation TencentShareHelper

#pragma mark - Lifecycle

+ (instancetype)manager {
    static TencentShareHelper *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

#pragma mark - QQAPiInterfaceDelegate 

- (void)onReq:(QQBaseReq *)req {
    switch (req.type) {
        case EGETMESSAGEFROMQQREQTYPE: {
        }
            break;
        case ESENDMESSAGETOQQREQTYPE: {
        }
            break;
        case ESHOWMESSAGEFROMQQREQTYPE: {
        }
            break;
    }
}

- (void)onResp:(QQBaseResp *)resp {
    SendMessageToQQResp *sendResp = (SendMessageToQQResp *)resp;
    NSLog(@"请求处理结果::%@", sendResp.result);
}

- (void)isOnlineResponse:(NSDictionary *)response {

}

#pragma mark - Private

- (void)shareToTencentSenceWithSence:(TencentShareSence)shareSence
                  QQApiObject:(QQApiObject *)object {
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:object];
    QQApiSendResultCode code;
    switch (shareSence) {
        case TencentShareSenceQQ: {
            code = [QQApiInterface sendReq:request];
        }
            break;
        case TencentShareSenceQzone: {
            code = [QQApiInterface SendReqToQZone:request];
        }
            break;
    }
    NSString *result =  [self setupSendResultCode:code];
    NSLog(@"QQ分享后结果code:%@:::::result::::%@",@(code),result);
}

- (NSString *)setupSendResultCode:(QQApiSendResultCode)code {
    NSString *result;
    switch (code) {
        case EQQAPISENDSUCESS: {
            result = kRequestResultSuccess;
        }
            break;
        case EQQAPIQQNOTINSTALLED: {
            result = kRequestResultNotInstalled;
        }
            break;
        case EQQAPIQQNOTSUPPORTAPI: {
            result = kRequestResultNotSupportApi;
        }
            break;
        case EQQAPIMESSAGETYPEINVALID: {
            result = kRequestResultMessageTypeInvalid;
        }
            break;
        case EQQAPIMESSAGECONTENTNULL: {
            result = kRequestResultMessageContentNull;
        }
            break;
        case EQQAPIMESSAGECONTENTINVALID: {
            result = kRequestResultMessageContentInvalid;
        }
            break;
        case EQQAPIAPPNOTREGISTED: {
            result = kRequestResultNotRegisterQQ;
        }
            break;
        case EQQAPIAPPSHAREASYNC: {
            result = kRequestReusltShareAsync;
        }
            break;
        case EQQAPIQQNOTSUPPORTAPI_WITH_ERRORSHOW: {
            result = kRequestResultNotSupportErrorShow;
        }
            break;
        case EQQAPISENDFAILD: {
            result = kRequestResultSendFail;
        }
            break;
        case EQQAPIQZONENOTSUPPORTTEXT: {
            result = kRequestResultQzoneNotSupportTextType;
        }
            break;
        case EQQAPIQZONENOTSUPPORTIMAGE: {
            result = kRequestResultQzoneNotSupportImage;
        }
            break;
    }
    return result;
}

#pragma mark - Public

- (void)shareTextWithText:(NSString *)text {
    QQApiTextObject *textObject = [QQApiTextObject objectWithText:text];
    [self shareToTencentSenceWithSence:TencentShareSenceQQ
                    QQApiObject:textObject];
}

- (void)shareImageWithImageData:(NSData *)imageData
               previewImageData:(NSData *)previewImageData
                          title:(NSString *)title
                    description:(NSString *)description {
    QQApiImageObject *imageObject = [QQApiImageObject objectWithData:imageData
                                                    previewImageData:previewImageData
                                                               title:title
                                                         description:description];
    [self shareToTencentSenceWithSence:TencentShareSenceQQ
                           QQApiObject:imageObject];
}

- (void)shareImagesToQQCollectWithImageData:(NSData *)imageData
                           previewImageData:(NSData *)previewImageData
                                      title:(NSString *)title
                                description:(NSString *)description
                             imageDataArray:(NSArray<NSData *> *)imageDataArray {
    QQApiImageObject *imageObject = [QQApiImageObject objectWithData:imageData
                                                    previewImageData:previewImageData
                                                               title:title
                                                         description:description
                                                      imageDataArray:imageDataArray];
    [imageObject setCflag:kQQAPICtrlFlagQQShareFavorites];
    [self shareToTencentSenceWithSence:TencentShareSenceQQ
                    QQApiObject:imageObject];
}

- (void)shareNewsWithURL:(NSURL *)url
                   title:(NSString *)title
             description:(NSString *)description
         previewImageURL:(NSURL *)previewImageURL
              shareSence:(TencentShareSence)shareSence {
 
    QQApiNewsObject *newsObject = [QQApiNewsObject objectWithURL:url
                                                           title:title
                                                     description:description
                                                 previewImageURL:previewImageURL];
    [self shareToTencentSenceWithSence:shareSence
                           QQApiObject:newsObject];
}

- (void)shareNewsWithURL:(NSURL *)url
                   title:(NSString *)title
             description:(NSString *)description
        previewImageData:(NSData *)previewImageData
              shareSence:(TencentShareSence)shareSence {
    QQApiNewsObject *newsObject = [QQApiNewsObject objectWithURL:url
                                                           title:title
                                                     description:description
                                                previewImageData:previewImageData];
    [self shareToTencentSenceWithSence:shareSence
                           QQApiObject:newsObject];
}

- (void)shareMediaWithURl:(NSURL *)url
                    title:(NSString *)title
              description:(NSString *)description
          previewImageURL:(NSURL *)previewImageURL
                 mediaURL:(NSURL *)mediaURL
               shareSence:(TencentShareSence)shareSence
                shareType:(TencentShareType)shareType {
    QQApiObject *object;
    switch (shareType) {
        case TencentShareTypeAudio: {
            
            object = [QQApiAudioObject objectWithURL:url
                                              titlfe:title
                                         description:description
                                     previewImageURL:previewImageURL];
            [((QQApiAudioObject *)object) setFlashURL:mediaURL];
        }
            break;
        case TencentShareTypeVideo: {
            object = [QQApiVideoObject objectWithURL:url
                                               title:title
                                         description:description
                                     previewImageURL:previewImageURL];
            [((QQApiVideoObject *)object) setFlashURL:mediaURL];
        }
            break;
    }
    [self shareToTencentSenceWithSence:shareSence
                           QQApiObject:object];
}

- (void)shareMediaWithURl:(NSURL *)url
                    title:(NSString *)title
              description:(NSString *)description
         previewImageData:(NSData *)previewImageData
                 mediaURL:(NSURL *)mediaURL
               shareSence:(TencentShareSence)shareSence
                shareType:(TencentShareType)shareType {
    QQApiObject *object;
    switch (shareType) {
        case TencentShareTypeAudio: {
            object = [QQApiAudioObject objectWithURL:url
                                               title:title
                                         description:description
                                    previewImageData:previewImageData];
            [((QQApiAudioObject *)object) setFlashURL:mediaURL];
        }
            break;
        case TencentShareTypeVideo: {
            object = [QQApiVideoObject objectWithURL:url
                                               title:title
                                         description:description
                                    previewImageData:previewImageData];
            [((QQApiVideoObject *)object) setFlashURL:mediaURL];
        }
            break;
    }
    [self shareToTencentSenceWithSence:shareSence
                           QQApiObject:object];
}

@end
