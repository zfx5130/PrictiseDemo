//
//  ZXCImageAcquireHelper.h
//  zhixingche
//
//  Created by dev on 15/11/24.
//  Copyright © 2015年 yunzao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZXCImagePickerBlock)(UIImage *image);

@interface ZXCImagePicker : NSObject

@property (copy, nonatomic) ZXCImagePickerBlock pickerBlock;

- (void)showImagePickerWithController:(UIViewController *)viewController;

@end
