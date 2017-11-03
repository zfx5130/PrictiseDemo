//
//  Version.m
//  qulicai
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "Version.h"

@implementation Version

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"desc" : @"errMsg",
             @"statusType" : @"code",
             @"token" : @"token",
             @"versionId" : @"data.id",
             @"message" : @"data.message",
             @"name" : @"data.name",
             @"ableVersion" : @"data.ableVersion",
             @"appVersion" : @"data.appVersion"
             };
}

@end
