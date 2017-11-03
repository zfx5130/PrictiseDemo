//
//  PackList.h
//  qulicai
//
//  Created by 赵富星 on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface PackList : BaseModel

@property (assign, nonatomic) NSInteger total;

@property (copy, nonatomic) NSArray *packs;

@end
