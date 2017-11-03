//
//  LoginPasswordErrorView.h
//  qulicai
//
//  Created by admin on 2017/10/25.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPasswordErrorView : UIView

@property (strong, nonatomic) IBOutlet UIView *aView;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UIButton *verifyLoginButton;

@property (weak, nonatomic) IBOutlet UIButton *findPasswordButton;


@property (weak, nonatomic) IBOutlet UIView *passwordErrorHolderView;

@property (weak, nonatomic) IBOutlet UIView *passwordLockHolderView;

@property (weak, nonatomic) IBOutlet UIButton *lockFindPasswordButton;

@property (weak, nonatomic) IBOutlet UIButton *lockCancleButton;


@end
