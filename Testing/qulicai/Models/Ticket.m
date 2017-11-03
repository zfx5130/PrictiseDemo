//
//  Ticket.m
//  qulicai
//
//  Created by admin on 2017/11/1.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ticketId" : @"id"
             };
}

@end
