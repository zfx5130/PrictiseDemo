//
//  QRRequestModifyLoginPassword.h
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestModifyLoginPassword : QRRequest

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *loginPwd;

@property (copy, nonatomic) NSString *lastestPwd;

@end
