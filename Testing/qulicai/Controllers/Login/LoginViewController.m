//
//  LoginViewController.m
//  qulicai
//
//  Created by admin on 2017/8/14.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "QRRequestHeader.h"
#import "SendVerifyCodeButton.h"
#import "User.h"
#import "UserUtil.h"
#import "VerifyCode.h"

#import "ASPopupController.h"
#import "LoginPasswordErrorView.h"

@interface LoginViewController ()
<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *phoneButtton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *lockButton;

@property (weak, nonatomic) IBOutlet UIButton *verifyImageButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;


@property (weak, nonatomic) IBOutlet UILabel *shakeErrorLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headImageHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewHeightCostraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet SendVerifyCodeButton *verifyCodeButton;

@property (weak, nonatomic) IBOutlet UIView *verifyViewHolderView;

@property (weak, nonatomic) IBOutlet UIView *passwordHolderView;

@property (weak, nonatomic) IBOutlet UIButton *loginStatusButton;

@property (assign, nonatomic) BOOL isPasswordLogin;

@property (strong, nonatomic) ASPopupController *popController;

@property (strong, nonatomic) LoginPasswordErrorView *loginErrorView;

@end

@implementation LoginViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认密码登录
    self.isPasswordLogin = YES;
    [self setupViews];
    [self wr_setNavBarShadowImageHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self wr_setNavBarBackgroundAlpha:0.0f];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Private

- (void)updateLoginViewStyle {
    self.verifyViewHolderView.hidden = self.isPasswordLogin;
    self.passwordHolderView.hidden = !self.verifyViewHolderView.hidden;
}

- (void)setupViews {
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.headImageHeightConstraint.constant = SCREEN_WIDTH * 150 / IPHONE6_WIDTH;
    if (IS_IPHONE_5) {
        self.loginButtonTopConstraint.constant = 25.0f;
        self.centerViewHeightCostraint.constant = 95.0f;
    }
    [self.view addTapGestureForDismissingKeyboard];
    [self setupNavigationItemRight:[UIImage imageNamed:@"close_image"]];
    [self.phoneTextField becomeFirstResponder];
    self.loginStatusButton.selected = YES;
}

- (void)updateResetButtonStatus {
    if (self.isPasswordLogin) {
        self.loginButton.enabled =
        self.passwordTextField.text.length >= 6 && self.phoneTextField.text.length;
    } else {
        self.loginButton.enabled =
        self.verifyCodeTextField.text.length >= 6 && self.phoneTextField.text.length;
    }
}

