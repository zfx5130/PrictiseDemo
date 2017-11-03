//
//  CompanyData.h
//  qulicai
//
//  Created by admin on 2017/9/25.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface CompanyData : BaseModel

//收益总额
@property (assign,nonatomic) CGFloat rate;

//投资总额
@property (assign, nonatomic) CGFloat sum;

//人数
@property (assign, nonatomic) NSInteger count;

@end
