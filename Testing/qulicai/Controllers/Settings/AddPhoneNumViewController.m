//
//  AddPhoneNumViewController.m
//  qulicai
//
//  Created by admin on 2017/9/19.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "AddPhoneNumViewController.h"
#import "SenderVerifyCodeViewController.h"
#import "BuyFailViewController.h"
#import "ZHWebViewController.h"
#import "QRRequestHeader.h"
#import "UserUtil.h"
#import "FirstRongBaoSign.h"
#import "ZhaoShangSign.h"
#import "SignQuery.h"
#import "User.h"

@interface AddPhoneNumViewController ()
<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bankCardNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (assign, nonatomic) BOOL isReload;

@property (copy, nonatomic) NSString *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *zsConfigLabel;

@end

@implementation AddPhoneNumViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    [self.phoneTextField becomeFirstResponder];
    if (self.isReload) {
        //调用卡密验证接口
        NSLog(@"------调用卡密验证接口-----");
        self.zsConfigLabel.hidden = YES;
        [self loadSignQuery];
    }
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

- (void)loadSignQuery {
    
    User *user = [UserUtil currentUser];
    QRRequestSignQuery *query = [[QRRequestSignQuery alloc] init];
    query.userId = user.userId;
    query.appType = 0;
    query.payType = 0;
    query.orderNo = self.orderNo;
    __weak typeof(self) weakSelf = self;
    [self showSVProgressHUDWithStatus:@"认证请求中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [query startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            SignQuery *zsSign = [SignQuery mj_objectWithKeyValues:request.responseJSONObject];
            NSLog(@"招商卡密信息：::::%@",request.responseJSONObject);
            [weakSelf dimissSVProgressHUD];
            if (zsSign.statusType == IndentityStatusSuccess) {
                if ([zsSign.result_code isEqualToString:@"0000"]) {
                    //请求成功趣下一个页面
                    [weakSelf showSuccessWithTitle:@"认证成功跳转中"];
                    SenderVerifyCodeViewController *payController = [[SenderVerifyCodeViewController alloc] init];
                    payController.periodMoney = weakSelf.periodMoney;
                    payController.orderNo = weakSelf.orderNo;
                    payController.productId = weakSelf.productId;
                    payController.money = weakSelf.money;
                    payController.ticketId = weakSelf.ticketId;
                    payController.totalMoney = weakSelf.totalMoney;
                    payController.isRecharge = weakSelf.isRecharge;
                    NSLog(@"::::添加：：：:%@:",weakSelf.totalMoney);
                    payController.phone = weakSelf.phoneTextField.text;
                    [weakSelf.navigationController pushViewController:payController
                                                             animated:YES];
                } else {
                    BuyFailViewController *failController = [[BuyFailViewController alloc] init];
                    failController.errorMessage = zsSign.result_msg;
                    [weakSelf.navigationController pushViewController:failController
                                                             animated:YES];
                }
            } else {
                //失败;
                BuyFailViewController *failController = [[BuyFailViewController alloc] init];
                failController.errorMessage = zsSign.desc;
                [weakSelf.navigationController pushViewController:failController
                                                         animated:YES];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@":::%@",request.error);
            [weakSelf dimissSVProgressHUD];
            //[weakSelf showErrorWithTitle:@"请求失败"];
            BuyFailViewController *failController = [[BuyFailViewController alloc] init];
            failController.errorMessage = @"请求失败";
            [weakSelf.navigationController pushViewController:failController
                                                     animated:YES];
        }];
    });
    
}

- (void)setupViews {
    [self.view addTapGestureForDismissingKeyboard];
    self.bankCardNameTextField.text = [NSString stringWithFormat:@"%@ 储蓄卡",self.cardPay.bank_name];
    self.navigationItem.title = @"预留手机号码";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];

}

- (void)updateResetButtonStatus {
    self.nextButton.enabled = self.phoneTextField.text.length;
}

