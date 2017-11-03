//
//  RongBaoPayConfig.h
//  qulicai
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface RongBaoPayConfig : BaseModel

//绑定卡类型
@property (copy, nonatomic) NSString *bank_card_type;
//银行编号
@property (copy, nonatomic) NSString *bank_code;
//银行名称
@property (copy, nonatomic) NSString *bank_name;
//绑卡id
@property (copy, nonatomic) NSString *bind_id;
//卡号后四位
@property (copy, nonatomic) NSString *card_last;

@property (copy, nonatomic) NSString *phone;

//订单号
@property (copy, nonatomic) NSString *order_no;

@property (copy, nonatomic) NSString *result_code;

@property (copy, nonatomic) NSString *result_msg;

@end
