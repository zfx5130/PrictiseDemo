//
//  ResetPasswordViewController.m
//  qulicai
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "SettingsTableViewController.h"
#import "ProductBuySuccessViewController.h"
#import "PropertyPickupViewController.h"
#import "QRRequestHeader.h"
#import "FindLoginPassword.h"
#import "SettingTransPassword.h"
#import "UserUtil.h"
#import "User.h"
#import "LoginViewController.h"
#import "PropertyPickupViewController.h"
#import "AddBankCardViewController.h"
#import "AccountCertificationViewController.h"
#import "CorePasswordView.h"
#import "ConfigPayViewController.h"
#import "NSString+Check.h"

@interface ResetPasswordViewController ()
<UITextFieldDelegate,
UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmButtonTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *tradeHolderView;

@property (weak, nonatomic) IBOutlet CorePasswordView *passwordView;

@property (copy, nonatomic) NSString *password;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transPwViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *transPwHeightConstraint;

@end

@implementation ResetPasswordViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
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
    if (IS_IPHONE_5) {
        self.transPwHeightConstraint.constant = 80.0f;
        self.transPwViewWidthConstraint.constant = 280.0f;
    }
    if (!self.isTradingPw) {
        [self.view addTapGestureForDismissingKeyboard];
    }
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    self.titleNameLabel.text = self.isTradingPw ? @"设置交易密码" : @"设置登录密码";
    self.tradeHolderView.hidden = self.isTradingPw ? NO : YES;
    if (IS_IPHONE_5) {
        self.confirmButtonTopConstraint.constant = 60.0f;
    }
    if (!self.isTradingPw) {
        [self.passwordTextField becomeFirstResponder];
    } else {
       
        self.passwordView.isTradePwView = YES;
        [self.passwordView beginInput];
        __weak typeof(self) weakSelf = self;
        self.passwordView.PasswordCompeleteBlock = ^(NSString *password) {
            weakSelf.password  = password;
            weakSelf.confirmButton.enabled = (password.length == 6);
        };
        
        self.passwordView.TextFieldEditChanged = ^(BOOL isEnd) {
            weakSelf.confirmButton.enabled = isEnd;
        };
    }
    
    self.navigationItem.title = self.isTradingPw ? @"设置交易密码" : @"设置登录密码";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];

}

- (void)updateResetButtonStatus {
    self.confirmButton.enabled =
    self.passwordTextField.text.length >= 6;
}

