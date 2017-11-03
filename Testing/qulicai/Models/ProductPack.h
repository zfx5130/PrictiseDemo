//
//  ProductPack.h
//  qulicai
//
//  Created by 赵富星 on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface ProductPack : NSObject

@property (copy, nonatomic) NSString *productPackId;

@property (copy, nonatomic) NSString *packId;

@property (copy, nonatomic) NSString *addTime;

@property (copy, nonatomic) NSString *cardId;

@property (copy, nonatomic) NSString *mobilePhone;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *realName;

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSArray *appBanks;

@property (assign, nonatomic) CGFloat money;

@property (copy, nonatomic) NSString *period;

@property (assign, nonatomic) NSInteger status;

@property (assign, nonatomic) CGFloat totalRate;


@end
