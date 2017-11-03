//
//  SenderVerifyCodeViewController.m
//  qulicai
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "SenderVerifyCodeViewController.h"
#import "PackBuySuccessViewController.h"
#import "RechangeProcessingViewController.h"
#import "CorePasswordView.h"
#import "SendVerifyCodeButton.h"
#import "User.h"
#import "UserUtil.h"
#import "QRRequestHeader.h"
#import "RongBaoPayConfig.h"
#import "QuRongVerifyCode.h"
#import "ProductBuy.h"
#import "BuyFailViewController.h"
#import "RechargeStatusViewController.h"

@interface SenderVerifyCodeViewController ()
<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet CorePasswordView *passwordView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet SendVerifyCodeButton *sendVerifyButton;

@end

@implementation SenderVerifyCodeViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupPasswordView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addTapGestureForDismissingKeyboard];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    [self sendVerifyCode];
    NSLog(@"::::totalMoeny::%@",self.totalMoney);
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

- (void)sendVerifyCode {
    NSString *phone = self.phone.length > 0 ? self.phone : @"123456";
    [self.sendVerifyButton sendVerifyCodeWithPhone:phone
                                        isBankCode:YES];
}

- (void)setupViews {
    NSString *phone = @"";
    if (self.phone.length > 5) {
        phone = [NSString stringWithFormat:@"为%@",[NSString replaceStrWithRange:NSMakeRange(3, 4)
                                                                         string:self.phone
                                                                     withString:@"****"]];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"已向你手机号%@发送验证码，请查收。",phone];
    
    self.navigationItem.title = @"输入手机验证码";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)payConfigWithVerifyCode:(NSString *)verifyCode {
    
    //调用确认支付接口
    User *user = [UserUtil currentUser];
    [self showSVProgressHUDWithStatus:@"交易处理中"];
    
    QRRequestRongBaoPayConfig *payConfig = [[QRRequestRongBaoPayConfig alloc] init];
    payConfig.userId = user.userId;
    payConfig.appType = 0;
    payConfig.payType = 0;
    NSLog(@"充值money:::::%@",self.money);
    NSLog(@"购买充值的money::::::%@",self.periodMoney);
    NSString *moneyStr =
    [NSString getStringWithString:self.money].length > 0 ? self.money : self.periodMoney;
    
    NSLog(@"购买充值的：：：：：::::::%@",self.money);
    
    payConfig.totalFee = [NSString getStringWithString:moneyStr];
    payConfig.orderNo = self.orderNo;
    payConfig.checkCode = verifyCode;
    payConfig.userName = user.realName;
    __weak typeof(self) weakSelf = self;
    NSLog(@"融宝充值金钱：：：：%@",moneyStr);
    [payConfig startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"融宝确认充值支付返回结果::::::%@",request.responseJSONObject);
        [weakSelf dimissSVProgressHUD];
        //请求成功，返回银行卡信息
        RongBaoPayConfig *pay = [RongBaoPayConfig mj_objectWithKeyValues:request.responseJSONObject];
        //请求成功code = 0
        if (pay.statusType == IndentityStatusSuccess) {
            //发送到服务器
            NSLog(@"ero::r:::%@",pay.result_msg);
            if (weakSelf.isRecharge) {
                if ([pay.result_code isEqualToString:@"0000"]) {
                    RechargeStatusViewController *failControoler = [[RechargeStatusViewController alloc] init];
                    failControoler.isRechargeSuccess = YES;
                    [weakSelf.navigationController pushViewController:failControoler
                                                             animated:YES];
                } else if ([pay.result_code isEqualToString:@"3083"] || [pay.result_code isEqualToString:@"3081"]) {
                    RechangeProcessingViewController *processController = [[RechangeProcessingViewController alloc] init];
                    [weakSelf.navigationController pushViewController:processController
                                                             animated:YES];
                } else {
                    RechargeStatusViewController *failControoler = [[RechargeStatusViewController alloc] init];
                    failControoler.isRechargeSuccess = NO;
                    failControoler.errorMessage = pay.result_msg;
                    [weakSelf.navigationController pushViewController:failControoler
                                                             animated:YES];
                }
            } else {
                //购买
                if ([pay.result_code isEqualToString:@"0000"]) {
                    //购买前充值成功-购买接口调用
                    NSString *money = weakSelf.totalMoney;
                    NSLog(@"产品购买最终支付金钱：总的totalmoney：：：%@",money);
                    [weakSelf configurePasswordWithMoney:money];
                    
                } else if ([pay.result_code isEqualToString:@"3083"] || [pay.result_code isEqualToString:@"3081"]) {
                    NSLog(@"确认支付返回错误error::::%@",pay.result_msg);
                    //接受成功，
                    RechangeProcessingViewController *processController = [[RechangeProcessingViewController alloc] init];
                    [weakSelf.navigationController pushViewController:processController
                                                             animated:YES];
                } else {
                    BuyFailViewController *failController = [[BuyFailViewController alloc] init];
                    failController.errorMessage = pay.result_msg;
                    [weakSelf.navigationController pushViewController:failController
                                                             animated:YES];
                }
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"errror::::::%@",request.error);
        [weakSelf dimissSVProgressHUD];
    }];
    
}

