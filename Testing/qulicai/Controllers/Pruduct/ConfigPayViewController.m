//
//  ConfigPayViewController.m
//  qulicai
//
//  Created by admin on 2017/9/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ConfigPayViewController.h"
#import "ForgetPasswordViewController.h"
#import "PackBuySuccessViewController.h"
#import "ResetPasswordViewController.h"
#import "AddBankCardViewController.h"
#import "AccountCertificationViewController.h"
#import "SenderVerifyCodeViewController.h"
#import "ProductPasswordView.h"
#import "ASPopupController.h"
#import "QRRequestHeader.h"
#import "User.h"
#import "TransactionPwd.h"
#import "UserUtil.h"
#import "ProductBuy.h"
#import "FirstRongBaoSign.h"
#import "Bank.h"
#import "Ticket.h"


@interface ConfigPayViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;

@property (weak, nonatomic) IBOutlet UILabel *buyInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountRemindLabel;

@property (weak, nonatomic) IBOutlet UILabel *incomeTwoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bankImageLabel;

@property (weak, nonatomic) IBOutlet UILabel *banNameLabel;

@property (weak, nonatomic) IBOutlet UIView *bankBottonView;


@property (assign, nonatomic) BOOL hasBankCard;

@property (copy, nonatomic) NSArray *bankArray;

@property (strong, nonatomic) ProductPasswordView *passwordView;

@property (strong, nonatomic) ASPopupController *popController;

@property (copy, nonatomic) NSString *password;

@property (weak, nonatomic) IBOutlet UILabel *bankContentLabel;

@property (weak, nonatomic) IBOutlet UIView *youhuiHolderView;
//360 320
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *holderViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *fuliDescLabel;

@end

@implementation ConfigPayViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderData];
    [self setupView];
    //[self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupView {
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setupViews {
    //[self wr_setNavBarBackgroundAlpha:0.0f];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"back_image"]];
}

