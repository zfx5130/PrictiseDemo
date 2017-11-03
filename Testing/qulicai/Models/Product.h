//
//  Product.h
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (copy, nonatomic) NSString *productId;

//产品利率
@property (assign, nonatomic) CGFloat yearRate;

//灵活利率
@property (assign, nonatomic) CGFloat activeRate;

//修改时间
@property (copy, nonatomic) NSString *gmtModified;

//产品周期
@property (copy, nonatomic) NSString *period;

//产品开始时间
@property (copy, nonatomic) NSString *gmtCreated;

//0：待生息，1：持有中，2：已结算）
@property (assign, nonatomic) NSInteger status;

//可购买余额
@property (assign, nonatomic) CGFloat ableAmount;

//0新手 1普通
@property (assign, nonatomic) NSInteger type;

//是否含有福利
@property (assign, nonatomic) BOOL haveBenefits;

@end
