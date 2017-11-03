//
//  MaskList.h
//  qulicai
//
//  Created by 赵富星 on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface MaskList : BaseModel

@property (assign, nonatomic) NSInteger total;

@property (copy, nonatomic) NSArray *masks;

@end
