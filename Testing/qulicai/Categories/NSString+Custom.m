//
//  NSString+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "NSString+Custom.h"
#import <AVFoundation/AVFoundation.h>
#include <CommonCrypto/CommonDigest.h>
#import "NSDate+Custom.h"

@implementation NSString (Custom)

+ (NSString *)currentRegion {
    NSLocale *currentLocale = [NSLocale currentLocale];
   // NSLog(@"regionCode::::%@", [currentLocale objectForKey:NSLocaleCountryCode]);
    return [currentLocale objectForKey:NSLocaleCountryCode];
}

+ (NSString *)currentLanguage {
    NSLocale *currentLocale = [NSLocale currentLocale];
    //    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    //    NSLog(@"::%@",language);
    NSLog(@"languageCode::::%@", [currentLocale objectForKey:NSLocaleLanguageCode]);
    return [currentLocale objectForKey:NSLocaleLanguageCode];
}

+ (NSString *)localizedURLString:(NSString *)URLString {
    NSString *localizedString = URLString;
    
    @try {
        NSURL *URL = [NSURL URLWithString:localizedString];
        
        NSString *queryString = [URL query];
        NSMutableArray *queryComponents =
        [[queryString componentsSeparatedByString:@"&"] mutableCopy];
        queryComponents = [queryComponents count] ? queryComponents : [[NSMutableArray alloc] init];
        
        NSArray *localizedQueryComponents =
        @[
          [NSString stringWithFormat:@"region=%@", [NSString currentRegion]],
          [NSString stringWithFormat:@"language=%@", [NSString currentLanguage]],
          ];
        
        [queryComponents addObjectsFromArray:localizedQueryComponents];
        
        localizedString = [NSString stringWithFormat:@"%@://%@%@?%@#%@",
                           URL.scheme,
                           URL.host,
                           URL.path.length ? URL.path : @"",
                           [queryComponents componentsJoinedByString:@"&"],
                           URL.fragment.length ? URL.fragment : @""
                           ];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        
    }
    
    return localizedString;
}

+ (NSString *)sha1:(NSString *)input {
    NSData *data = [input dataUsingEncoding: NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
    
}

+ (NSString *)md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
        
    return  output;
}


+ (NSString *)nonNullStringForObject:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return object;
}

- (void)call {
}

+ (void)openURLInBrowser:(NSString *)url {
    if (url.length > 0) {
        NSURL *linkUrl = [NSURL URLWithString:url];
        [[UIApplication sharedApplication] openURL:linkUrl];
    }
}

+ (NSString *)stringFromObject:(id)object {
    NSString *result;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        result = nil;
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        result = jsonString;
    }
    return result;
}

- (BOOL)checkEmailWithAlert {
    return [self checkEmailWithAlert:YES];
}

- (BOOL)checkEmailWithAlert:(BOOL)alert {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL legal = [self isEqualToString:@"yb"] || [emailTest evaluateWithObject:self];
    if (!legal) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Illegal email", nil)
                                    message:NSLocalizedString(@"Please check your email", nil)
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                          otherButtonTitles:nil, nil] show];
    }
    return legal;
}

+ (NSString *)getBinaryByhex:(NSString *)hex {
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] init];
    
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    
    [hexDic setObject:@"0001" forKey:@"1"];
    
    [hexDic setObject:@"0010" forKey:@"2"];
    
    [hexDic setObject:@"0011" forKey:@"3"];
    
    [hexDic setObject:@"0100" forKey:@"4"];
    
    [hexDic setObject:@"0101" forKey:@"5"];
    
    [hexDic setObject:@"0110" forKey:@"6"];
    
    [hexDic setObject:@"0111" forKey:@"7"];
    
    [hexDic setObject:@"1000" forKey:@"8"];
    
    [hexDic setObject:@"1001" forKey:@"9"];
    
    [hexDic setObject:@"1010" forKey:@"A"];
    
    [hexDic setObject:@"1011" forKey:@"B"];
    
    [hexDic setObject:@"1100" forKey:@"C"];
    
    [hexDic setObject:@"1101" forKey:@"D"];
    
    [hexDic setObject:@"1110" forKey:@"E"];
    
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    
    for (int i=0; i< [hex length]; i++) {
        
        NSRange rage;
        
        rage.length = 1;
        
        rage.location = i;
        
        NSString *key = [hex substringWithRange:rage];
        [binaryString appendString:[NSString stringWithFormat:@"%@",
                                    [NSString stringWithFormat:@"%@",
                                     [hexDic objectForKey:key]]]];
    }
    
    //NSLog(@"转化后的二进制为:%@",binaryString);
    
    return binaryString;
}

+ (CGSize)sizeForFont:(UIFont *)font
                 text:(NSString *)text
              maxSize:(CGSize)maxSize {
    text = ![text isKindOfClass:[NSString class]] ? @"" : text;
    font = ![font isKindOfClass:[UIFont class]] ? [UIFont systemFontOfSize:14.0f] : font;
    CGRect bounds = [text boundingRectWithSize:maxSize
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:@{
                                                 NSFontAttributeName : font
                                                 }
                                       context:nil];
    CGSize size = bounds.size;
    size.height += 2.0f;
    return size;
}

