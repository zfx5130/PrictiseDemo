//
//  AccountCertificationViewController.m
//  qulicai
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "AccountCertificationViewController.h"
#import "AddBankCardViewController.h"
#import "QRRequestHeader.h"
#import "UserUtil.h"
#import "User.h"
#import "Authorware.h"
#import "LoginViewController.h"
#import "ConfigPayViewController.h"

@interface AccountCertificationViewController ()
<UITextViewDelegate,
UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;

@property (weak, nonatomic) IBOutlet UITextField *userIdentifyLabel;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AccountCertificationViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self.nameLabel becomeFirstResponder];
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
    self.navigationItem.title = @"实名认证";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];

}

- (void)updateResetButtonStatus {
    self.saveButton.enabled =
    self.nameLabel.text.length && self.userIdentifyLabel.text.length;
}

- (void)save {
    if ([UserUtil isLoginIn]) {
        [self.view endEditing:YES];
        BOOL isFlag = self.nameLabel.text.length && self.userIdentifyLabel.text.length;
        if (!isFlag) {
            return;
        }
        [self showSVProgressHUD];
        QRRequestNameAuthorware *request = [[QRRequestNameAuthorware alloc] init];
        request.userId = [UserUtil currentUser].userId;
        request.userName = self.nameLabel.text;
        request.idCard = self.userIdentifyLabel.text;
        
        __weak typeof(self) weakSelf = self;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf dimissSVProgressHUD];
            Authorware *authorware = [Authorware mj_objectWithKeyValues:request.responseJSONObject];
            NSLog(@"实名认证结果:::::%@",request.responseJSONObject);
            //操作成功
            [weakSelf saveToken:authorware.token];
            if (authorware.statusType == IndentityStatusSuccess) {
                
                [weakSelf showSuccessWithTitle:@"实名认证成功跳转中"];
                if (authorware.authentication) {
                    QRRequestGetUserInfo *request = [[QRRequestGetUserInfo alloc] init];
                    request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
                    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                        User *userInfo = [User mj_objectWithKeyValues:request.responseJSONObject];
                        SLog(@"实名认证成功获取user信息::::::::::%@",request.responseJSONObject);
                        [weakSelf saveToken:userInfo.token];
                        if (userInfo.statusType == IndentityStatusSuccess) {
                            [UserUtil saving:userInfo];
                            if ([UserUtil currentUser].availableMoney > 0) {
                                for(UIViewController *controller in weakSelf.navigationController.viewControllers ) {
                                    if( [controller isKindOfClass:[ConfigPayViewController class]] ) {
                                        [self.navigationController popToViewController:controller animated:YES];
                                        return ;
                                    }
                                }
                            } else {
                                if (weakSelf.isProductPush || weakSelf.isFirstRechargePush) {
                                    AddBankCardViewController *addBankController = [[AddBankCardViewController alloc] init];
                                    addBankController.money = weakSelf.money;
                                    addBankController.periodMoney = weakSelf.periodMoney;
                                    addBankController.productId = weakSelf.productId;
                                    //NSLog(@"实名认证:::%@:::::",weakSelf.totalMoney);
                                    addBankController.isRecharge = weakSelf.isRecharge;
                                    addBankController.totalMoney = weakSelf.totalMoney;
                                    addBankController.ticketId = weakSelf.ticketId;
                                    [weakSelf.navigationController pushViewController:addBankController
                                                                             animated:YES];
                                } else {
                                    [weakSelf.navigationController popViewControllerAnimated:YES];
                                }
                            }
                        } else if (userInfo.statusType == IndentityStatusTypeInvalid) {
                            [weakSelf outLogininWithController:weakSelf];
                        } else {
                            NSLog(@"error:::::%@",request.error);
                        }
                    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                        NSLog(@"error:- %@", request.error);
                    }];
                    
                } else {
                    [weakSelf showTipErrorWithTitle:@"实名认证失败"];
                }
            } else if (authorware.statusType == IndentityStatusTypeInvalid) {
                if ([UserUtil outLoginIn]) {
                    [weakSelf showErrorWithTitle:@"登录失效"];
                    PostNotification(QR_OUTLOGIN_UPDATE_HEAD_VIEW_STAUTS);
                }
            } else {
                [weakSelf showTipErrorWithTitle:authorware.desc];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf dimissSVProgressHUD];
            NSLog(@"error-::::%@",request.error);
        }];
    } else {
        [self login];
    }
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
    [self save];
    return YES;
}

#pragma mark - Handlers

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
    [self.navigationController popViewControllerAnimated:YES];
}

@end
