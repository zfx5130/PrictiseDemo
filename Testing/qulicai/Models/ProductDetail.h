//
//  ProductDetail.h
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface ProductDetail : BaseModel

//活动利率
@property (assign, nonatomic) CGFloat activeRate;

//年利率
@property (assign, nonatomic) CGFloat yearRate;

//最低投资金额
@property (assign, nonatomic) NSInteger lowestAmount;

//剩余可购买
@property (assign, nonatomic) CGFloat ableAmount;

@end


