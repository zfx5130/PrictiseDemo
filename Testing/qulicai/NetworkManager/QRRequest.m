//
//  QRRequest.m
//  qulicai
//
//  Created by admin on 2017/8/11.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"
#import "UserUtil.h"
#import "WXZTipView.h"

static NSString *const kRequestLogSeparatorDoubleLines = @"==================================================";
static NSString *const kRequestLogSeparatorSingleLine = @"--------------------------------------------------";

typedef NS_ENUM(NSUInteger, RequestCodeType) {
    RequestCodeTypeSuccess = 0, //成功
    RequestCodeTypeTokenInvalid = 200, //token失效
    RequestCodeTypeParamError = 300, //参数错误
    RequestCodeTypeDataError = 400, //数据处理错误
    RequestCodeTypeServerError = 500, //服务器错误
    RequestCodeTypeOtherFail //其他失败
};

@implementation QRRequest

//加密处理
- (NSString *)MD5dicParamsValue {
    
    NSDictionary *argumentDic = [self requestArgument];
    //获取allkey,对所有的key值遍历
    NSArray *keyArray = [argumentDic allKeys];
    NSArray *sortArray =
    [keyArray sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //存储遍历完成的value值
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortString in sortArray) {
        [valueArray addObject:[argumentDic objectForKey:sortString]];
    }
    
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < sortArray.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@:%@",sortArray[i],valueArray[i]];
        [signArray addObject:keyValueStr];
    }
    //数组,分割转换为字符串
    NSString *sign = [signArray componentsJoinedByString:@","];
    //获取拼接最终字符串
    NSString *lastMd5Value = [NSString stringWithFormat:@"{%@}qr",sign];
    return lastMd5Value;
}

//header传入加密参数
- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSString *md5Value = [self MD5dicParamsValue];
    NSString *md5PwValue = [NSString getMd5_32Bit_String:md5Value];
    return @{
             @"key" : md5PwValue
             };
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (NSString *)gerRequestMethod {
    YTKRequestMethod method = [self requestMethod];
    
    switch (method) {
        case YTKRequestMethodGET:
            return @"GET";
            break;
        case YTKRequestMethodPOST:
            return @"POST";
            break;
        case YTKRequestMethodHEAD:
            return @"HEAD";
            break;
        case YTKRequestMethodPUT:
            return @"PUT";
            break;
        case YTKRequestMethodPATCH:
            return @"PATCH";
            break;
        case YTKRequestMethodDELETE:
            return @"DELETE";
            break;
        default:
            break;
    }
    
    return @"POST";
}

- (NSString *)baseUrl {
    return @"";
}

- (void)start {
    [super start];
    [self logParamsInfo];
}

- (void)logParamsInfo {
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",kBaseUrl,[self requestUrl]];
    NSString *requestParam = [self requestArgument];
    NSString *method = [self gerRequestMethod];
    
    NSString *keyString = [self MD5dicParamsValue];
    NSString *lastValue = [NSString stringWithFormat:@"md5加密前:\n%@",[NSString stringWithFormat:@"%@",keyString]];
    NSString *md5Value = [NSString stringWithFormat:@"md5加密后：\n%@",[NSString getMd5_32Bit_String:lastValue]];
    
    SLog(@"\n%@\nRequest URL：\n(%@) %@\n%@\n%@\n%@\n%@\nParameters：\n%@\n%@\n",
         kRequestLogSeparatorDoubleLines,
         method,
         requestUrl,
         kRequestLogSeparatorSingleLine,
         lastValue,
         md5Value,
         kRequestLogSeparatorSingleLine,
         requestParam,
         kRequestLogSeparatorDoubleLines);
}

//token
- (NSString *)token {
    NSString *value = [[A0SimpleKeychain keychain] stringForKey:QR_CURRENT_TOKEN];
    if ([NSString isEmpty:value]) {
        return @"";
    }
    return value;
}

#pragma mark - 请求获取数据字段

- (NSString *)message {
    if (self.error) {
        return self.error.localizedDescription;
    }
    NSString *message = [NSString stringWithFormat:@"%@",[NSString getStringWithString:self.result[@"errMsg"]]];
    return message;
}

- (NSString *)code {
    NSString *code = [NSString stringWithFormat:@"%@",self.result[@"code"]];
    return code;
}

- (BOOL)isSuccess {
    
    NSInteger code = [[self code] integerValue];
    BOOL isSuccess = NO;
    switch (code) {
        case RequestCodeTypeSuccess: {
            isSuccess = YES;
        }
            break;
        case RequestCodeTypeTokenInvalid: {
            if ([UserUtil outLoginIn]) {
                [self showErrorWithTitle:@"登录失效"];
                PostNotification(QR_OUTLOGIN_UPDATE_HEAD_VIEW_STAUTS);
            }
            isSuccess = NO;
        }
            break;
        case RequestCodeTypeParamError: {
            isSuccess = NO;
            [self showErrorWithTitle:self.message];
        }
            break;
        case RequestCodeTypeDataError: {
            isSuccess = NO;
            [self showErrorWithTitle:self.message];
        }
            break;
        case RequestCodeTypeServerError: {
            isSuccess = NO;
            [self showErrorWithTitle:self.message];
        }
            break;
        case RequestCodeTypeOtherFail: {
            isSuccess = NO;
            [self showErrorWithTitle:self.message];
        }
            break;
        default:
            break;
    }
    return  isSuccess;
}

- (void)showErrorWithTitle:(NSString *)title {
    if (!title) {
        title = @"请求错误";
    }
    [WXZTipView showCenterWithText:title];
}


@end