- (void)renderData {
    
    NSLog(@"ticket:::::----:%@",self.ticket);
    self.holderViewHeightConstraint.constant = !self.ticket ? 320.0f : 360.0f;
    self.youhuiHolderView.hidden = !self.ticket ? YES : NO;
    
    if (self.ticket) {
        switch (self.ticket.name) {
            case 0: {
                self.fuliDescLabel.text = [NSString stringWithFormat:@"+%@理财金",self.ticket.welfare];
                self.fuliDescLabel.textColor = RGBColor(242.0f, 89.0f, 47.0f);
                NSDictionary *dic = @{
                                      NSForegroundColorAttributeName : RGBColor(153.0f, 153.0f, 153.0f),
                                      };
                [self.fuliDescLabel addAttributes:dic
                                          forText:@"理财金"];
            }
                break;
            case 1: {
                self.fuliDescLabel.text = [NSString stringWithFormat:@"+%@%%加息卷",self.ticket.welfare];
                self.fuliDescLabel.textColor = RGBColor(242.0f, 89.0f, 47.0f);
                NSDictionary *dic = @{
                                      NSForegroundColorAttributeName : RGBColor(153.0f, 153.0f, 153.0f),
                                      };
                [self.fuliDescLabel addAttributes:dic
                                          forText:@"加息卷"];
            }
                break;
            case 2: {
                self.fuliDescLabel.text = [NSString stringWithFormat:@"-%@元红包",self.ticket.welfare];
                self.fuliDescLabel.textColor = RGBColor(242.0f, 89.0f, 47.0f);
                NSDictionary *dic = @{
                                      NSForegroundColorAttributeName : RGBColor(153.0f, 153.0f, 153.0f),
                                      };
                [self.fuliDescLabel addAttributes:dic
                                          forText:@"元红包"];
            }
                break;
            default:
                break;
        }
    }
    
    self.productNameLabel.text = [NSString stringWithFormat:@"趣钱宝%@天",[NSString getStringWithString:self.period]];
    CGFloat rate = self.product.yearRate * 100;
    CGFloat actRate = self.product.activeRate * 100;
    NSString *rateStr = [NSString stringWithFormat:@"%.1f%%",rate + actRate];
    self.incomeLabel.text = [NSString stringWithFormat:@"预期年化收益%@ %@天期限",rateStr, self.period];
    
    self.buyInfoLabel.text = [NSString stringWithFormat:@"本次认购%@元，",[NSString countNumAndChangeformat:self.money]];
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : RGBColor(242.0f, 89.0f, 47.0f)
                          };
    [self.buyInfoLabel addAttributes:dic
                             forText:[NSString countNumAndChangeformat:self.money]];
    
    
    NSInteger period = [self.period integerValue];
    NSInteger periodDay = period;
    CGFloat activityRate= self.product.activeRate;
    CGFloat interestRate = self.product.yearRate;
    CGFloat rateValue = activityRate + interestRate;
    CGFloat value = [self.money floatValue];
    CGFloat result = value * rateValue / 360 * periodDay;
    
    NSString *valueStr = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(result)]];
    self.incomeTwoLabel.text = [NSString stringWithFormat:@"预计收益%@元",valueStr];
    
    NSDictionary *dic1 = @{
                          NSForegroundColorAttributeName : RGBColor(242.0f, 89.0f, 47.0f)
                          };
    [self.incomeTwoLabel addAttributes:dic1
                               forText:valueStr];
    
    User *user = [UserUtil currentUser];
    CGFloat payMoney = [self.money floatValue] - user.availableMoney;
    if (payMoney < 0) {
        payMoney = 0;
    }
    NSString *balanceStr = [NSString stringWithFormat:@"%.2f", f(payMoney)];
    self.moneyLabel.text = [NSString stringWithFormat:@"需支付￥%@",balanceStr];
    NSDictionary *dic2 = @{
                           NSForegroundColorAttributeName : RGBColor(153.0f, 153.0f, 153.0f),
                           NSFontAttributeName : [UIFont systemFontOfSize:12.0f]
                           };
    [self.moneyLabel addAttributes:dic2
                               forText:@"需支付"];
    
    CGFloat accountValue = 0.0f;
    if ([self.money floatValue] >= user.availableMoney) {
        accountValue = user.availableMoney;
    } else {
        accountValue = [self.money floatValue];
    }
    NSString *accountStr = [NSString stringWithFormat:@"%.2f",f(accountValue)];
    self.accountRemindLabel.text =
    [NSString stringWithFormat:@"账户余额已抵扣%@元",[NSString countNumAndChangeformat:accountStr]];
    
    self.hasBankCard = user.appBanks.count > 0;
    if (self.hasBankCard) {
        Bank *bank = [user.appBanks firstObject];
        NSString *num = @"";
        if (bank.bankNo.length > 6) {
            num = [[NSString getStringWithString:bank.bankNo] substringWithRange:NSMakeRange(bank.bankNo.length - 5, 5)];
        }
        self.banNameLabel.text =
        [NSString getStringWithString:[NSString stringWithFormat:@"%@(尾号%@)", [NSString getStringWithString:bank.bankName], num]];
        [self.banNameLabel addColor:RGBColor(51.0f, 51.0f, 51.0f)
                            forText:[NSString getStringWithString:bank.bankName]];
        
        for (int i = 0; i < [self.bankArray count]; i++) {
            NSDictionary *dic = self.bankArray[i];
            NSString *bankName = dic[@"bankName"];
            NSString *bankContent = dic[@"bankContent"];
            if ([bank.bankName isEqualToString:bankName]) {
                NSString *bankImageName = dic[@"bankImageName"];
                self.bankImageLabel.image = [UIImage imageNamed:bankImageName];
                self.bankContentLabel.text = [NSString getStringWithString:bankContent];
            }
        }
    }
    self.bankBottonView.hidden = !self.hasBankCard;
    
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

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backDismiss:(UIButton *)sender {
    [self leftBarButtonAction];
}


