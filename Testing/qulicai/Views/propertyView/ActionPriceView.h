//
//  ActionPriceView.h
//  qulicai
//
//  Created by admin on 2017/9/29.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionPriceView : UIView

@property (strong, nonatomic) IBOutlet UIView *aView;

@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancleButton;

//15
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tilteBottonConstraint;
//115
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneLeftConstraint;

@end