+ (CGSize)sizeForFont:(UIFont *)font
                 text:(NSString *)text {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : font}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width),
                                     ceilf(size.height));
    return adjustedSize;
}

- (NSAttributedString *)attributedString:(NSDictionary *)attributes
                                 forText:(NSString *)text {
    if (!self.length) {
        return nil;
    }
    NSString *rangeText = [text isKindOfClass:[NSString class]] ?
    text : [NSString stringWithFormat:@"%@", text];
    NSRange range = [self rangeOfString:rangeText];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    //    NSLog(@"start: %@, length: %@", @(range.location), @(range.length));
    
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:self];
    for (NSString *attributeKey in attributes) {
        [attributedString addAttribute:attributeKey
                                 value:attributes[attributeKey]
                                 range:range];
    }
    
    return attributedString;
}

- (BOOL)containsText:(NSString *)text {
    NSRange range = [self rangeOfString:text];
    return range.location != NSNotFound;
}

- (NSAttributedString *)attributedString:(NSDictionary *)attributes
                                 forText:(NSString *)text
                           compareOption:(NSStringCompareOptions)compareOption {
    if (!self.length) {
        return nil;
    }
    NSString *rangeText = [text isKindOfClass:[NSString class]] ?
    text : [NSString stringWithFormat:@"%@", text];
    NSRange range = [self rangeOfString:rangeText
                                options:compareOption];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    //  NSLog(@"start: %@, length: %@", @(range.location), @(range.length));
    
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:self];
    for (NSString *attributeKey in attributes) {
        [attributedString addAttribute:attributeKey
                                 value:attributes[attributeKey]
                                 range:range];
    }
    
    return attributedString;
}

+ (NSString *)stringDataWithJsonData:(id)data {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:0
                                                         error:&error];
    if (error || !jsonData) {
        NSLog(@"%@", error);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    if (!jsonString.length) {
        return nil;
    }
    return jsonString;
}

+ (NSString *)replaceStrWithRange:(NSRange)range
                           string:(NSString *)content
                       withString:(NSString *)replaceString {
    NSMutableString *string = [[NSMutableString alloc] initWithString:content];
    [string replaceCharactersInRange:range
                          withString:replaceString];
    return string;
}

+ (NSString *)addDotWithString:(NSString *)string {
    
    NSString *dotString = @"";
    int count = 0;
    for (int i = 0; i < string.length; i++) {
        count++;
        dotString = [dotString stringByAppendingString:[string substringWithRange:NSMakeRange(i, 1)]];
        if (count == 4) {
            dotString = [NSString stringWithFormat:@"%@ ", dotString];
            count = 0;
        }
    }
    return dotString;
}


+ (NSString *)countNumAndChangeformat:(NSString *)num {

    NSString* str11;
    NSString* str22;
    if ([num containsString:@"."]) {
        NSArray* array = [num componentsSeparatedByString:@"."];
        str11 = array[0];
        str22 = array[1];
    } else {
        str11 = num;
    }
    int count = 0;
    long long int a = str11.longLongValue;
    while (a != 0) {
        count++;
        a /= 10;
    }
    
    NSMutableString *string = [NSMutableString stringWithString:str11];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    
    [newstring insertString:string atIndex:0];
    
    if ([num containsString:@"."]) {
        NSString* str33;
        if (str22.length > 0) {
            str33 = [NSString stringWithFormat:@"%@.%@",newstring,str22];
        } else {
            str33 = [NSString stringWithFormat:@"%@",newstring];
        }
        return str33;
    } else {
        return newstring;
        
    }
}

+ (NSString*)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval currentStamp = [date timeIntervalSince1970];
    NSString *currentStampString = [NSString stringWithFormat:@"%0.f", currentStamp];
    return currentStampString;
}

+ (NSString *)UIImageToBase64Str:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 0.1f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

+ (NSString *) image2DataURL: (UIImage *) image {
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        mimeType = @"image/jpeg";
    }
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
    
}

+ (BOOL)imageHasAlpha: (UIImage *) image {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

+ (NSString *)timeStamp {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *simOrder = [dateFormater stringFromDate:[NSDate date]];
    return simOrder;
}

+ (NSString *)getMd5_32Bit_String:(NSString *)srcString {
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02X", digest[i]];
    return result;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    if (!dic) {
        return @"";
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)getMMddDateStringWithTimeString:(NSString *)time {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:time];
    NSString *mmddString = [date dateStringWithFormatterMMDD];
    return mmddString;
}

+ (NSString *)getyyyyMMddDateStringWithTimeString:(NSString *)time {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:time];
    NSString *mmddString = [date dataStringWithFormatterYYYYMMDDHHMMSS];
    return mmddString;
}

@end