- (IBAction)config:(UIButton *)sender {
    [[A0SimpleKeychain keychain] setString:self.period
                                    forKey:QR_PRODUCT_PERIOD];
    if (![UserUtil isLoginIn]) {
        [self login];
    }
    
    //1.是否是第一次支付
    User *user = [UserUtil currentUser];
    //测试调用
    BOOL isSecondRecharge = user.appBanks.count > 0;
    if (!isSecondRecharge) {
        //绑定信息相关操作.直接调用
        //防止没有绑定信息，但是有余额问题处理方式
        if (!user.payPwd) {
            //未设置交易密码
            ResetPasswordViewController *modifyController = [[ResetPasswordViewController alloc] init];
            modifyController.isFirstSetingTradPw = YES;
            modifyController.isTradingPw = YES;
            modifyController.periodMoney = self.money;
            modifyController.totalMoney = self.money;
            modifyController.productId = self.productId;
            modifyController.ticketId = self.ticket ? self.ticket.ticketId : @"";
            [self.navigationController pushViewController:modifyController
                                                 animated:YES];
        } else {
            //设置过交易密码
            if (user.authStatusType == AuthenticationStatusSuccess) {
                
                //已经实名认证，判断余额大于可购买金额。
                if (user.availableMoney >= [self.money floatValue]) {
                    //直接余额抵扣
                    //余额抵扣money
                    CGFloat currentPayMoney = [self.money floatValue];
                    NSLog(@"余额充足，直接购买金额::::%@",@(currentPayMoney));
                    [self inputPickPWWithMoney:currentPayMoney];
                    
                    //余额小于可购买金额，
                }  else if (user.availableMoney < [self.money floatValue]) {
                    //余额抵扣一部分，剩余银行卡购买
                    //先绑定银行卡，然后去支付
                    CGFloat rechargeMoney = [self.money floatValue] - user.availableMoney;
                    NSLog(@"有余额，小于购买金额，充值金额为::::%@",@(rechargeMoney));
                    NSLog(@"有余额，小于购买金额，购买总金额为::::%@",self.money);
                    AddBankCardViewController *addBankController = [[AddBankCardViewController alloc] init];
                    addBankController.periodMoney = [NSString stringWithFormat:@"%.2f",f(rechargeMoney)];
                    addBankController.productId = self.productId;
                    addBankController.totalMoney = self.money;
                    addBankController.ticketId = self.ticket ? self.ticket.ticketId : @"";
                    [self.navigationController pushViewController:addBankController
                                                         animated:YES];
                    
                } else {
                    //已实名认证,没有余额
                    AddBankCardViewController *addBankController = [[AddBankCardViewController alloc] init];
                    addBankController.periodMoney = self.money;
                    addBankController.totalMoney = self.money;
                    addBankController.productId = self.productId;
                    addBankController.ticketId = self.ticket ? self.ticket.ticketId : @"";
                    [self.navigationController pushViewController:addBankController
                                                         animated:YES];
                }
            } else {
                //未实名认证
                AccountCertificationViewController *accountController = [[AccountCertificationViewController alloc] init];
                accountController.isFirstRechargePush = YES;
                accountController.periodMoney = self.money;
                accountController.totalMoney = self.money;
                accountController.productId = self.productId;
                accountController.ticketId = self.ticket ? self.ticket.ticketId : @"";
                [self.navigationController pushViewController:accountController
                                                     animated:YES];
            }
        }
    }
    
    
    
    if (isSecondRecharge) {
        //处理有银行卡状态，三种情况
        //1.余额充足
        if (user.availableMoney >= [self.money floatValue]) {
            //直接余额抵扣
            //余额抵扣money
            CGFloat currentPayMoney = [self.money floatValue];
            NSLog(@"余额充足，直接购买金额::::%@",@(currentPayMoney));
            [self inputPickPWWithMoney:currentPayMoney];
            
        } else if (user.availableMoney <= 0 ) {
            //直接银行卡购买
            NSLog(@"无余额，直接银行卡购买::::%@",self.money);
            [self withnoAblancePayWithMoney:self.money];
            
        } else if (user.availableMoney < [self.money floatValue]) {
            //余额抵扣一部分，剩余银行卡购买
            //先充值，充值金额为
            CGFloat rechargeMoney = [self.money floatValue] - user.availableMoney;
            NSLog(@"有余额，小于购买金额，充值金额为::::%@",@(rechargeMoney));
            NSLog(@"有余额，小于购买金额，购买总金额为::::%@",self.money);
            [self withAblancePayWithRechargeMoney:rechargeMoney
                                       totapMoney:self.money];
        }
    }
    
}