- (void)configurePasswordWithMoney:(NSString *)money {
    
    //[self showSVProgressHUD];
    QRRequestProductBuy *buyProduct = [[QRRequestProductBuy alloc] init];
    buyProduct.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
    buyProduct.productId = self.productId;
    buyProduct.amount = [NSString stringWithFormat:@"%.f",f([money floatValue])];
    buyProduct.ticketId = [NSString getString:self.ticketId];
    NSLog(@"最终购买金额为：：：：%@",money);
    __weak typeof(self) weakSelf = self;
    [buyProduct startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        ProductBuy *recharge = [ProductBuy mj_objectWithKeyValues:request.responseJSONObject];
        [weakSelf saveToken:recharge.token];
        NSLog(@"后台购买结果::::::%@",request.responseJSONObject);
        NSLog(@"后台购买结果error-desc::::::%@",recharge.desc);
        if (recharge.statusType == IndentityStatusSuccess) {
            NSLog(@"购买成功跳转中");
            [weakSelf showSuccessWithTitle:@"购买跳转中"];
            //调转到购买成功页面
            PackBuySuccessViewController *successController = [[PackBuySuccessViewController alloc] init];
            [weakSelf.navigationController pushViewController:successController
                                                     animated:YES];
        } else {
            BuyFailViewController *failController = [[BuyFailViewController alloc] init];
            failController.errorMessage = recharge.desc;
            [weakSelf.navigationController pushViewController:failController
                                                     animated:YES];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        BuyFailViewController *failController = [[BuyFailViewController alloc] init];
        failController.errorMessage = @"请求失败";
        [weakSelf.navigationController pushViewController:failController
                                                 animated:YES];
        NSLog(@"errror::::::%@",request.error);
    }];
    
}


- (void)setupPasswordView {
    [self.passwordView beginInput];
    self.passwordView.isVerifyCode = YES;
    __weak typeof(self) weakSelf = self;
    self.passwordView.PasswordCompeleteBlock = ^(NSString *password) {
        NSLog(@"验证码::::::%@",password);
        [weakSelf payConfigWithVerifyCode:password];
    };

}

- (IBAction)sendVerify:(SendVerifyCodeButton *)sender {
    NSString *phone = self.phone.length > 0 ? self.phone : @"123456";
    if ([sender canSenderVerifyCodeWithPhone:phone]) {
        return;
    }
    User *user = [UserUtil currentUser];
    QRRequestRongBaoResendSMS *sendSMS = [[QRRequestRongBaoResendSMS alloc] init];
    sendSMS.userId = user.userId;
    sendSMS.appType = 0;
    sendSMS.payType = 0;
    sendSMS.orderNo = self.orderNo;
    //测试调用
    sendSMS.userName = user.realName;//@"韩梅梅";
    __weak typeof(self) weakSelf = self;
    [sendSMS startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"融宝发送验证码结果::::::%@",request.responseJSONObject);
        [weakSelf dimissSVProgressHUD];
        //请求成功，返回银行卡信息
        QuRongVerifyCode *sendSms = [QuRongVerifyCode mj_objectWithKeyValues:request.responseJSONObject];
        if (sendSms.statusType == IndentityStatusSuccess) {
            
            if ([sendSms.result_code isEqualToString:@"0000"]) {
                //购买成功跳转
                [weakSelf showSuccessWithTitle:@"发送验证码成功"];
                [sender sendVerifyCodeWithPhone:phone
                                     isBankCode:YES];
            } else {
                NSLog(@"融宝验证码错误error::::%@",sendSms.result_msg);
                [weakSelf showErrorWithTitle:sendSms.result_msg];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"errror::::::%@",request.error);
        [weakSelf dimissSVProgressHUD];
    }];
    
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
