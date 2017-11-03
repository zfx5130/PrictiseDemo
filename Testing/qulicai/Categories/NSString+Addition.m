//
//  NSString+Addition.m
//  MMKB
//
//  Created by yangkun on 8/20/14.
//  Copyright (c) 2014 yangkun. All rights reserved.
//

#import "NSString+Addition.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation NSString (Addition)

+(BOOL)isEmpty:(NSString *)string {
    if( string == nil ||
       string == NULL ||
       [string isKindOfClass:[NSNull class]] ||
       [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+(NSString *)getString:(id)object {
    if( [object isKindOfClass:[NSString class]] ) {
        return object;
    }
    
    if( [object isKindOfClass:[NSNull class]] ) {
        //NSLog(@"null cast warning for string");
        return @"";
    }
    
    return [object stringValue];
}

+(NSString *)getStringWithString:(NSString *)str {
    return [self isEmpty:str] ? @"" : str;
}

+(NSString *)timeStringFrom:(NSTimeInterval)fromTime {
    NSTimeInterval differ = [[NSDate date] timeIntervalSince1970] - fromTime;
    if(differ < 60) {
        return [NSString stringWithFormat:@"%d秒前", (int)differ];
    } else if( differ/60 < 60) {
        return [NSString stringWithFormat:@"%d分钟前", (int)differ/60];
    } else if( differ/3600 < 24) {
        return [NSString stringWithFormat:@"%d小时前", (int)differ/3600];
    } else if( differ/86400 < 365){
        return [NSString stringWithFormat:@"%d天前", (int)differ/86400];
    } else {
        return [NSString stringWithFormat:@"%d年前", (int)differ/(86400 * 365)];
    }
    return @"";
}


+(NSString *)leftTimeString:(NSTimeInterval)endTime {
    NSTimeInterval differ = endTime - [[NSDate date] timeIntervalSince1970];
    if( differ < 60 ) {
        return [NSString stringWithFormat:@"00天00小时00分%02d秒",(int)differ];
    } else if( differ/60 < 60 ) {
        int second = (int)differ % 60;
        int minute = (int)(differ / 60);
        return [NSString stringWithFormat:@"00天00小时%02d分%02d秒", minute, second];
    } else if( differ/3600 < 24) {
        int hour = differ / 3600;
        int minute = (int)(differ - hour*3600)/60;
        int second = ((int)differ - hour*3600)%60;
        return [NSString stringWithFormat:@"00天%02d小时%02d分%02d秒", hour, minute, second];
    } else {
        int day = differ / (3600*24);
        int hour = (differ - day*3600*24)/3600;
        int minute = (differ - day*3600*24 - hour*3600)/60;
        int second = ((int)differ - day*3600*24 - hour*3600)%60;
        return [NSString stringWithFormat:@"%02d天%02d小时%02d分%02d秒", day, hour, minute, second];
    }
    return @"";
}

+(NSString *)leftTimeStringStatic:(NSTimeInterval)leftTime {
    NSTimeInterval differ = leftTime - [[NSDate date] timeIntervalSince1970];
    if( differ < 60 ) {
        return [NSString stringWithFormat:@"剩余%d秒",(int)differ];
    } else if( differ/60 < 60 ) {
        int minute = (int)(differ / 60);
        return [NSString stringWithFormat:@"剩余%d分", minute];
    } else if( differ/3600 < 24) {
        int hour = differ / 3600;
        return [NSString stringWithFormat:@"剩余%d小时", hour];
    } else {
        int day = differ / (3600*24);
        return [NSString stringWithFormat:@"剩余%d天", day];
    }
    return @"";
}

// hex color 的格式 #ffffff
+(UIColor *)colorWithHexColor:(NSString *)hexColor {
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location =3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location =5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

+(NSString *)stringWithTimeInterval:(NSTimeInterval)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)postTimeString:(NSTimeInterval)time {
    NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval delta = current - time;
    if( delta < 60 ) {
        return @"刚刚";
    } else if( delta >= 60 && delta < 3600 ) {
        int minute = (int) delta/60;
        return [NSString stringWithFormat:@"%d分钟前", minute];
    } else if( delta >= 3600 && delta < 3600 *24 ) {
        int hour = (int) delta/3600;
        return [NSString stringWithFormat:@"%d小时前", hour];
    } else if( delta >= 3600*24 && delta < 3600 * 24 * 365 ) {
        int day = (int) delta / (3600*24);
        return [NSString stringWithFormat:@"%d天前", day];
    } else {
        return @"1年前";
    }
}

+(NSString *)imageDeviceName:(NSString *)imageName {
    if( IS_IPHONE_6 ) {
        imageName = [NSString stringWithFormat:@"%@_iphone6", imageName];
    } else if( IS_IPHONE_5 ) {
        imageName = [NSString stringWithFormat:@"%@_iphone5", imageName];
    }
    return imageName;
}

+(NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSRange range;
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    return results;
}

+(NSString *)formateDate:(NSDate *)formatDate showDetail:(BOOL)showDetail {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *fcomps = [calendar components:unitFlags fromDate:formatDate];
    
    NSDateComponents *nComps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger diffday = [nComps day] - [fcomps day];
    
    if( diffday == 0 ) {
        NSInteger hour = [fcomps hour];
        NSInteger min = [fcomps minute];
        
        return [NSString stringWithFormat:@"%02ld:%02ld", hour, min];
    } else {
        NSInteger year = [fcomps year];
        NSInteger month = [fcomps month];
        NSInteger day = [fcomps day];
        NSInteger hour = [fcomps hour];
        NSInteger min = [fcomps minute];
        
        if( showDetail ) {
            return [NSString stringWithFormat:@"%ld年%ld月%ld日 %02ld:%02ld", year, month, day, hour, min];
        } else {
            return [NSString stringWithFormat:@"%ld月%ld日", month, day];
        }
    }
    
    return @"";
}

-(NSDate *)stringToDate {
    NSString *timeString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *timeArray = [timeString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" -:"]];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = [[timeArray objectAtIndex:0] intValue];
    components.month = [[timeArray objectAtIndex:1] intValue];
    components.day = [[timeArray objectAtIndex:2] intValue];
    components.hour = [[timeArray objectAtIndex:3] intValue];
    components.minute = [[timeArray objectAtIndex:4] intValue];
    components.second = [[timeArray objectAtIndex:5] intValue];
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return date;
}

-(NSTimeInterval)stringToTimeInterval {
    if( [NSString isEmpty:self] ) {
        return [[NSDate date] timeIntervalSince1970];
    } else {
        NSString *timeString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *timeArray = [timeString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" -:"]];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year = [[timeArray objectAtIndex:0] intValue];
        components.month = [[timeArray objectAtIndex:1] intValue];
        components.day = [[timeArray objectAtIndex:2] intValue];
        components.hour = [[timeArray objectAtIndex:3] intValue];
        components.minute = [[timeArray objectAtIndex:4] intValue];
        components.second = [[timeArray objectAtIndex:5] intValue];
        
        NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
        
        return [date timeIntervalSince1970];
    }
}

//利用正则表达式验证
-(BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

// 正则判断手机号码地址格式
- (BOOL)isValidMobileNumber
{
    // 是否是1开头的11位数字
    NSString * MOBILE = @"^1\\d{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:self];
}

// 是否是正确的身份证号
// 参考:http://blog.csdn.net/fdipzone/article/details/35859879
-(BOOL)isValidIdNumber {
    
    // 身份证号只能是18位
    if( [self length] != 18 ) {
        return NO;
    }
    
    // 加权因子
    NSArray *factors = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    
    // 验证码
    NSArray *verifyCodes = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    
    // 加权去和
    int total = 0;
    for( int i=0; i<17; i++) {
        int number = [[self substringWithRange:NSMakeRange(i, 1)] intValue];
        int factor = [[factors objectAtIndex:i] intValue];
        total += number*factor;
    }
    
    // 取模
    int mod = total % 11;
    
    // 最后一位验证码
    if( ![[self substringWithRange:NSMakeRange(17, 1)] isEqualToString:[verifyCodes objectAtIndex:mod]] ) {
        return NO;
    }
    
    return YES;
}

@end
