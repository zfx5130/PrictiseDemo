//
//  ZhaoShangSign.m
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ZhaoShangSign.h"

@implementation ZhaoShangSign

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"htmltext" : @"data.htmltext",
             };
}

@end
