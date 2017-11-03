//
//  BaseModel.m
//  qulicai
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (NSString *)description {
    NSString *headCode =
    [NSString stringWithFormat:@"code:::::%@ desc:::::::%@ statustype::::::%@", self.desc, @(self.statusType), self.token];
    return headCode;
}

@end
