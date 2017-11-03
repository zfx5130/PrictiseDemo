//
//  NSString+Addition.h
//  MMKB
//
//  Created by yangkun on 8/20/14.
//  Copyright (c) 2014 yangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

/////////////////////////////////////////
/// class methods
/////////////////////////////////////////

// 字符串是否为空
+(BOOL)isEmpty:(NSString *)string;

+(NSString *)getString:(id)object;

+(NSString *)getStringWithString:(NSString *)str;

// 从NSTimeInterval 变成time string
+(NSString *)timeStringFrom:(NSTimeInterval)fromTime;

// 剩余时间
+(NSString *)leftTimeString:(NSTimeInterval)leftTime;

// 剩余时间不变化
+(NSString *)leftTimeStringStatic:(NSTimeInterval)leftTime;

// 十六进制颜色值转换
+(UIColor *)colorWithHexColor:(NSString *)hexColor;

// time interval 变成 yyyy-MM-dd hh:mm:ss
+(NSString *)stringWithTimeInterval:(NSTimeInterval)time;

+(NSString *)postTimeString:(NSTimeInterval)time;

+(NSString *)imageDeviceName:(NSString *)imageName;

+(NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str;
+(NSString *)formateDate:(NSDate *)formatDate showDetail:(BOOL)showDetail;

/////////////////////////////////////////
/// instance methods
/////////////////////////////////////////

// yyyy-MM-dd hh:mm:ss
-(NSTimeInterval)stringToTimeInterval;
-(NSDate *)stringToDate;

// 检查email的格式是否正确
-(BOOL)isValidEmail;

// 检查手机号的格式是否正确
-(BOOL)isValidMobileNumber;

// 检查身份证号格式是否正确
-(BOOL)isValidIdNumber;

@end
