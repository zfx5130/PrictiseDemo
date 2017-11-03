//
//  NSObject+Custom.h
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Custom)

- (long long)javascriptTimestampToObjcTimestamp;
- (long long)javascriptTimestampToObjcTimestampWithOffset:(NSInteger)offset;
- (long long)objcTimestampToJavascriptTimestamp;
- (long long)localtimeToOriginalTimeWithOffset:(NSInteger)offset;

@end
