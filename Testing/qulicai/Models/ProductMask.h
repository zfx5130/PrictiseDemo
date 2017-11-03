//
//  ProductMask.h
//  qulicai
//
//  Created by 赵富星 on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface ProductMask : NSObject

//借款金额
@property (copy, nonatomic) NSString *maskId;

@property (assign, nonatomic) CGFloat amount;

@property (copy, nonatomic) NSString *idCard;

@property (copy, nonatomic) NSString *name;

@end
