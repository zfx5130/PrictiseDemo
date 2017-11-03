//
//  QRRequestFindLoginPassword.h
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestFindLoginPassword : QRRequest

@property (copy, nonatomic) NSString *mobilePhone;

@property (copy, nonatomic) NSString *pwd;

@property (copy, nonatomic) NSString *code;

@end
