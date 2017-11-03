//
//  BaseModel.h
//  qulicai
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IndentityStatusType) {
    IndentityStatusSuccess = 0, //成功
    IndentityStatusTypeInvalid = 200, //登录失效
    IndentityStatusTypeParamError = 300, //参数错误
    IndentityStatusTypedataError = 400, //数据处理错误
    IndentityStatusTypeServerError = 500, //服务器错误
    IndentityStatusFail //失败
};


@interface BaseModel : NSObject

@property (copy, nonatomic) NSString *desc;

//code
@property (assign, nonatomic) IndentityStatusType statusType;

@property (copy, nonatomic) NSString *token;

@end
