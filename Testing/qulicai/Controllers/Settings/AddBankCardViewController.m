//
//  AddBankCardViewController.m
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "BankCardSelectedViewController.h"
#import "ResetPasswordViewController.h"
#import "QRRequestHeader.h"
#import "UserUtil.h"
#import "User.h"
#import "VerifyCardPay.h"
#import "RechargeInfo.h"
#import "ProductBuySuccessViewController.h"
#import "AddPhoneNumViewController.h"
#import "ProductBuy.h"

@interface AddBankCardViewController ()
<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;

@property (weak, nonatomic) IBOutlet UITextField *bankCartNumberLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLeftLabelConstraint;

@property (nonatomic, strong) NSMutableDictionary *orderDic;

@property (copy, nonatomic) NSString *resultTitle;

@end

@implementation AddBankCardViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    [self.view addTapGestureForDismissingKeyboard];
    self.nameLabel.text =
    [NSString stringWithFormat:@"%@",[UserUtil currentUser].realName];
    if (IS_IPHONE_5) {
        self.bottomLeftLabelConstraint.constant = -88.0f;
    }
    self.navigationItem.title = @"添加银行卡";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)updateResetButtonStatus {
    self.nextButton.enabled = self.bankCartNumberLabel.text.length;
}

- (void)save {
    [self.view endEditing:YES];
    if (self.bankCartNumberLabel.text.length < 8) {
        [self showTipErrorWithTitle:@"银行卡号有误"];
        return;
    }
    //充值
    [self requestPayWithCardNumber:self.bankCartNumberLabel.text];
}

- (void)requestPayWithCardNumber:(NSString *)cartNumber {
    
    [self showSVProgressHUDWithStatus:@"银行卡识别中"];
    NSString *cardNumberStr = [[NSString getStringWithString:cartNumber] stringByReplacingOccurrencesOfString:@" " withString:@""];
    QRRequestLLPayBinQuery *query = [[QRRequestLLPayBinQuery alloc] init];
    query.cardNo = cardNumberStr;
    
    query.userId = [UserUtil currentUser].userId;
    //测试调用
    query.userName = [UserUtil currentUser].realName;
    query.appType = 0;
    query.payType = 0;
    __weak typeof(self) weakSelf = self;
    [query startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"网关后台Card查询::::::%@",request.responseJSONObject);
        [weakSelf dimissSVProgressHUD];
        //请求成功，返回银行卡信息
        VerifyCardPay *card = [VerifyCardPay mj_objectWithKeyValues:request.responseJSONObject];
        //请求成功code = 0
        if (card.statusType == IndentityStatusSuccess) {
            //发送到服务器
            if ([card.result_code isEqualToString:@"0000"]) {
                //卡bin查询成功
                //调转到填写预留手机号
                [weakSelf showSuccessWithTitle:@"银行卡识别成功"];
                AddPhoneNumViewController *phoneController = [[AddPhoneNumViewController alloc] init];
                phoneController.cardPay = card;
                phoneController.periodMoney = weakSelf.periodMoney;
                phoneController.bankCardNo = cardNumberStr;
                phoneController.productId = weakSelf.productId;
                phoneController.money = weakSelf.money;
                phoneController.isRecharge = weakSelf.isRecharge;
                phoneController.ticketId = weakSelf.ticketId;
                NSLog(@"添加银行卡:::::%@",weakSelf.totalMoney);
                phoneController.totalMoney = weakSelf.totalMoney;
                [weakSelf.navigationController pushViewController:phoneController
                                                         animated:YES];
            } else {
                [weakSelf showTipErrorWithTitle:card.result_msg];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"errror::::::%@",request.error);
        [weakSelf dimissSVProgressHUD];
    }];
    
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

#pragma mark - UITextViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL isFlag = self.bankCartNumberLabel.text.length;
    if (isFlag) {
        [self save];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if (textField == self.bankCartNumberLabel) {
        if ([string isEqualToString:@""]) { 
            if ((textField.text.length - 2) % 5 == 0) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
        } else {
            if (textField.text.length % 5 == 0) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
            }
        }
        return YES;
    }
    return YES;
}

#pragma mark - Handlers

- (IBAction)showBankList:(UIButton *)sender {
    BankCardSelectedViewController *bankCardController = [[BankCardSelectedViewController alloc] init];
    [self.navigationController pushViewController:bankCardController
                                         animated:YES];
}

- (IBAction)editingChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)editingBegin:(UITextField *)sender {
    [self updateResetButtonStatus];
}


- (IBAction)editingEnd:(UITextField *)sender {
    [self updateResetButtonStatus];
}

- (IBAction)save:(UIButton *)sender {
    [self save];
}

- (void)leftBarButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)agreeProtocol:(UIButton *)sender {
    NSLog(@"账户存管协议");
}

- (IBAction)applyProtocol:(UIButton *)sender {
    NSLog(@"支付服务协议");
}

@end
