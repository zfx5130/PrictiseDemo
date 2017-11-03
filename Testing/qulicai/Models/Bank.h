//
//  Bank.h
//  qulicai
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BankStatusType) {
    BankStatusUnActivate = 0, //未激活
    BankStatusActivate // 激活
};

@interface Bank : NSObject

//添加时间
@property (copy, nonatomic) NSString *addTime;

//银行卡名称
@property (copy, nonatomic) NSString *bankName;

//银行卡号
@property (copy, nonatomic) NSString *bankNo;

@property (copy, nonatomic) NSString *bindId;

@property (copy, nonatomic) NSString *bankId;

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *modifyTime;

@property (copy, nonatomic) NSString *phoneNo;

@property (assign, nonatomic) BankStatusType bankStatusType;

@end
