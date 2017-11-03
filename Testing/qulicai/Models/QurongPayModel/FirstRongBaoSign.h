//
//  FirstRongBaoSign.h
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface FirstRongBaoSign : BaseModel

//银行编号
@property (copy, nonatomic) NSString *bank_code;
//银行名称
@property (copy, nonatomic) NSString *bank_name;

@property (copy, nonatomic) NSString *result_code;

@property (copy, nonatomic) NSString *result_msg;

//是否调用招商银行卡密验证(0:调用，1不调用)
@property (copy, nonatomic) NSString *certificate;

//绑卡id
@property (copy, nonatomic) NSString *bind_id;

//订单号
@property (copy, nonatomic) NSString *order_no;


@end
