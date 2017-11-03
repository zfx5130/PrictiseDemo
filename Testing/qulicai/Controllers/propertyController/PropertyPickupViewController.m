//
//  PropertyPickupViewController.m
//  qulicai
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "PropertyPickupViewController.h"
#import "ProductPasswordView.h"
#import "ASPopupController.h"
#import "PickUpSuccessViewController.h"
#import "ForgetPasswordViewController.h"
#import "Bank.h"
#import "UserUtil.h"
#import "User.h"
#import "PickupMoney.h"
#import "TransactionPwd.h"
#import "QRRequestHeader.h"
#import "QRWebViewController.h"

@interface PropertyPickupViewController ()
<UITextViewDelegate,
UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bankCartLabel;

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UIButton *pickUpButton;

@property (weak, nonatomic) IBOutlet UIImageView *bankLogoImageView;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@property (strong, nonatomic) ProductPasswordView *passwordView;

@property (strong, nonatomic) ASPopupController *popController;

@property (copy, nonatomic) NSString *password;

@property (copy, nonatomic) NSArray *bankArray;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;


@end

@implementation PropertyPickupViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self replaceBankCartNumber];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setters && Getters

- (NSArray *)bankArray {
    if (!_bankArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Bank" ofType:@"plist"];
        NSMutableArray *bankArr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        _bankArray = [bankArr copy];
    }
    return _bankArray;
}

#pragma mark - Private

- (void)replaceBankCartNumber {
    User *user = [UserUtil currentUser];
    Bank *bank = [user.appBanks firstObject];
    self.bankCartLabel.text = [NSString getStringWithString:bank.bankNo];
    self.bankNameLabel.text = [NSString getStringWithString:bank.bankName];
    NSString *str = @"";
    if (bank) {
        if (self.bankCartLabel.text.length > 16) {
            str = [NSString replaceStrWithRange:NSMakeRange(4, 12)
                                         string:[NSString getStringWithString:self.bankCartLabel.text]
                                     withString:@" **** **** **** "];
        } else  {
            str = [NSString replaceStrWithRange:NSMakeRange(4, 8)
                                         string:[NSString getStringWithString:self.bankCartLabel.text]
                                     withString:@" **** **** "];
        }
    }
    self.bankCartLabel.text = str;
    
    for (int i = 0; i < [self.bankArray count]; i++) {
        NSDictionary *dic = self.bankArray[i];
        NSString *bankName = dic[@"bankName"];
        if ([bank.bankName isEqualToString:bankName]) {
            NSString *bankImageName = dic[@"bankImageName"];
            self.bankLogoImageView.image = [UIImage imageNamed:bankImageName];
        }
    }
    self.balanceLabel.text =
    [NSString stringWithFormat:@"账户余额%@元",[NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(user.availableMoney)]]];
    
}

- (void)setupViews {
    [self.view addTapGestureForDismissingKeyboard];
    [self.moneyTextField becomeFirstResponder];
    self.navigationItem.title = @"提现";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)updateResetButtonStatus {
    self.pickUpButton.enabled = [self.moneyTextField.text floatValue] > 0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (IS_IPHONE_5) {
        [self.view endEditing:YES];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0) {
        CGFloat alpha = 1;
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self config];
    return YES;
}

#pragma mark - Handlers

- (void)config {
    [self.view endEditing:YES];
    if ([self.moneyTextField.text floatValue] < 100) {
        self.errorLabel.text = @"*提现金额小于最低取现金额";
        [self.errorLabel addShakeAnimation];
        return;
    } else if ([self.moneyTextField.text floatValue] > [UserUtil currentUser].availableMoney) {
        self.errorLabel.text = @"*提现金额不得超过可用余额";
        [self.errorLabel addShakeAnimation];
        return;
    }
    //输入交易密码
    [self inputPickPW];
    
}

