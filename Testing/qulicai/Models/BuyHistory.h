//
//  BuyHistory.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface BuyHistory : BaseModel

@property (copy, nonatomic) NSString *addTime;

@property (copy, nonatomic) NSString *historyId;

@property (assign, nonatomic) NSInteger status;

@property (copy, nonatomic) NSString *period;

@property (assign, nonatomic) CGFloat totalRate;

@property (copy, nonatomic) NSString *userId;

@property (assign, nonatomic) CGFloat money;

@property (assign, nonatomic) CGFloat rate;

@end
