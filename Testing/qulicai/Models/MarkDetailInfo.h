//
//  MarkDetailInfo.h
//  qulicai
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface MarkDetailInfo : BaseModel

@property (copy, nonatomic) NSString *markId;

@property (assign, nonatomic) NSInteger age;

@property (assign, nonatomic) CGFloat amount;

//借款次数，不算档次借款
@property (assign, nonatomic) NSInteger  allloanTimes;

@property (assign, nonatomic) CGFloat apr;

@property (copy, nonatomic) NSString *bankCard;

@property (copy, nonatomic) NSString *borrowId;

@property (copy, nonatomic) NSString *contractNo;


@property (copy, nonatomic) NSString *insertTime;


@property (assign, nonatomic) NSInteger isRefuse;


@property (assign, nonatomic) NSInteger nomarlTimes;


@property (assign, nonatomic) NSInteger outoftimeTimes;


@property (copy, nonatomic) NSString *packId;


@property (copy, nonatomic) NSString *peroid;

@property (copy, nonatomic) NSString *repaymentUserName;


@property (copy, nonatomic) NSString *sex;

@property (copy, nonatomic) NSString *soldOutTime;

@property (copy, nonatomic) NSString *source;

@property (copy, nonatomic) NSString *sourceName;

@property (assign, nonatomic) NSInteger status;

@property (copy, nonatomic) NSString *userCardId;

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *userMobilePhone;

@property (copy, nonatomic) NSString *userName;

@end

