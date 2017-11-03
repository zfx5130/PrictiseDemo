//
//  QRActionView.h
//  qulicai
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhPopupController.h"

@interface QRActionView : UIView

@property (strong, nonatomic) IBOutlet UIView *aView;

@property (strong, nonatomic) zhPopupController *zhPopController;

@property (weak, nonatomic) IBOutlet UIView *backHolderView;

@end