- (void)login {
    [self.view endEditing:YES];
    if (self.phoneTextField.text.length < 11) {
        self.shakeErrorLabel.text = @"*对不起手机号码有误";
        [self.shakeErrorLabel addShakeAnimation];
        return;
    }
        
    [self showSVProgressHUD];
    QRRequestLogin *request = [[QRRequestLogin alloc] init];
    request.mobilePhone = self.phoneTextField.text;
    request.password = self.isPasswordLogin ? self.passwordTextField.text : self.verifyCodeTextField.text;
    request.loginType = self.isPasswordLogin ? 0 : 1;
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        User *user = [User mj_objectWithKeyValues:request.responseJSONObject];
        SLog(@"登录信息::::%@:::::\n:::token::%@",request.responseJSONObject, user.token);
        [weakSelf saveToken:user.token];
        [weakSelf dimissSVProgressHUD];
        if (user.statusType == IndentityStatusSuccess) {
            //获取用户信息
            QRRequestGetUserInfo *request = [[QRRequestGetUserInfo alloc] init];
            request.userId = user.userId;
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                User *userInfo = [User mj_objectWithKeyValues:request.responseJSONObject];
                [weakSelf saveToken:userInfo.token];
                SLog(@"登录成功user信息::::::::::%@",request.responseJSONObject);
                if (userInfo.statusType == IndentityStatusSuccess) {
                    [UserUtil saving:userInfo];
                    PostNotification(QR_OUTLOGIN_UPDATE_HEAD_VIEW_STAUTS);
                    [weakSelf showSuccessWithTitle:@"登录成功"];
                    [weakSelf dismissViewControllerAnimated:YES
                                                 completion:nil];
                } else {
                    [weakSelf showTipErrorWithTitle:userInfo.desc];
                }
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                NSLog(@"error:- %@", request.error);
                [weakSelf showErrorWithTitle:@"请求失败"];
                [weakSelf dimissSVProgressHUD];
            }];
            
        } else if (user.statusType == 202) {
            //密码错误逻辑
            if (self.isPasswordLogin) {
                //密码登录
                NSInteger count = [request.responseJSONObject[@"data"][@"loginResidueCount"] integerValue];
                SLog(@"错误次数:::::%@",@(count));
                if (count == 1) {
                    [weakSelf alertLoginErrorViewWithTpye:YES];
                } else if (count == 0) {
                    [weakSelf showTipErrorWithTitle:@"账号多次异常登录已被锁定!\n请24小时后再试"];
                } else {
                    [weakSelf showTipErrorWithTitle:@"账号或密码错误"];
                }
            } else {
                [weakSelf showTipErrorWithTitle:user.desc];
            }
        } else if (user.statusType == 311) {
            //[weakSelf alertLoginErrorViewWithTpye:NO];
            [weakSelf showTipErrorWithTitle:@"账号多次异常登录已被锁定!\n请24小时后再试"];
        } else {
            [weakSelf dimissSVProgressHUD];
            [weakSelf showTipErrorWithTitle:user.desc];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        [weakSelf showErrorWithTitle:@"请求失败"];
        NSLog(@"error:- %@", request.error);
    }];
}

#pragma mark - 登录锁定少于2次

- (void)alertLoginErrorViewWithTpye:(BOOL)isPasswordError {
    self.loginErrorView =
    [[LoginPasswordErrorView alloc] initWithFrame:CGRectMake(0.0f, -20.0f, SCREEN_WIDTH - 30.0f, 370)];
    self.loginErrorView.closeButton.hidden = !isPasswordError;
    self.loginErrorView.passwordErrorHolderView.hidden = !isPasswordError;
    self.loginErrorView.passwordLockHolderView.hidden = !self.loginErrorView.passwordErrorHolderView.hidden;
    self.popController =
    [ASPopupController  alertWithPresentStyle:ASPopupPresentStyleSlideDown
                                 dismissStyle:ASPopupDismissStyleSlideDown
                                    alertView:self.loginErrorView];
    [self.loginErrorView.closeButton addTarget:self
                                        action:@selector(dismiss)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.loginErrorView.verifyLoginButton addTarget:self
                                              action:@selector(verifyLogin:)
                                    forControlEvents:UIControlEventTouchUpInside];
    [self.loginErrorView.findPasswordButton addTarget:self
                                               action:@selector(findPassword:)
                                     forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginErrorView.lockCancleButton addTarget:self
                                             action:@selector(dismiss)
                                   forControlEvents:UIControlEventTouchUpInside];
    [self.loginErrorView.lockFindPasswordButton addTarget:self
                                                   action:@selector(findPassword:)
                                         forControlEvents:UIControlEventTouchUpInside];
    
    [self presentViewController:self.popController
                       animated:YES
                     completion:nil];
}

- (void)dismiss {
    if (self.popController) {
        [self.popController dismissViewControllerAnimated:YES
                                               completion:nil];
    }
}

- (void)verifyLogin:(UIButton *)verifyButton {
    [self dismiss];
    self.isPasswordLogin = NO;
    [self updateLoginViewStyle];
}

