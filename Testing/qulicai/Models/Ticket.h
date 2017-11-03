//
//  Ticket.h
//  qulicai
//
//  Created by admin on 2017/11/1.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

@property (copy, nonatomic) NSString *ticketId;

//0新手礼包， 1普通卷
@property (assign, nonatomic) NSInteger type;

//0理财金 1加息卷 2红包
@property (assign, nonatomic) NSInteger name;

//卷福利
@property (copy, nonatomic) NSString *welfare;

//起投金额
@property (assign, nonatomic) NSInteger investLimit;

//使用项目天数限制最小值
@property (assign, nonatomic) NSInteger minBorrowTime;

//使用项目天数限制最大值
@property (assign, nonatomic) NSInteger maxBorrowTime;

//券期限
@property (assign, nonatomic) NSInteger timeLimit;

//过期时间
@property (copy, nonatomic) NSString *expireTime;

//创建时间
@property (copy, nonatomic) NSString *createTime;


@end
