//
//  MoneyRechargeViewController.m
//  qulicai
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MoneyRechargeViewController.h"
#import "ProductBuySuccessViewController.h"
#import "SenderVerifyCodeViewController.h"
#import "UserUtil.h"
#import "User.h"
#import "Bank.h"
#import "QRRequestHeader.h"
#import "RechargeInfo.h"
#import "FirstRongBaoSign.h"

@interface MoneyRechargeViewController ()
<UITextViewDelegate,
UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankCartLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bankLogoImageView;

@property (copy, nonatomic) NSArray *bankArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *bankContentLabel;


@end

@implementation MoneyRechargeViewController

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
    if (self.bankCartLabel.text.length > 16) {
        str = [NSString replaceStrWithRange:NSMakeRange(4, 12)
                                     string:[NSString getStringWithString:self.bankCartLabel.text]
                                 withString:@" **** **** **** "];
    } else  {
        str = [NSString replaceStrWithRange:NSMakeRange(4, 8)
                                     string:[NSString getStringWithString:self.bankCartLabel.text]
                                 withString:@" **** **** "];
    }

    self.bankCartLabel.text = str;
    for (int i = 0; i < [self.bankArray count]; i++) {
        NSDictionary *dic = self.bankArray[i];
        NSString *bankName = dic[@"bankName"];
        NSString *bankContent = dic[@"bankContent"];
        if ([bank.bankName isEqualToString:bankName]) {
            NSString *bankImageName = dic[@"bankImageName"];
            self.bankLogoImageView.image = [UIImage imageNamed:bankImageName];
            self.bankContentLabel.text = [NSString getStringWithString:bankContent];
        }
    }
}

- (void)setupViews {
    [self.view addTapGestureForDismissingKeyboard];
    [self.moneyTextField becomeFirstResponder];
    self.navigationItem.title = @"充值";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)updateResetButtonStatus {
    self.nextButton.enabled = [self.moneyTextField.text floatValue] > 0;
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
    if ([self.moneyTextField.text floatValue] < 50) {
        self.errorLabel.text = @"*充值金额小于最低充值金额";
        [self.errorLabel addShakeAnimation];
        return;
    }
    [self withnoAblancePayWithMoney:self.moneyTextField.text];
}

- (void)withnoAblancePayWithMoney:(NSString *)money {
    User *user = [UserUtil currentUser];
    Bank *bank = [user.appBanks firstObject];
    
    [self showSVProgressHUDWithStatus:@"充值处理中"];
    QRRequestQrongBaoSecondSign *query = [[QRRequestQrongBaoSecondSign alloc] init];
    query.userId = user.userId;
    query.userName = [UserUtil currentUser].realName;
    query.appType = 0;
    query.payType = 0;
    query.bindId = bank.bindId;
    query.totalFee = money;
    
    __weak typeof(self) weakSelf = self;
    [query startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"储蓄卡签约接口-第二次签约充值中::::::%@",request.responseJSONObject);
        [weakSelf dimissSVProgressHUD];
        //请求成功，返回银行卡信息
        FirstRongBaoSign *sign = [FirstRongBaoSign mj_objectWithKeyValues:request.responseJSONObject];
        //请求成功code = 0
        if (sign.statusType == IndentityStatusSuccess) {
            //发送到服务器
            NSLog(@"请求成功结果信息：：：：%@",sign.result_msg);
            if ([sign.result_code isEqualToString:@"0000"]) {
                //不是招商，跳转验证码界面
                SenderVerifyCodeViewController *payController = [[SenderVerifyCodeViewController alloc] init];
                payController.periodMoney = money;
                payController.orderNo = sign.order_no;
                payController.isRecharge = YES;
                [weakSelf.navigationController pushViewController:payController
                                                         animated:YES];
            } else {
                NSLog(@"第二次支付error::::%@",sign.result_msg);
                [weakSelf showErrorWithTitle:sign.result_msg];
            }
        } else {
            NSLog(@"第二次支付error::::%@",sign.result_msg);
            [weakSelf showErrorWithTitle:sign.result_msg];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"errror::::::%@",request.error);
        [weakSelf dimissSVProgressHUD];
        [weakSelf showErrorWithTitle:nil];
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
    NSLog(@"账户资金充值管理协议");
}

- (IBAction)xiqianPromise:(UIButton *)sender {
    NSLog(@"反洗钱承诺书");
}


@end
