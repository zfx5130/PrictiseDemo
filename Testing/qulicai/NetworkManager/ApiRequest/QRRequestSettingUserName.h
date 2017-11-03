//
//  QRRequestSettingUserName.h
//  qulicai
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRRequest.h"

@interface QRRequestSettingUserName : QRRequest

@property (copy, nonatomic) NSString *nickName;

@property (copy, nonatomic) NSString *userId;

@end
