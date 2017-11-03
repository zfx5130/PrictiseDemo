//
//  Product.m
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"productId" : @"id"
             };
}

@end
