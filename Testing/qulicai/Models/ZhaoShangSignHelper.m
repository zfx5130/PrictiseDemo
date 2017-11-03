//
//  ZhaoShangSignHelper.m
//  qulicai
//
//  Created by admin on 2017/9/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ZhaoShangSignHelper.h"

@implementation ZhaoShangSignHelper

+ (instancetype)manager {
    static ZhaoShangSignHelper *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}


@end
