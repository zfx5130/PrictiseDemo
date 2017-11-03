//
//  NSObject+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "NSObject+Custom.h"

@implementation NSObject (Custom)

- (BOOL)isLegelTimestamp
{
    return [self isKindOfClass:[NSNumber class]];
}

- (long long)javascriptTimestampToObjcTimestamp
{
    return [self isLegelTimestamp] ? [(id)self longLongValue] / 1000 : 0;
}

- (long long)javascriptTimestampToObjcTimestampWithOffset:(NSInteger)offset
{
    long long timestamp =
    ([(id)self longLongValue] / 1000) - offset * 60 - [[NSTimeZone localTimeZone] secondsFromGMT];
    return [self isLegelTimestamp] ? timestamp : 0;
//    return [(id)self longLongValue] / 1000;
}

- (long long)objcTimestampToJavascriptTimestamp
{
    return [self isLegelTimestamp] ? [(id)self longLongValue] * 1000 : 0;
}

- (long long)localtimeToOriginalTimeWithOffset:(NSInteger)offset
{
    long long timestamp =
    [(id)self longLongValue] + offset * 60 + [[NSTimeZone localTimeZone] secondsFromGMT];
    return [self isLegelTimestamp] ? timestamp : 0;
}

@end
