//
//  UserUtil.h
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface UserUtil : NSObject

// 保存User信息
+ (void)saving:(User *)user;

// 取出User信息
+ (User *)currentUser;

//是否登录
+ (BOOL)isLoginIn;

//退出登录
+ (BOOL)outLoginIn;

@end