- (void)inputPickPW {
    CGFloat width = IS_IPHONE_5 ? 260.0f : 300.0f;
    self.passwordView =
    [[ProductPasswordView alloc] initWithFrame:CGRectMake(0.0f, -100.0f, width, 200)];
    
    [self.passwordView.cancleButton addTarget:self
                                       action:@selector(passwordDismiss)
                             forControlEvents:UIControlEventTouchUpInside];

    [self.passwordView.forgetPasswordButton addTarget:self
                                               action:@selector(forgetButtonWasPressed)
                                     forControlEvents:UIControlEventTouchUpInside];
    self.popController =
    [ASPopupController  alertWithPresentStyle:ASPopupPresentStyleSlideDown
                                 dismissStyle:ASPopupDismissStyleSlideDown
                                    alertView:self.passwordView];
    [self.popController setAlertViewCornerRadius:20.0f];
    __weak typeof(self) weakSelf = self;
    self.passwordView.pwBlock = ^(NSString *password) {
        weakSelf.password = password;
        [weakSelf configurePassword];
    };
    [self presentViewController:self.popController
                       animated:YES
                     completion:nil];
}

- (void)forgetButtonWasPressed {
    ForgetPasswordViewController *passwordController = [[ForgetPasswordViewController alloc] init];
    passwordController.isPickUpPw = YES;
    passwordController.isTradingPw = YES;
    [self.navigationController pushViewController:passwordController
                                         animated:YES];
    [self passwordDismiss];
}

- (void)passwordDismiss {
    [self.view endEditing:YES];
    if (self.popController) {
        [self.popController dismissViewControllerAnimated:YES
                                               completion:nil];
    }
}

- (void)configurePassword {
    
    [self passwordDismiss];
    [self showSVProgressHUD];
    QRrequestVerifyTrasPwd *request = [[QRrequestVerifyTrasPwd alloc] init];
    request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
    request.transactionPwd = [NSString getStringWithString:self.password];
    [self showSVProgressHUD];
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        TransactionPwd *pickup = [TransactionPwd mj_objectWithKeyValues:request.responseJSONObject];
        [weakSelf dimissSVProgressHUD];
        NSLog(@"验证交易密码接口::::%@",request.responseJSONObject);
        BOOL isVerify = [request.responseJSONObject[@"data"][@"verify"] boolValue];
        [weakSelf saveToken:pickup.token];
        if (pickup.statusType == IndentityStatusSuccess) {
            if (isVerify) {
                NSLog(@"提现交易密码验证成功");
                [weakSelf showSuccessWithTitle:@"验证成功提现中"];
                //提现接口
                QRRequestMoneyPickup *request = [[QRRequestMoneyPickup alloc] init];
                request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
                request.money = [self.moneyTextField.text floatValue];
                Bank *bank = [[UserUtil currentUser].appBanks firstObject];
                request.bankNo = [NSString getStringWithString:bank.bankNo];
                [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [weakSelf dimissSVProgressHUD];
                    NSLog(@"提现接口::::%@",request.responseJSONObject);
                    PickupMoney *pickup = [PickupMoney mj_objectWithKeyValues:request.responseJSONObject];
                    [weakSelf saveToken:pickup.token];
                    if (pickup.statusType == IndentityStatusSuccess) {
                        [weakSelf showSuccessWithTitle:@"提现成功"];
                        PickUpSuccessViewController *successController = [[PickUpSuccessViewController alloc] init];
                        [weakSelf.navigationController pushViewController:successController
                                                                 animated:YES];
                    } else {
                        [weakSelf showErrorWithTitle:@"提现失败"];
                    }
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [weakSelf dimissSVProgressHUD];
                    //NSLog(@"error:%@",request.error);
                    [weakSelf showErrorWithTitle:@"提现失败"];
                }];
            } else {
                [weakSelf dimissSVProgressHUD];
                [weakSelf showErrorWithTitle:@"交易验证失败"];
            }
        } else if (pickup.statusType == IndentityStatusTypeInvalid) {
            [weakSelf outLogininWithController:weakSelf];
        } else {
            [self showErrorWithTitle:@"交易验证失败"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        [self showErrorWithTitle:@"交易验证失败"];
    }];
}

- (IBAction)editingChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)editingBegined:(UITextField *)sender {
    self.errorLabel.text = @"";
    [self updateResetButtonStatus];
}

- (IBAction)config:(UIButton *)sender {
    [self config];
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pickInfo:(UIButton *)sender {

    NSString *urlString = @"http://h5.qulicai8.com:3478/qlc_agreement_withdraw.html ";
    QRWebViewController *webViewController = [[QRWebViewController alloc] initWithTitle:@"提现注意事项"
                                                                              URLString:urlString];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}

@end
