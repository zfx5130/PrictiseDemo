//
//  ZhaoShangSignHelper.h
//  qulicai
//
//  Created by admin on 2017/9/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhaoShangSignHelper : NSObject

+ (instancetype)manager;

@property (copy, nonatomic) NSString *periodMoney;

@property (copy, nonatomic) NSString *period;

@property (copy, nonatomic) NSString *totalMoney;

@property (copy, nonatomic) NSString *money;

@property (copy, nonatomic) NSString *phone;

@property (copy, nonatomic) NSString *orderNo;

@end
