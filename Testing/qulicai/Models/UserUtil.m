//
//  UserUtil.m
//  qulicai
//
//  Created by admin on 2017/8/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "UserUtil.h"
#import "User.h"

#define UserFileName @"user.data"
#define UserFilePathWithName(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName]
#define userFilePath UserFilePathWithName(UserFileName)


@implementation UserUtil

+ (void)saving:(User *)user {
    [NSKeyedArchiver archiveRootObject:user
                                toFile:userFilePath];
}

+ (User *)currentUser {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:userFilePath];
}

+ (BOOL)isLoginIn {
    User *currentUser = [UserUtil currentUser];
    if (currentUser.mobilePhone.length > 0 && currentUser.userId.length > 0)  {
        return YES;
    }
    return NO;
}

+ (BOOL)outLoginIn {
    
    if([[NSFileManager defaultManager] fileExistsAtPath:userFilePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:userFilePath
                                                   error:&error];
        if (error) {
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}

@end
