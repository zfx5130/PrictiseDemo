//
//  UsernameSettingViewController.m
//  qulicai
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "UsernameSettingViewController.h"
#import "UIViewController+Addition.h"
#import "QRRequestSettingUserName.h"
#import "SettingUserName.h"
#import "UserUtil.h"
#import "User.h"

@interface UsernameSettingViewController ()
<UITextViewDelegate,
UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickNameTopConstraint;

@end

@implementation UsernameSettingViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    [self.usernameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    [self.view addTapGestureForDismissingKeyboard];
    if (IS_IPHONE_5) {
        self.nickNameTopConstraint.constant = 70.0f;
    }
    self.navigationItem.title = @"修改昵称";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)updateResetButtonStatus {
    self.saveButton.enabled =
    self.usernameTextField.text.length;
}

- (void)save {
    [self.view endEditing:YES];
    [self showSVProgressHUD];
    QRRequestSettingUserName *request = [[QRRequestSettingUserName alloc] init];
    request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
    request.nickName = self.usernameTextField.text;
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        SettingUserName *userName = [SettingUserName mj_objectWithKeyValues:request.responseJSONObject];
        if (userName.statusType == IndentityStatusSuccess) {
            [weakSelf showSuccessWithTitle:@"昵称设置成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else if (userName.statusType == IndentityStatusTypeInvalid) {
            [weakSelf outLogininWithController:weakSelf];
        } else {
            [weakSelf showTipErrorWithTitle:userName.desc];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        [weakSelf showErrorWithTitle:@"昵称设置失败"];
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
    BOOL isFlag = self.usernameTextField.text.length;
    if (isFlag) {
        [self save];
    }
    return YES;
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)editingChanged:(UITextField *)sender {
    [self updateResetButtonStatus];
}


- (IBAction)editingEnded:(UITextField *)sender {
    [self updateResetButtonStatus];
}


- (IBAction)editingBegin:(UITextField *)sender {
    [self updateResetButtonStatus];
}


- (IBAction)save:(UIButton *)sender {
    [self save];
}


@end
