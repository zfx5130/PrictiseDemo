//
//  QRRequest.h
//  qulicai
//
//  Created by admin on 2017/8/11.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

#ifdef DEBUG

//正式
//static NSString *const kBaseUrl = @"https://java.qulicai8.com/";

//测试
static NSString *const kBaseUrl = @"http://192.168.3.7:9999/";

#else

//static NSString *const kBaseUrl = @"https://java.qulicai8.com/";

#endif

@interface QRRequest : YTKRequest

@property (copy, nonatomic) NSString *token;

#pragma mark - 请求获取数据字段

//是否成功
@property (assign, nonatomic) BOOL isSuccess;

//服务器返回的信息
@property (copy, nonatomic) NSString *message;

//服务器返回的数据
@property (copy, nonatomic) NSDictionary *result;


@end