- (void)withAblancePayWithRechargeMoney:(CGFloat)rechargeMoney
                             totapMoney:(NSString *)totalMoney {
    
    User *user = [UserUtil currentUser];
    Bank *bank = [user.appBanks firstObject];
    [self showSVProgressHUDWithStatus:@"交易处理中"];
    QRRequestQrongBaoSecondSign *query = [[QRRequestQrongBaoSecondSign alloc] init];
    query.userId = [NSString getStringWithString:user.userId];
    query.userName = [NSString getStringWithString:[UserUtil currentUser].realName];
    query.appType = 0;
    query.payType = 0;
    query.bindId = [NSString getStringWithString:bank.bindId];
    NSLog(@"先充值的钱数：：：：%@",@(rechargeMoney));
    query.totalFee = [NSString stringWithFormat:@"%.2f",f(rechargeMoney)];
    
    __weak typeof(self) weakSelf = self;
    [query startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"储蓄卡签约接口-第二次签约::::::%@",request.responseJSONObject);
        [weakSelf dimissSVProgressHUD];
        //请求成功，返回银行卡信息
        FirstRongBaoSign *sign = [FirstRongBaoSign mj_objectWithKeyValues:request.responseJSONObject];
        //请求成功code = 0
        if (sign.statusType == IndentityStatusSuccess) {
            //发送到服务器
            if ([sign.result_code isEqualToString:@"0000"]) {
                //不是招商，跳转验证码界面
                SenderVerifyCodeViewController *payController = [[SenderVerifyCodeViewController alloc] init];
                payController.periodMoney = [NSString stringWithFormat:@"%.2f",f(rechargeMoney)];
                payController.totalMoney = totalMoney;
                payController.orderNo = sign.order_no;
                payController.productId = weakSelf.productId;
                payController.ticketId = weakSelf.ticket ? weakSelf.ticket.ticketId : @"";
                [weakSelf.navigationController pushViewController:payController
                                                         animated:YES];
            } else {
                NSLog(@"第二次支付error::::%@",sign.result_msg);
                [weakSelf showErrorWithTitle:sign.result_msg];
            }
        } else {
            NSLog(@"第二次支付error::::%@",sign.desc);
            [weakSelf showErrorWithTitle:sign.desc];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"errror::::::%@",request.error);
        [weakSelf dimissSVProgressHUD];
        [weakSelf showErrorWithTitle:nil];
    }];
    
}

