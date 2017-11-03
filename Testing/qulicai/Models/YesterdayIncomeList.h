//
//  YesterdayIncomeList.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface YesterdayIncomeList : BaseModel

@property (assign, nonatomic) CGFloat totalEarning;

@property (assign, nonatomic) CGFloat totalYestEaring;

@property (copy, nonatomic) NSString *settleDate;

@property (copy, nonatomic) NSArray *incomes;

@end
