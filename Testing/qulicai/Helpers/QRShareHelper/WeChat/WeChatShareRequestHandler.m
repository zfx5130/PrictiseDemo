//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 15/7/14.
//
//

#import "WXApi.h"
#import "WeChatShareRequestHandler.h"
#import "WeChatAPIManager.h"
#import "SendMessageToWeChatRequest.h"
#import "WXMediaMessage+messageConstruct.h"

@implementation WeChatShareRequestHandler

#pragma mark - Public Methods

+ (BOOL)sendText:(NSString *)text
         InScene:(enum WXScene)scene {
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:text
                                 OrMediaMessage:nil
                                          bText:YES
                                        InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendImageData:(NSData *)imageData
              TagName:(NSString *)tagName
           MessageExt:(NSString *)messageExt
               Action:(NSString *)action
           ThumbImage:(UIImage *)thumbImage
              InScene:(enum WXScene)scene {
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage messageWithTitle:nil
                                                   Description:nil
                                                        Object:ext
                                                    MessageExt:messageExt
                                                 MessageAction:action
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:nil
                                 OrMediaMessage:message
                                          bText:NO
                                        InScene:scene];
    
    return [WXApi sendReq:req];
}

+ (BOOL)sendImageURL:(NSString *)imageURL
             TagName:(NSString *)tagName
          MessageExt:(NSString *)messageExt
              Action:(NSString *)action
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene {
    WXImageObject *ext = [WXImageObject object];
    ext.imageUrl = imageURL;
    
    WXMediaMessage *message = [WXMediaMessage messageWithTitle:nil
                                                   Description:nil
                                                        Object:ext
                                                    MessageExt:messageExt
                                                 MessageAction:action
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:nil
                                 OrMediaMessage:message
                                          bText:NO
                                        InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendLinkURL:(NSString *)urlString
            TagName:(NSString *)tagName
              Title:(NSString *)title
        Description:(NSString *)description
         ThumbImage:(UIImage *)thumbImage
            InScene:(enum WXScene)scene {
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;

    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:nil
                                                 MessageAction:nil
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:nil
                                 OrMediaMessage:message
                                          bText:NO
                                        InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendMusicURL:(NSString *)musicURL
             dataURL:(NSString *)dataURL
               Title:(NSString *)title
         Description:(NSString *)description
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene {
    WXMusicObject *ext = [WXMusicObject object];
    ext.musicUrl = musicURL;
    ext.musicDataUrl = dataURL;

    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:nil
                                                 MessageAction:nil
                                                    ThumbImage:thumbImage
                                                      MediaTag:nil];
    
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:nil
                                 OrMediaMessage:message
                                          bText:NO
                                        InScene:scene];
    
    return [WXApi sendReq:req];
}

+ (BOOL)sendVideoURL:(NSString *)videoURL
               Title:(NSString *)title
         Description:(NSString *)description
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];
    
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = videoURL;
    
    message.mediaObject = ext;
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:nil
                                 OrMediaMessage:message
                                          bText:NO
                                        InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendEmotionData:(NSData *)emotionData
             ThumbImage:(UIImage *)thumbImage
                InScene:(enum WXScene)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:thumbImage];
    
    WXEmoticonObject *ext = [WXEmoticonObject object];
    ext.emoticonData = emotionData;
    
    message.mediaObject = ext;
    
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:nil
                                 OrMediaMessage:message
                                          bText:NO
                                        InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendFileData:(NSData *)fileData
       fileExtension:(NSString *)extension
               Title:(NSString *)title
         Description:(NSString *)description
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];
    
    WXFileObject *ext = [WXFileObject object];
    ext.fileExtension = @"pdf";
    ext.fileData = fileData;
    
    message.mediaObject = ext;
    
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:nil
                                 OrMediaMessage:message
                                          bText:NO
                                        InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendAppContentData:(NSData *)data
                   ExtInfo:(NSString *)info
                    ExtURL:(NSString *)url
                     Title:(NSString *)title
               Description:(NSString *)description
                MessageExt:(NSString *)messageExt
             MessageAction:(NSString *)action
                ThumbImage:(UIImage *)thumbImage
                   InScene:(enum WXScene)scene {
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = info;
    ext.url = url;
    ext.fileData = data;

    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:messageExt
                                                 MessageAction:action
                                                    ThumbImage:thumbImage
                                                      MediaTag:nil];
    
    SendMessageToWeChatRequest *req =
    [SendMessageToWeChatRequest requestWithText:nil
                                 OrMediaMessage:message
                                          bText:NO
                                        InScene:scene];
    return [WXApi sendReq:req];

}

@end
