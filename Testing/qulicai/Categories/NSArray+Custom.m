//
//  NSArray+Custom.m
//  bike
//
//  Created by satgi on 12/7/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "NSArray+Custom.h"

#import "NSDictionary+Custom.h"

@implementation NSArray (Custom)

- (NSArray *)arrayByReplacingNullsWithBlanks
{
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}



@end
