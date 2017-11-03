//
//  RegisterViewController.m
//  qulicai
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "RegisterViewController.h"
#import "SendVerifyCodeButton.h"
#import "QRWebViewController.h"
#import "QRRequestHeader.h"
#import "User.h"
#import "VerifyCode.h"
#import "UserUtil.h"
#import "NSString+Check.h"

@interface RegisterViewController ()
<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

@property (weak, nonatomic) IBOutlet UIButton *verifyButton;

@property (weak, nonatomic) IBOutlet UIButton *lockButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;

@property (weak, nonatomic) IBOutlet UITextField *lockTextField;

//验证码
@property (weak, nonatomic) IBOutlet SendVerifyCodeButton *verifyCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headImageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerButtonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RegisterViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"back_image"]];
    [self.phoneTextField becomeFirstResponder];
    [self wr_setNavBarBackgroundAlpha:0];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    [self.view addTapGestureForDismissingKeyboard];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.headImageHeightConstraint.constant = SCREEN_WIDTH * 150 / IPHONE6_WIDTH;
    if (IS_IPHONE_5) {
        self.registerButtonTopConstraint.constant = 25.0f;
        self.centerViewHeightConstraint.constant = 145.0f;
    }
}

- (void)updateResetButtonStatus {
    self.registerButton.enabled =
    self.lockTextField.text.length >= 6 && self.phoneTextField.text.length && self.verifyTextField.text.length;
}

- (void)registerUser {
    [self.view endEditing:YES];
    if (self.phoneTextField.text.length < 11) {
        self.errorLabel.text = @"*对不起手机号码有误";
        [self.errorLabel addShakeAnimation];
        return;
    }
    
    if (self.lockTextField.text.length < 6 || self.lockTextField.text.length > 16) {
        self.errorLabel.text =
        self.lockTextField.text.length >16 ? @"*对不起密码仅支持16以内的数字或字母" : @"*对不起密码不足6位";
        [self.errorLabel addShakeAnimation];
        return;
    }
    
    if (![self.lockTextField.text checkPassword]) {
        self.errorLabel.text =  @"*密码格式不合法";
        [self.errorLabel addShakeAnimation];
        return;
    }
    
    [self showSVProgressHUD];
    QRRequestUserRegister *request = [[QRRequestUserRegister alloc] init];
    request.mobilePhone = self.phoneTextField.text;
    request.password = self.lockTextField.text;
    request.code = self.verifyTextField.text;
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        SLog(@"注册请求结果::::::::::%@",request.responseJSONObject);
        User *user = [User mj_objectWithKeyValues:request.responseJSONObject];
        [weakSelf dimissSVProgressHUD];
        if (user.statusType == IndentityStatusSuccess) {
            //掉用登录接口
            QRRequestLogin *request = [[QRRequestLogin alloc] init];
            request.mobilePhone = self.phoneTextField.text;
            request.password = self.lockTextField.text;
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                User *user = [User mj_objectWithKeyValues:request.responseJSONObject];
                SLog(@"注册完登录信息::::%@:::::\n:::token::%@",request.responseJSONObject, user.token);
                [weakSelf saveToken:user.token];
                if (user.statusType == IndentityStatusSuccess) {
                    //获取用户信息
                    QRRequestGetUserInfo *request = [[QRRequestGetUserInfo alloc] init];
                    request.userId = user.userId;
                    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        [weakSelf dimissSVProgressHUD];
                        User *userInfo = [User mj_objectWithKeyValues:request.responseJSONObject];
                        [weakSelf saveToken:userInfo.token];
                        SLog(@"登录成功user信息::::::::::%@",request.responseJSONObject);
                        if (userInfo.statusType == IndentityStatusSuccess) {
                            [UserUtil saving:userInfo];
                            [weakSelf showSuccessWithTitle:@"登录成功"];
                            PostNotification(QR_OUTLOGIN_UPDATE_HEAD_VIEW_STAUTS);
                            [weakSelf.navigationController dismissViewControllerAnimated:YES
                                                                              completion:nil];
                        } else {
                            NSString *error = user.desc;
                            [weakSelf showTipErrorWithTitle:error];
                        }
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        NSLog(@"error:- %@", request.error);
                    }];
                    
                } else {
                    [weakSelf dimissSVProgressHUD];
                    NSString *error = user.desc;
                    [self showTipErrorWithTitle:error];
                }
                
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf dimissSVProgressHUD];
                NSLog(@"error:- %@", request.error);
            }];
        } else {
            [weakSelf dimissSVProgressHUD];
            NSString *error = user.desc;
            [weakSelf showTipErrorWithTitle:error];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        NSLog(@"error:- %@", request.error);
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.phoneTextField) {
        [self registerUser];
    }
    return YES;
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editingChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
    if (sender == self.phoneTextField) {
        if (sender.text.length > 11) {
            sender.text = [sender.text substringToIndex:11];
        }
    }
}

- (IBAction)editingBegin:(UITextField *)sender {
    self.errorLabel.text = @"";
    if (sender == self.phoneTextField) {
        self.phoneButton.selected = YES;
        self.lockButton.selected = !self.phoneButton.selected;
        self.verifyButton.selected = !self.phoneButton.selected;
    } else if (sender == self.verifyTextField) {
        self.verifyButton.selected = YES;
        self.lockButton.selected = !self.verifyButton.selected;
        self.phoneButton.selected = !self.verifyButton.selected;
    } else {
        self.lockButton.selected = YES;
        self.verifyButton.selected = !self.lockButton.selected;
        self.phoneButton.selected = !self.lockButton.selected;
    }
    [self updateResetButtonStatus];
}

- (IBAction)editingEnded:(UITextField *)sender {
    if (sender == self.phoneTextField) {
        self.phoneButton.selected = NO;
    } else if (sender == self.verifyTextField) {
        self.verifyButton.selected = NO;
    } else {
        self.lockButton.selected = NO;
    }
    [self updateResetButtonStatus];
}

- (IBAction)verifyCodeButtonWasPressed:(SendVerifyCodeButton *)sender {
    [self.view endEditing:YES];
    if (self.phoneTextField.text.length < 11) {
        self.errorLabel.text = @"*对不起手机号码有误";
        [self.errorLabel addShakeAnimation];
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
    request.codeType = VerifyCodeTypeRegister;
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        NSLog(@"注册验证码获取信息:::::%@",request.responseJSONObject);
        VerifyCode *verify = [VerifyCode mj_objectWithKeyValues:request.responseJSONObject];
        [weakSelf saveToken:verify.token];
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

- (IBAction)registerButtonWasPressed:(UIButton *)sender {
    [self registerUser];
}

- (IBAction)QRAgreement:(UIButton *)sender {
    //趣融管理协议
    NSString *urlString = @"http://h5.qulicai8.com:3478/qlc_agreement_register.html";
    QRWebViewController *webViewController = [[QRWebViewController alloc] initWithTitle:@"趣理财管理协议"
                                                                              URLString:urlString];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}

@end