- (void)withnoAblancePayWithMoney:(NSString *)money {
    
    User *user = [UserUtil currentUser];
    Bank *bank = [user.appBanks firstObject];
    
    [self showSVProgressHUDWithStatus:@"交易处理中"];
    QRRequestQrongBaoSecondSign *query = [[QRRequestQrongBaoSecondSign alloc] init];
    query.userId = [NSString getStringWithString:user.userId];
    query.userName = [NSString getStringWithString:[UserUtil currentUser].realName];
    query.appType = 0;
    query.payType = 0;
    query.bindId = [NSString getStringWithString:bank.bindId];
    query.totalFee = money;
    
    __weak typeof(self) weakSelf = self;
    [query startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"储蓄卡签约接口-第二次签约::::::%@",request.responseJSONObject);
        [weakSelf dimissSVProgressHUD];
        //请求成功，返回银行卡信息
        FirstRongBaoSign *sign = [FirstRongBaoSign mj_objectWithKeyValues:request.responseJSONObject];
        //请求成功code = 0
        if (sign.statusType == IndentityStatusSuccess) {
            //发送到服务器
            if ([sign.result_code isEqualToString:@"0000"]) {
                //不是招商，跳转验证码界面
                SenderVerifyCodeViewController *payController = [[SenderVerifyCodeViewController alloc] init];
                payController.periodMoney = money;
                payController.totalMoney = money;
                payController.orderNo = sign.order_no;
                payController.productId = weakSelf.productId;
                payController.ticketId = weakSelf.ticket ? weakSelf.ticket.ticketId : @"";
                [weakSelf.navigationController pushViewController:payController
                                                         animated:YES];
            } else {
                //NSLog(@"第二次支付error::::%@",sign.result_msg);
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

- (void)inputPickPWWithMoney:(CGFloat)money {
    
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
        [weakSelf configurePasswordWithMoney:money];
    };
    [self presentViewController:self.popController
                       animated:YES
                     completion:nil];
}

- (void)forgetButtonWasPressed {
    ForgetPasswordViewController *passwordController = [[ForgetPasswordViewController alloc] init];
    passwordController.isTradingPw = YES;
    passwordController.isBuyRechargePw = YES;
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

- (void)configurePasswordWithMoney:(CGFloat)money {
    
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
        [weakSelf saveToken:pickup.token];
        NSLog(@"验证交易密码接口::::%@",request.responseJSONObject);
        BOOL isVerify = [request.responseJSONObject[@"data"][@"verify"] boolValue];
        [weakSelf saveToken:pickup.token];
        if (pickup.statusType == IndentityStatusSuccess) {
            if (isVerify) {
                NSLog(@"购买中交易密码验证成功");
                [weakSelf showSuccessWithTitle:@"验证成功购买中"];
                //购买接口
                QRRequestProductBuy *buyProduct = [[QRRequestProductBuy alloc] init];
                buyProduct.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
                buyProduct.productId = weakSelf.productId;
                buyProduct.ticketId = weakSelf.ticket ? weakSelf.ticket.ticketId : @"";
                buyProduct.amount = [NSString stringWithFormat:@"%.2f",f(money)];
                NSLog(@"购买金额为：：：：%.2f",money);
                __weak typeof(self) weakSelf = self;
                [buyProduct startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [weakSelf dimissSVProgressHUD];
                    ProductBuy *recharge = [ProductBuy mj_objectWithKeyValues:request.responseJSONObject];
                    [weakSelf saveToken:recharge.token];
                    NSLog(@"后台购买结果::::::%@",request.responseJSONObject);
                    if (recharge.statusType == IndentityStatusSuccess) {
                        NSLog(@"购买成功跳转中");
                        [weakSelf showSuccessWithTitle:@"购买跳转中"];
                        //调转到购买成功页面
                        PackBuySuccessViewController *successController = [[PackBuySuccessViewController alloc] init];
                        [weakSelf.navigationController pushViewController:successController
                                                                 animated:YES];
                        
                    } else {
                        [weakSelf showErrorWithTitle:recharge.desc];
                    }
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [weakSelf dimissSVProgressHUD];
                    [weakSelf showErrorWithTitle:@"充值失败"];
                    NSLog(@"errror::::::%@",request.error);
                }];
                
            } else {
                [weakSelf dimissSVProgressHUD];
                [weakSelf showErrorWithTitle:@"交易验证失败"];
            }
        } else if (pickup.statusType == IndentityStatusTypeInvalid) {
            [weakSelf outLogininWithController:weakSelf];
        } else {
            [weakSelf showErrorWithTitle:@"交易验证失败"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        [weakSelf showErrorWithTitle:@"交易验证失败"];
    }];
}

@end
