//
//  WeiXinPickView.h
//  WeiXinPickDemo
//
//  Created by chaos on 7/21/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PickPictureSendPicture,
    PickPictureTakePhoto,
    PickPictureChoosePicture,
    PickPictureCancel,
} PickPictureEvent;

typedef void(^CompleteAnimationBlock)(BOOL Complete);

typedef void(^ClickBlock)(UIImage *image, PickPictureEvent event);

@interface WeiXinPickView : UIView

@property (nonatomic,strong) NSMutableArray *selectedAssets; //当前选中

@property (nonatomic,copy) ClickBlock clickBlock; //点击事件

// view弹出
- (void)presentBlock:(CompleteAnimationBlock)block;
// view消失
- (void)dismissBlock:(CompleteAnimationBlock)block;

@end