- (void)save {
    [self.view endEditing:YES];
    if (self.phoneTextField.text.length != 11) {
        [self showTipErrorWithTitle:@"手机号格式有误"];
        return;
    }
    
    //调用储蓄卡签约接口
    User *user = [UserUtil currentUser];
    [self showSVProgressHUDWithStatus:@"处理等待中"];
    
    NSString *userName = [NSString getStringWithString:[UserUtil currentUser].realName];
    QRRequestFirstPaySign *query = [[QRRequestFirstPaySign alloc] init];
    query.userId = user.userId;
    query.appType = 0;
    query.payType = 0;
    //测试调用
    query.cardNo = self.bankCardNo;
    query.owner = userName;
    query.phone = self.phoneTextField.text;
    query.totalFee = self.periodMoney.length > 0 ? self.periodMoney : self.money;
    query.certNo = [NSString getStringWithString:user.cardId];
    query.userName = userName;
    
    __weak typeof(self) weakSelf = self;
    [query startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"储蓄卡签约接口-第一次签约::::::%@",request.responseJSONObject);
        [weakSelf dimissSVProgressHUD];
        //请求成功，返回银行卡信息
        FirstRongBaoSign *sign = [FirstRongBaoSign mj_objectWithKeyValues:request.responseJSONObject];
        //请求成功code = 0
        if (sign.statusType == IndentityStatusSuccess) {
            //发送到服务器
            if ([sign.result_code isEqualToString:@"0000"]) {
                
                //2种跳转情况1.招商2.不是招商
                if ([sign.certificate isEqualToString:@"0"]) {
                  //招商鉴全
                    QRReuqestZhaoShangCard *zhaoshangSign = [[QRReuqestZhaoShangCard alloc] init];
                    zhaoshangSign.userId = user.userId;
                    zhaoshangSign.userName = userName;
                    zhaoshangSign.appType = 0;
                    zhaoshangSign.payType = 0;
                    zhaoshangSign.bindId = sign.bind_id;
                    zhaoshangSign.orderNo = sign.order_no;
                    weakSelf.orderNo = sign.order_no;
                    zhaoshangSign.return_url = @"iOSqulicai://com.qurong.qulicai.www";
                    [zhaoshangSign startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        ZhaoShangSign *zsSign = [ZhaoShangSign mj_objectWithKeyValues:request.responseJSONObject];
                        NSLog(@"招商信息：::::%@",request.responseJSONObject);
                        if (zsSign.statusType == IndentityStatusSuccess) {
                            
                            NSLog(@":htmlText:::::::%@",zsSign.htmltext);
                            ZHWebViewController *webController = [[ZHWebViewController alloc] init];
                            webController.htmlText = zsSign.htmltext;
                            webController.statusBlock = ^(BOOL isReload) {
                                weakSelf.isReload = isReload;
                            };
                            UINavigationController  *wbnavigation =
                            [[UINavigationController alloc] initWithRootViewController:webController];
                            [weakSelf presentViewController:wbnavigation
                                                   animated:YES
                                                 completion:nil];
                            
                        } else {
                            NSLog(@":::%@",zsSign.desc);
                            [weakSelf showErrorWithTitle:zsSign.desc];
                        }
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        NSLog(@":::%@",request.error);
                        [weakSelf showErrorWithTitle:@"请求失败"];
                    }];
                    
                } else {
                    //不是招商，跳转验证码界面
                    SenderVerifyCodeViewController *payController = [[SenderVerifyCodeViewController alloc] init];
                    payController.periodMoney = weakSelf.periodMoney;
                    payController.orderNo = sign.order_no;
                    payController.productId = weakSelf.productId;
                    payController.money = weakSelf.money;
                    payController.totalMoney = weakSelf.totalMoney;
                    payController.phone = weakSelf.phoneTextField.text;
                    payController.isRecharge = weakSelf.isRecharge;
                    payController.ticketId = weakSelf.ticketId;
                    [weakSelf.navigationController pushViewController:payController
                                                             animated:YES];
                }
                
            } else {
                [weakSelf showTipErrorWithTitle:sign.result_msg];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"errror::::::%@",request.error);
        [weakSelf dimissSVProgressHUD];
    }];
    
}

#pragma mark - Handlers

- (IBAction)editingChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
    if ([self.cardPay.bank_name isEqualToString:@"招商银行"]) {
        self.zsConfigLabel.hidden = !(sender.text.length >= 11);
        [self.zsConfigLabel addShakeAnimation];
    }
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

@end