- (void)confirm {
    
    if (!self.isTradingPw) {
        [self.view endEditing:YES];
        if (self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 16) {
            self.errorLabel.text =
            self.passwordTextField.text.length > 16 ? @"*对不起密码仅支持16以内的数字或字母" : @"*对不起密码不足6位";
            [self.errorLabel addShakeAnimation];
            return;
        }
        if (![self.passwordTextField.text checkPassword]) {
            self.errorLabel.text =  @"*密码格式不合法";
            [self.errorLabel addShakeAnimation];
            return;
        }
    }
    
    [self showSVProgressHUD];
    if (self.isTradingPw) {
        if (!self.isFirstSetingTradPw) {
            //修改交易密码
            QRRequestResetTransPassword *request = [[QRRequestResetTransPassword alloc] init];
            request.userId = [UserUtil currentUser].userId;
            request.transactionPwd = self.password;
            request.code = self.verifyCode;
            __weak typeof(self) weakSelf = self;
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf dimissSVProgressHUD];
                NSLog(@":重置交易密码结果__::::%@",request.responseJSONObject);
                SettingTransPassword *transPassword = [SettingTransPassword mj_objectWithKeyValues:request.responseJSONObject];
                [weakSelf saveToken:transPassword.token];
                NSLog(@":重置交易密码结果desc__::::%@",transPassword.desc);
                if (transPassword.statusType == IndentityStatusSuccess) {
                    [weakSelf showSuccessWithTitle:@"交易密码密码设置成功"];
                    if (weakSelf.isPickUpPw) {
                        for( UIViewController *controller in self.navigationController.viewControllers ) {
                            if( [controller isKindOfClass:[PropertyPickupViewController class]] ) {
                                [weakSelf.navigationController popToViewController:controller animated:YES];
                                return ;
                            }
                        }
                    } else if (weakSelf.isBuyRechargePw) {
                        for( UIViewController *controller in self.navigationController.viewControllers ) {
                            if( [controller isKindOfClass:[ConfigPayViewController class]] ) {
                                [weakSelf.navigationController popToViewController:controller animated:YES];
                                return ;
                            }
                        }
                    } else {
                        for( UIViewController *controller in weakSelf.navigationController.viewControllers ) {
                            if( [controller isKindOfClass:[SettingsTableViewController class]] ) {
                                [weakSelf.navigationController popToViewController:controller animated:YES];
                                return ;
                            }
                        }
                    }
                } else if (transPassword.statusType == IndentityStatusTypeInvalid) {
                    [weakSelf outLogininWithController:weakSelf];
                } else {
                    NSLog(@"error:::::%@",request.error);
                    [weakSelf showTipErrorWithTitle:transPassword.desc];
                }
                
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf dimissSVProgressHUD];
                NSLog(@"error:::--%@",request.error);
            }];
        } else {
            //设置交易密码
            QRRequestSetingTranPassword *request = [[QRRequestSetingTranPassword alloc] init];
            request.userId = [UserUtil currentUser].userId;
            request.transactionPwd = self.password;
            __weak typeof(self) weakSelf = self;
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf dimissSVProgressHUD];
                NSLog(@"resulr:_设置交易密码__::::%@",request.responseJSONObject);
                SettingTransPassword *transPassword = [SettingTransPassword mj_objectWithKeyValues:request.responseJSONObject];
                [weakSelf saveToken:transPassword.token];
                if (transPassword.statusType == IndentityStatusSuccess) {
                    //设置交易密码跳转
                    [weakSelf showSuccessWithTitle:@"交易密码设置成功跳转中"];
                    QRRequestGetUserInfo *request = [[QRRequestGetUserInfo alloc] init];
                    request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
                    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        User *userInfo = [User mj_objectWithKeyValues:request.responseJSONObject];
                        [weakSelf saveToken:userInfo.token];
                        if (userInfo.statusType == IndentityStatusSuccess) {
                            [UserUtil saving:userInfo];
                                //判断是否认证。
                            User *user = [UserUtil currentUser];
                            if (user.authStatusType == AuthenticationStatusSuccess) {
                                //添加银行卡
                                AddBankCardViewController *addBankController = [[AddBankCardViewController alloc] init];
                                addBankController.money = self.money;
                                addBankController.periodMoney = self.periodMoney;
                                addBankController.totalMoney = self.totalMoney;
                                addBankController.isRecharge = self.isRecharge;
                                addBankController.ticketId = self.ticketId;
                                [weakSelf.navigationController pushViewController:addBankController
                                                                         animated:YES];
                            } else {
                                //跳转认证界面
                                AccountCertificationViewController *accountController = [[AccountCertificationViewController alloc] init];
                                accountController.isFirstRechargePush = YES;
                                accountController.money = self.money;
                                accountController.periodMoney = self.periodMoney;
                                accountController.productId = self.productId;
                                accountController.totalMoney = self.totalMoney;
                                accountController.isRecharge = self.isRecharge;
                                accountController.ticketId = self.ticketId;
                                [self.navigationController pushViewController:accountController
                                                                     animated:YES];
                            }
                            
                        } else if (userInfo.statusType == IndentityStatusTypeInvalid) {
                            [weakSelf outLogininWithController:weakSelf];
                        } else {
                            NSLog(@"error:::::%@",request.error);
                        }
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        NSLog(@"error:- %@", request.error);
                    }];
                    
                } else if (transPassword.statusType == IndentityStatusTypeInvalid) {
                    [weakSelf outLogininWithController:weakSelf];
                } else {
                    [weakSelf showTipErrorWithTitle:transPassword.desc];
                }
                
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf dimissSVProgressHUD];
                NSLog(@"error:::--%@",request.error);
            }];
        }
        
    } else {
        QRRequestFindLoginPassword *request = [[QRRequestFindLoginPassword alloc] init];
        request.mobilePhone = self.phone;
        request.pwd = self.passwordTextField.text;
        request.code = self.verifyCode;
        __weak typeof(self) weakSelf = self;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf dimissSVProgressHUD];
            NSLog(@"resulr:设置登录密码___::::%@",request.responseJSONObject);
            FindLoginPassword *findPassword = [FindLoginPassword mj_objectWithKeyValues:request.responseJSONObject];
            if (findPassword.statusType == IndentityStatusSuccess) {
                [weakSelf showSuccessWithTitle:@"登录密码设置成功"];
                if (self.isRegisterSwip) {
                    for( UIViewController *controller in self.navigationController.viewControllers ) {
                        if( [controller isKindOfClass:[LoginViewController class]] ) {
                            [self.navigationController popToViewController:controller animated:YES];
                            return ;
                        }
                    }
                } else {
                    for( UIViewController *controller in self.navigationController.viewControllers ) {
                        if( [controller isKindOfClass:[SettingsTableViewController class]] ) {
                            [self.navigationController popToViewController:controller animated:YES];
                            return ;
                        }
                    }
                }
            } else {
                [weakSelf showTipErrorWithTitle:findPassword.desc];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf dimissSVProgressHUD];
            NSLog(@"error-:::%@",request.error);
        }];
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self confirm];
    return YES;
}

#pragma mark - Handlers

- (IBAction)beginEditing:(UITextField *)sender {
    self.errorLabel.text = @"";
}

- (IBAction)editingChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)editingEnded:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)confirm:(UIButton *)sender {
    [self confirm];
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
