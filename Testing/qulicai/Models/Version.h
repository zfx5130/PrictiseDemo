//
//  Version.h
//  qulicai
//
//  Created by admin on 2017/9/8.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BaseModel.h"

@interface Version : BaseModel

@property (copy, nonatomic) NSString *versionId;

//版本号
@property (copy, nonatomic) NSString *appVersion;

//最低可用版本
@property (copy, nonatomic) NSString *ableVersion;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *message;

@end
