//
//  NSDictionary+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Custom)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;

//json格式字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
