//
//  ActionInfo.h
//  qulicai
//
//  Created by admin on 2017/9/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface ActionInfo : BaseModel

@property (copy, nonatomic) NSString *address;

@property (assign, nonatomic) CGFloat amount;

@property (assign, nonatomic) CGFloat surplusAmount;

@property (assign, nonatomic) NSInteger type;

@property (assign, nonatomic) NSInteger status;

@property (copy, nonatomic) NSString *gmtCreated;

@end

