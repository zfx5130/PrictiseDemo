//
//  ProductPriceView.h
//  niaobushi
//
//  Created by admin on 16/9/10.
//  Copyright © 2016年 yangkun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCRBlurView.h"
#import "CorePasswordView.h"

typedef void(^PasswordBlock)(NSString *password);

@interface ProductPasswordView : UIView
<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet JCRBlurView *centerView;

@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;

@property (weak, nonatomic) IBOutlet CorePasswordView *passwordView;


@property (copy, nonatomic) PasswordBlock pwBlock;

@end
