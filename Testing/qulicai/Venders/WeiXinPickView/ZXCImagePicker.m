//
//  ZXCImageAcquireHelper.m
//  zhixingche
//
//  Created by dev on 15/11/24.
//  Copyright © 2015年 yunzao. All rights reserved.
//

static void *WarningAlertViewKey = @"WarningAlertViewKey";
static void *PermissionAlertViewKey = @"PermissionAlertViewKey";

#import "ZXCImagePicker.h"
#import "WeiXinPickView.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <objc/runtime.h>

@interface ZXCImagePicker ()
<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

@implementation ZXCImagePicker

#pragma mark - Public

- (void)showImagePickerWithController:(UIViewController *)viewController {

    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
        [self addAlertViewWithTitle:@"相册"];
        return;
    }
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        [self addAlertViewWithTitle:@"相机"];
        return;
    }
    WeiXinPickView *pickView = [[WeiXinPickView alloc] init];
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:SCREEN_RECT];
        [self.window addSubview:pickView];
    }
    [self.window makeKeyAndVisible];
    __weak typeof(self) weakSelf = self;
    pickView.clickBlock = ^(UIImage *image, PickPictureEvent event){
        [weakSelf dismissWindow];
        switch (event) {
            case PickPictureSendPicture: {
                if (self.pickerBlock) {
                    self.pickerBlock(image);
                }
            }
                break;
            case PickPictureTakePhoto: {
                [weakSelf openCameraWithController:viewController];
            }
                break;
            case PickPictureChoosePicture: {
                [weakSelf showAlbumWithController:viewController];
            }
                break;
            case PickPictureCancel: {
            }
                break;
        }
    };
    
    [pickView presentBlock:^(BOOL Complete) {
        
    }];
}

#pragma mark - Private


- (void)addAlertViewWithTitle:(NSString *)title {
    NSString *titleString =
    [NSString stringWithFormat:@"程序暂无权限访问你的%@,请打开相应的访问权限",title];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:titleString
                                                       delegate:self
                                              cancelButtonTitle:@"去设置"
                                              otherButtonTitles:@"否",nil];
    __weak typeof(self) weakSelf = self;
    void(^PermissionBlock)(NSInteger) = ^(NSInteger buttonIndex) {
        if (!buttonIndex) {
            [weakSelf openSettingsView];
        }
    };
    objc_setAssociatedObject(alertView,
                             PermissionAlertViewKey,
                             PermissionBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    [alertView show];
}

- (void)openSettingsView {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

//是否有摄像头
- (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

//前置摄像头是否可用
- (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

//后置摄像头是否可用
- (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//判断多媒体类型:视频,拍照
- (BOOL)cameraSupportsMedia:(NSString *)mediaType
                 sourceType:(UIImagePickerControllerSourceType)sourceType {
    if (!mediaType.length) {
        return NO;
    }
    NSArray *availableMediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    __block BOOL result = NO;
    [availableMediaTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *mediaTypeString = (NSString *)obj;
        if ([mediaTypeString isEqualToString:mediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

//是否支持拍照
- (BOOL)cameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(NSString *)kUTTypeImage
                          sourceType:UIImagePickerControllerSourceTypeCamera];
}

//是否支持录像
- (BOOL)cameraSupportShootingVideos {
    return [self cameraSupportsMedia:(NSString *)kUTTypeVideo
                          sourceType:UIImagePickerControllerSourceTypeCamera];
}

//相册是否可用
- (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

//是否可以在相册中选择图片
- (BOOL)canUserPickVideosFromPhotoLibrary {
    return [self cameraSupportsMedia:(NSString *)kUTTypeVideo
                          sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

//是否可以在相册中选择视频
- (BOOL)canUserPickPhotosFromPhotoLibrary {
    return [self cameraSupportsMedia:(NSString *)kUTTypeImage
                          sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}


- (void)dismissWindow {
    self.window = nil;
}

- (void)openCameraWithController:(UIViewController *)viewController {
    if ([self isCameraAvailable] && [self cameraSupportTakingPhotos]) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        NSArray *mediaTypes = @[(NSString *)kUTTypeImage];
        pickerController.mediaTypes = mediaTypes;
        pickerController.delegate = self;
        pickerController.allowsEditing = YES;
        [viewController presentViewController:pickerController
                                     animated:YES
                                   completion:nil];
    } else {
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"警告"
                                   message:@"未检测到摄像头"
                                  delegate:self
                         cancelButtonTitle:nil
                         otherButtonTitles:@"确认", nil];
        __weak typeof(self) weakSelf = self;
        void(^warningBlock)(NSInteger) = ^(NSInteger buttonIndex) {
            if (!buttonIndex) {
                [weakSelf showAlbumWithController:viewController];
            }
        };
        objc_setAssociatedObject(alertView,
                                 WarningAlertViewKey,
                                 warningBlock,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
        [alertView show];
    }
}

- (void)showAlbumWithController:(UIViewController *)viewController {
    if ([self isPhotoLibraryAvailable] && [self canUserPickPhotosFromPhotoLibrary]) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        if ([self canUserPickPhotosFromPhotoLibrary]) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        pickerController.mediaTypes = mediaTypes;
        pickerController.delegate = self;
        pickerController.allowsEditing = YES;
        [viewController presentViewController:pickerController
                                     animated:YES
                                   completion:nil];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
    void(^warningBlock)(NSInteger) = objc_getAssociatedObject(alertView,
                                                              WarningAlertViewKey);
    if (warningBlock) {
        warningBlock(buttonIndex);
    }

    void(^PermissionBlock)(NSInteger) = objc_getAssociatedObject(alertView,
                                                                 PermissionAlertViewKey);
    if (PermissionBlock) {
        PermissionBlock(buttonIndex);
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        if ([picker allowsEditing]) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        if (self.pickerBlock) {
            self.pickerBlock(image);
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"不支持此类型"];
    }
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}

@end
