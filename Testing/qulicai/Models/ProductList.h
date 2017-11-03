//
//  ProductList.h
//  qulicai
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface ProductList : BaseModel

//总个数
@property (assign, nonatomic) CGFloat total;

//产品列表
@property (copy, nonatomic) NSArray *products;

@end
