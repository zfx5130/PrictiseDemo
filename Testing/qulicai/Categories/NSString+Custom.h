//
//  NSString+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Custom)

+ (NSString *)currentRegion;
+ (NSString *)currentLanguage;
+ (NSString *)localizedURLString:(NSString *)URLString;
+ (NSString *)sha1:(NSString *)input;
+ (NSString *)md5:(NSString *)input;
+ (NSString *)nonNullStringForObject:(id )object;

- (void)call;
+ (NSString *)stringFromObject:(id)object;

- (BOOL)checkEmailWithAlert;
- (BOOL)checkEmailWithAlert:(BOOL)alert;

+ (NSString *)getBinaryByhex:(NSString *)hex;

+ (CGSize)sizeForFont:(UIFont *)font
                 text:(NSString *)text
              maxSize:(CGSize)maxSize;

+ (CGSize)sizeForFont:(UIFont *)font
                 text:(NSString *)text;

- (NSAttributedString *)attributedString:(NSDictionary *)attributes
                                 forText:(NSString *)text;

- (BOOL)containsText:(NSString *)text;

- (NSAttributedString *)attributedString:(NSDictionary *)attributes
                                 forText:(NSString *)text
                           compareOption:(NSStringCompareOptions)compareOption;

+ (NSString *)stringDataWithJsonData:(id)data;

+ (NSString *)replaceStrWithRange:(NSRange)range
                           string:(NSString *)content
                       withString:(NSString *)replaceString;


+ (NSString *)addDotWithString:(NSString *)string;

+ (NSString *)countNumAndChangeformat:(NSString *)num;

+ (NSString*)getCurrentTimestamp;

+ (NSString *)UIImageToBase64Str:(UIImage *)image;

+ (NSString *)image2DataURL:(UIImage *)image;

+ (NSString *)timeStamp;

//MD5 32位 大写加密 小写x
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString;

//字典转json格式字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//获取MM-dd格式时间
+ (NSString *)getMMddDateStringWithTimeString:(NSString *)time;

+ (NSString *)getyyyyMMddDateStringWithTimeString:(NSString *)time;

@end