- (void)findPassword:(UIButton *)button {
    if (self.popController) {
        [self.popController dismissViewControllerAnimated:YES completion:^{
            ForgetPasswordViewController *passwordController = [[ForgetPasswordViewController alloc] init];
            passwordController.isRegisterSwip = YES;
            passwordController.isTradingPw = NO;
            [self.navigationController pushViewController:passwordController
                                                 animated:YES];
        }];
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL isFlag =
    self.passwordTextField.text.length && self.phoneTextField.text.length;
    if (textField == self.passwordTextField && isFlag) {
        [self login];
    }
    return YES;
}

#pragma mark - Handlers

- (IBAction)verifyCode:(SendVerifyCodeButton *)sender {
    [self.view endEditing:YES];
    if (self.phoneTextField.text.length < 11) {
        self.shakeErrorLabel.text = @"*对不起手机号码有误";
        [self.shakeErrorLabel addShakeAnimation];
        return;
    }
    //检测验证码是否已经发送
    if ([sender canSenderVerifyCodeWithPhone:self.phoneTextField.text]) {
        return;
    }
    //请求验证码操作
    [self showSVProgressHUD];
    QRRequestVerifyCode *request = [[QRRequestVerifyCode alloc] init];
    request.mobilePhone = self.phoneTextField.text;
    request.codeType = VerifyCodeTypeVerifyLogin;
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        NSLog(@"验证码请求::::::%@",request.responseJSONObject);
        VerifyCode *verify = [VerifyCode mj_objectWithKeyValues:request.responseJSONObject];
        if (verify.statusType == IndentityStatusSuccess) {
            [weakSelf showSuccessWithTitle:@"发送验证码成功"];
            [sender sendVerifyCodeWithPhone:self.phoneTextField.text
                                 isBankCode:NO];
        } else {
            [weakSelf showTipErrorWithTitle:verify.desc];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        NSLog(@"error-::::%@",request.error);
    }];
    
}

- (IBAction)forgetPwd:(UIButton *)sender {
    [self.view endEditing:YES];
    ForgetPasswordViewController *passwordController = [[ForgetPasswordViewController alloc] init];
    passwordController.isRegisterSwip = YES;
    passwordController.isTradingPw = NO;
    [self.navigationController pushViewController:passwordController
                                         animated:YES];
}


- (IBAction)loginButtonWasPressed:(UIButton *)sender {
    [self login];
}

- (void)rightBarButtonAction {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)phoneChange:(UITextField *)sender {
    [self updateResetButtonStatus];
    if (sender == self.phoneTextField) {
        if (sender.text.length > 11) {
            sender.text = [sender.text substringToIndex:11];
        }
    }
}

- (IBAction)editingBegin:(UITextField *)sender {
    self.phoneButtton.selected = YES;
    if (self.shakeErrorLabel.text.length) {
        self.shakeErrorLabel.text = @"";
    }
    [self updateResetButtonStatus];
}


- (IBAction)editingEnded:(UITextField *)sender {
    self.phoneButtton.selected = NO;
    [self updateResetButtonStatus];
}


- (IBAction)passwordChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)passwordBeginEdit:(UITextField *)sender {
    if (self.shakeErrorLabel.text.length) {
        self.shakeErrorLabel.text = @"";
    }
    if (self.isPasswordLogin) {
        self.lockButton.selected = !self.phoneButtton.selected;
    } else {
        self.verifyImageButton.selected = !self.phoneButtton.selected;
    }
}

- (IBAction)passwordEndEditing:(UITextField *)sender {
    if (self.isPasswordLogin) {
        self.lockButton.selected = NO;
    } else {
        self.verifyImageButton.selected = NO;
    }
    [self updateResetButtonStatus];
}

- (IBAction)registerButtonWasPressed:(UIButton *)sender {
    [self.view endEditing:YES];
    RegisterViewController *registerController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerController
                                         animated:YES];
}

- (IBAction)forgetPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.isPasswordLogin = YES;
    } else {
        self.isPasswordLogin = NO;
    }
    [self updateLoginViewStyle];
    
}

@end
