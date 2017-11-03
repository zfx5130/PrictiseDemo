//
//  UIFont+Custom.m
//  bike
//
//  Created by satgi on 12/10/14.
//  Copyright (c) 2014 yunzao. All rights reserved.
//

#import "UIFont+Custom.h"

@implementation UIFont (Custom)

+ (NSMutableArray *)availabelFonts {
    NSMutableArray *fonts = [[NSMutableArray alloc] init];
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            [fonts addObject:fontName];
        }
    }
    return fonts;
}

+ (void)printAvailabelFonts {
    NSLog(@"%@", [UIFont availabelFonts]);
}

@end
