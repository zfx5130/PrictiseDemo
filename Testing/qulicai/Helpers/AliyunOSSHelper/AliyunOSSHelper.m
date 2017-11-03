//
//  AliyunOSSHelper.m
//  qulicai
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "AliyunOSSHelper.h"
#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSCompat.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonHMAC.h>
#import "UserUtil.h"
#import "User.h"

@implementation AliyunOSSHelper

- (void)updateImageToAliyunOSSWithImage:(UIImage *)image {
    
    //判断图片是不是png格式的文件
    NSData *imageData;
    UIImage *imageNew = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
    if (UIImagePNGRepresentation(image)) {
        imageData = UIImagePNGRepresentation(imageNew);
    } else {
        imageData = UIImageJPEGRepresentation(imageNew, 0.1);
    }
    
    OSSPlainTextAKSKPairCredentialProvider *credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] init];
    credential.secretKey = QR_SECRET_KEY;
    credential.accessKey = QR_ACCESS_KEY;
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:QR_OSS_ENDPOSINT
                                         credentialProvider:credential];
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    put.bucketName = QR_OSS_BUCKET;
    NSString *objectKeys = [NSString stringWithFormat:@"qlc/user/%@.jpg",[self getTimeNow]];
    put.objectKey = objectKeys;
    put.uploadingData = imageData;
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    };
    
    OSSTask *putTask = [client putObject:put];
    [putTask continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
        task = [client presignPublicURLWithBucketName:@"qlc" withObjectKey:objectKeys];
       // NSLog(@"objectKey:%@",put.objectKey);
        if (!task.error) {
            NSLog(@"上传成功");
            if (self.successBlock) {
       //         NSLog(@":url:::::%@",task.result);
                self.successBlock(task.result, YES);
            }
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
            self.successBlock(task.result, NO);
        }
        return nil;
    }];
}

- (UIImage *)imageWithImageSimple:(UIImage*)image
                     scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)getTimeNow {
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i%@", date,last,[NSString getStringWithString:[UserUtil currentUser].userId]];
    NSLog(@"%@", timeNow);
    return timeNow;
}

@end
