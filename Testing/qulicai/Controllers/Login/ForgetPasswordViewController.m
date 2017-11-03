//
//  ForgetPasswordViewController.m
//  qulicai
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SendVerifyCodeButton.h"
#import "ResetPasswordViewController.h"
#import "User.h"
#import "UserUtil.h"
#import "QRRequestHeader.h"
#import "VerifyCode.h"

@interface ForgetPasswordViewController ()
<UITextFieldDelegate,
UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet SendVerifyCodeButton *verifyButton;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
//130 70
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewHeightaConstraint;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonTopConstrant;

@end

@implementation ForgetPasswordViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    [self setupViews];
    [self.phoneTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    //NSLog(@"::::::::%@:::",@(offsetY));
    if (offsetY >= 0) {
        CGFloat alpha = 1;
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

#pragma mark - Private

- (void)setupView {
    [self.view addTapGestureForDismissingKeyboard];
    if (IS_IPHONE_5) {
        self.nextButtonTopConstrant.constant = 60.0f;
    }
    self.navigationItem.title = self.isTradingPw ? @"找回交易密码" : @"找回登录密码";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)setupViews {
    self.titleLabel.text = self.isTradingPw ? @"找回交易密码" : @"找回登录密码";
}

- (void)updateResetButtonStatus {
    self.nextButton.enabled =
    self.phoneTextField.text.length && self.verifyTextField.text.length >= 6;
}

- (void)nextStep {
    
    [self.view endEditing:YES];
    if (self.phoneTextField.text.length < 11) {
        self.errorLabel.text = @"*对不起手机号码有误";
        [self.errorLabel addShakeAnimation];
        return;
    }
    
    if (!self.verifyTextField.text.length) {
        self.errorLabel.text = @"*验证码不能为空";
        [self.errorLabel addShakeAnimation];
        return;
    }
    
    ResetPasswordViewController *resetController = [[ResetPasswordViewController alloc] init];
    resetController.phone = self.phoneTextField.text;
    resetController.isTradingPw = self.isTradingPw;
    resetController.isPickUpPw = self.isPickUpPw;
    resetController.verifyCode = self.verifyTextField.text;
    resetController.isRegisterSwip = self.isRegisterSwip;
    resetController.isBuyRechargePw = self.isBuyRechargePw;
    [self.navigationController pushViewController:resetController
                                         animated:YES];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.verifyTextField) {
        [self nextStep];
    }
    return YES;
}

#pragma mark - Handlers

- (IBAction)verify:(SendVerifyCodeButton *)sender {
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
    request.codeType = self.isTradingPw ? VerifyCodeTypeTransPW : VerifyCodeTypeLoginPW;
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

- (IBAction)editingBegin:(UITextField *)sender {
    if (self.errorLabel.text.length) {
        self.errorLabel.text = @"";
    }
    [self updateResetButtonStatus];
}

- (IBAction)editingChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
    if (sender == self.phoneTextField) {
        if (sender.text.length > 11) {
            sender.text = [sender.text substringToIndex:11];
        }
    }
}

- (IBAction)editingEnded:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)next:(UIButton *)sender {
    [self nextStep];
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
