//
//  QRShareView.h
//  qulicai
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhPopupController.h"

@interface QRShareView : UIView

@property (strong, nonatomic) IBOutlet UIView *aView;

@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@property (strong, nonatomic) UIViewController *currentController;

@property (strong, nonatomic) zhPopupController *zhPopController;

@end
