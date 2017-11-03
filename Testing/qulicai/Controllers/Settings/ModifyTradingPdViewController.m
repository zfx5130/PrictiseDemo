//
//  ModifyTradingPdViewController.m
//  qulicai
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ModifyTradingPdViewController.h"
#import "ForgetPasswordViewController.h"
#import "UserUtil.h"
#import "User.h"
#import "QRRequestHeader.h"
#import "UpdateTransactionPassword.h"

@interface ModifyTradingPdViewController ()
<UITextFieldDelegate,
UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordLabel;

@property (weak, nonatomic) IBOutlet UITextField *nowPasswordLabel;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveButtonTopConstrait;


@end

@implementation ModifyTradingPdViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    [self.oldPasswordLabel becomeFirstResponder];
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

- (void)setupViews {
    [self.view addTapGestureForDismissingKeyboard];
    if (IS_IPHONE_5) {
        self.saveButtonTopConstrait.constant = 80.0f;
    }
    self.navigationItem.title = @"修改交易密码";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)updateResetButtonStatus {
    self.saveButton.enabled =
    self.oldPasswordLabel.text.length && self.nowPasswordLabel.text.length >= 6;
}

- (void)save {
    
    [self.view endEditing:YES];
    if (self.oldPasswordLabel.text.length != 6 ) {
        self.errorLabel.text = @"*旧密码输入格式不正确";
        [self.errorLabel addShakeAnimation];
        return;
    }
    if (self.nowPasswordLabel.text.length != 6) {
        self.errorLabel.text = @"*对不起密码仅支持6以内的数字";
        [self.errorLabel addShakeAnimation];
        return;
    }
    
    if (self.oldPasswordLabel.text == self.nowPasswordLabel.text) {
        self.errorLabel.text = @"新密码与旧密码相同";
        [self.errorLabel addShakeAnimation];
        return;
    }
    [self showSVProgressHUD];
    QRRequestModifyTransPassword *request = [[QRRequestModifyTransPassword alloc] init];
    request.userId = [UserUtil currentUser].userId;
    request.transactionPwd = self.oldPasswordLabel.text;
    request.lastestTransactionPwd = self.nowPasswordLabel.text;
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        NSLog(@"修改交易密码结果:::::%@",request.responseJSONObject);
        UpdateTransactionPassword *password = [UpdateTransactionPassword mj_objectWithKeyValues:request.responseJSONObject];
        NSLog(@"erorr::::%@",password.desc);
        [weakSelf saveToken:password.token];
        if (password.statusType == IndentityStatusSuccess) {
            [weakSelf showSuccessWithTitle:@"密码修改成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else if (password.statusType == IndentityStatusTypeInvalid) {
            [weakSelf outLogininWithController:weakSelf];
        } else {
            [weakSelf showTipErrorWithTitle:password.desc];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        NSLog(@"error-::::%@",request.error);
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self save];
    return YES;
}

#pragma mark - Handlers

- (IBAction)editingChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)editingBegin:(UITextField *)sender {
    self.errorLabel.text = @"";
    [self updateResetButtonStatus];
}


- (IBAction)editingEnd:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)save:(UIButton *)sender {
    [self save];
}

- (IBAction)forgerPassword:(UIButton *)sender {
    [self.view endEditing:YES];
    ForgetPasswordViewController *forgetPasswordController = [[ForgetPasswordViewController alloc] init];
    forgetPasswordController.isTradingPw = YES;
    [self.navigationController pushViewController:forgetPasswordController
                                         animated:YES];
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
