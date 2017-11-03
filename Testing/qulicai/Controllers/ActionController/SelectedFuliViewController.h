//
//  SelectedFuliViewController.h
//  qulicai
//
//  Created by admin on 2017/10/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ticket;
typedef void(^SelectSuccessBlock)(Ticket *ticket,BOOL isCancelSelect);

@interface SelectedFuliViewController : UIViewController

@property (copy, nonatomic) SelectSuccessBlock selectBlock;

@property (strong, nonatomic) Ticket *ticket;

@property (assign, nonatomic) BOOL isCancelSelected;

@property (assign, nonatomic) CGFloat money;

@property (copy, nonatomic) NSString *period;

@property (assign, nonatomic) NSInteger type;

@end

