//
//  ActionView.h
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYTextView.h>

@interface ActionView : UIView

@property (strong, nonatomic) IBOutlet UIView *aView;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *cancleButton;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIView *addressHolderView;

@property (strong, nonatomic) YYTextView *textView;

@end
