//
//  ActionMainViewController.m
//  qulicai
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ActionMainViewController.h"
#import "SUTableView.h"
#import "SUTableViewCell.h"
#import "QRRequestHeader.h"
#import "ActionList.h"
#import "ActionView.h"
#import "Actions.h"
#import "ASPopupController.h"
#import "ActionLock.h"
#import "PruductDetailViewController.h"
#import "UserUtil.h"
#import "User.h"
#import "ActionInfo.h"
#import "ActionPriceView.h"

@interface ActionMainViewController ()
<UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (copy, nonatomic) NSArray *gundongArrays;

@property (weak, nonatomic) IBOutlet SUTableView *tableView;

@property (copy, nonatomic) NSArray *actions;

@property (strong, nonatomic) ASPopupController *popController;
@property (strong, nonatomic) ASPopupController *popController1;

@property (strong, nonatomic) ActionPriceView *priceView;

@property (strong, nonatomic) ActionView *actionView;

@property (copy, nonatomic) NSString *amont;

@property (strong, nonatomic) ActionInfo *actionInfo;


@property (weak, nonatomic) IBOutlet UIView *yuding1View;

@property (weak, nonatomic) IBOutlet UIView *yuding2View;

@property (weak, nonatomic) IBOutlet UIView *yuding3View;

@property (weak, nonatomic) IBOutlet UIButton *yuding1Button;

@property (weak, nonatomic) IBOutlet UIButton *yuding2Button;

@property (weak, nonatomic) IBOutlet UIButton *yuding3Button;

@property (weak, nonatomic) IBOutlet UIButton *lingyu1Button;

@property (weak, nonatomic) IBOutlet UIButton *lingqu2Button;

@property (weak, nonatomic) IBOutlet UIButton *lingqu3Button;

@property (weak, nonatomic) IBOutlet UILabel *remind1Label;

@property (weak, nonatomic) IBOutlet UILabel *remind2Label;

@property (weak, nonatomic) IBOutlet UILabel *remind3Label;

//90
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lingquRightConstraint;

@property (strong, nonatomic) UIButton *lingPriceButton;

@end

@implementation ActionMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[A0SimpleKeychain keychain] deleteEntryForKey:QR_PRICE_STAUTS];
    [self setupViews];
    [self registerCell];
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 1400.0f)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestActionLists];
    [self requestShowActionInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (NSArray *)actions {
    if (!_actions) {
        _actions = [[NSArray alloc] init];
    }
    return _actions;
}

- (void)requestShowActionInfo {
    if ([UserUtil isLoginIn]) {
        [self showSVProgressHUD];
        QRRequestActionInfo *request = [[QRRequestActionInfo alloc] init];
        request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
        __weak typeof(self) weakSelf = self;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf dimissSVProgressHUD];
            ActionInfo *actions = [ActionInfo mj_objectWithKeyValues:request.responseJSONObject];
            NSLog(@"活动详情::++++::::%@",request.responseJSONObject);
            if (actions.statusType == IndentityStatusSuccess) {
                weakSelf.actionInfo = actions;
                [weakSelf renderActionInfoUIWithData:request.responseJSONObject];
            } else {
                [weakSelf showErrorWithTitle:@"请求失败"];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf dimissSVProgressHUD];
            [weakSelf showErrorWithTitle:@"请求失败"];
        }];
    }
}

- (void)requestActionLists {
    //[self showSVProgressHUD];
    QRRequestGetActionList *request = [[QRRequestGetActionList alloc] init];
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        ActionList *actions = [ActionList mj_objectWithKeyValues:request.responseJSONObject];
        NSLog(@"产品详情::++++::::%@",request.responseJSONObject);
        if (actions.statusType == IndentityStatusSuccess) {
            weakSelf.actions = actions.actions;
            NSLog(@":::::%@",actions.desc);
            [weakSelf renderUI];
        } else {
            [weakSelf showErrorWithTitle:@"请求失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf showErrorWithTitle:@"请求失败"];
    }];
}

- (void)renderUI {
    [self.tableView reloadData];
}

- (void)renderActionInfoUIWithData:(id)responseJSONObject {
    
    NSLog(@":sdfsdfs::::%@",self.actionInfo);
    //NSDictionary *data =responseJSONObject[@"data"];
    
    if (!self.actionInfo.address.length && self.actionInfo.gmtCreated.length) {
        //没有预定人
        self.yuding1Button.hidden = NO;
        self.yuding2Button.hidden = NO;
        self.yuding3Button.hidden = NO;
        self.lingyu1Button.hidden = YES;
        self.lingqu2Button.hidden = YES;
        self.lingqu3Button.hidden = YES;
        self.yuding1View.hidden = YES;
        self.yuding2View.hidden = YES;
        self.yuding3View.hidden = YES;
        
    } else {
        
        if (self.actionInfo.amount  == 200000) {
            
            self.yuding1Button.hidden = YES;
            self.yuding2Button.hidden = NO;
            self.yuding3Button.hidden = NO;
            
            
            self.lingqu2Button.hidden = YES;
            self.lingqu3Button.hidden = YES;
            
            self.yuding2View.hidden = YES;
            self.yuding3View.hidden = YES;
            
            self.lingyu1Button.hidden = !self.actionInfo.status;
            self.yuding1View.hidden = !self.lingyu1Button.hidden;
            
            self.remind1Label.text = [NSString stringWithFormat:@"还差%.2f元",f(self.actionInfo.surplusAmount)];
            
        } else if (self.actionInfo.amount == 300000) {
            
            self.yuding2Button.hidden = YES;
            self.yuding1Button.hidden = NO;
            self.yuding3Button.hidden = NO;
            
            self.lingyu1Button.hidden = YES;
            self.lingqu3Button.hidden = YES;
            
            self.yuding1View.hidden = YES;
            self.yuding3View.hidden = YES;
            
            self.lingqu2Button.hidden = !self.actionInfo.status;
            self.yuding2View.hidden = !self.lingqu2Button.hidden;
            
            self.remind2Label.text = [NSString stringWithFormat:@"还差%.2f元",f(self.actionInfo.surplusAmount)];
            
            
        } else if (self.actionInfo.amount == 500000) {
            self.yuding3Button.hidden = YES;
            self.yuding1Button.hidden = NO;
            self.yuding2Button.hidden = NO;
            
            self.lingyu1Button.hidden = YES;
            self.lingqu2Button.hidden = YES;
            
            self.yuding1View.hidden = YES;
            self.yuding2View.hidden = YES;
            
            self.lingqu3Button.hidden = !self.actionInfo.status;
            self.yuding3View.hidden = !self.lingqu3Button.hidden;
            
            self.remind3Label.text = [NSString stringWithFormat:@"还差%.2f元",f(self.actionInfo.surplusAmount)];
        }
        
        NSString *value = [[A0SimpleKeychain keychain] stringForKey:QR_PRICE_STAUTS];
        if (value.length > 0) {
            NSString *firstNum = [value substringToIndex:1];
            if ([value containsText:[NSString getStringWithString:[UserUtil currentUser].userId]]) {
                if ([firstNum isEqualToString:@"8"]) {
                    [self.lingyu1Button setTitle:@"已领取"
                                        forState:UIControlStateNormal];
                    self.lingyu1Button.layer.borderColor = [UIColor clearColor].CGColor;
                } else if ([firstNum isEqualToString:@"p"]) {
                    [self.lingqu2Button setTitle:@"已领取"
                                        forState:UIControlStateNormal];
                    self.lingqu2Button.layer.borderColor = [UIColor clearColor].CGColor;
                } else if ([firstNum isEqualToString:@"x"]) {
                    [self.lingqu3Button setTitle:@"已领取"
                                        forState:UIControlStateNormal];
                    self.lingqu3Button.layer.borderColor = [UIColor clearColor].CGColor;
                }
            }
        }
        
    }
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)registerCell {
    UINib *suNib = [UINib nibWithNibName:NSStringFromClass([SUTableViewCell class])
                                  bundle:nil];
    [self.tableView registerNib:suNib forCellReuseIdentifier:NSStringFromClass([SUTableViewCell class])];
}

- (void)setupViews {
    self.title = @"零元购";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    [self wr_setNavBarBackgroundAlpha:0.0f];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.lingyu1Button.layer.cornerRadius = 15.0f;
    self.lingqu2Button.layer.cornerRadius = 15.0f;
    self.lingqu3Button.layer.cornerRadius = 15.0f;
    
    self.lingyu1Button.borderColor = [UIColor whiteColor];
    self.lingyu1Button.borderWidth = 1.0f;
    
    self.lingqu2Button.borderColor = [UIColor whiteColor];
    self.lingqu2Button.borderWidth = 1.0f;
    
    self.lingqu3Button.borderColor = [UIColor whiteColor];
    self.lingqu3Button.borderWidth = 1.0f;
    
    CGFloat padding = 100.0f;
    if (IS_IPHONE_5) {
        padding = 93.0f;
    } else if (IS_IPHONE_6) {
        padding = 110.0f;
    } else if (IS_IPHONE_6P) {
        padding = 120.0f;
    }
    self.lingquRightConstraint.constant = padding;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.actions.count;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 22.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor clearColor];
    return aView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SUTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SUTableViewCell class])];
    Actions *action  = self.actions[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"恭喜%@",action.phone];
    NSString *phoneStr = @"获得iphone8";
    if (action.amount == 200000) {
        phoneStr = @"获得iphone8";
    } else if (action.amount == 300000) {
        phoneStr = @"获得iphone8plus";
    } else if (action.amount == 500000) {
        phoneStr = @"获得iphoneX";
    }
    cell.phoneLabel.text = phoneStr;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = offsetY / 200;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

- (void)inputPickPWWithAmount:(NSString *)money {
    self.amont = money;
    CGFloat width = IS_IPHONE_5 ? 260.0f : 340;
    
    CGFloat height = 270.0f;
    if (IS_IPHONE_5) {
        height = 250.0f;
    }
    self.actionView =
    [[ActionView alloc] initWithFrame:CGRectMake(0.0f, -100.0f, width, height)];
    self.popController =
    [ASPopupController  alertWithPresentStyle:ASPopupPresentStyleSlideDown
                                 dismissStyle:ASPopupDismissStyleSlideDown
                                    alertView:self.actionView];
    [self.actionView.cancleButton addTarget:self
                                     action:@selector(dismiss)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [self.actionView.nextButton addTarget:self
                                   action:@selector(next)
                         forControlEvents:UIControlEventTouchUpInside];
    
    [self presentViewController:self.popController
                       animated:YES
                     completion:nil];
}

- (void)dismiss {
    [self.view endEditing:YES];
    if (self.popController) {
        [self.popController dismissViewControllerAnimated:YES
                                               completion:nil];
    }
}

- (void)next {
    //提交信息
    if (!self.actionView.addressTextField.text.length) {
        [self showErrorWithTitle:@"收货人姓名不能为空"];
        return;
    }
    if (!self.actionView.phoneTextField.text.length) {
        [self showErrorWithTitle:@"联系方式不能为空"];
        return;
    }
    if (!self.actionView.textView.text.length) {
        [self showErrorWithTitle:@"地址不能为空"];
        return;
    }
    [self dismiss];
    
    [self showSVProgressHUDWithStatus:@"预订中"];
    QRRequestLockAction *request = [[QRRequestLockAction alloc] init];
    __weak typeof(self) weakSelf = self;
    request.address = self.actionView.textView.text;
    request.phone = self.actionView.phoneTextField.text;
    request.name = self.actionView.addressTextField.text;
    request.userId = [UserUtil currentUser].userId;
    request.amount  = self.amont;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        ActionLock *actions = [ActionLock mj_objectWithKeyValues:request.responseJSONObject];
        NSLog(@"产品详情::++++::::%@",request.responseJSONObject);
        if (actions.statusType == IndentityStatusSuccess) {
            [weakSelf showSuccessWithTitle:@"预订成功"];
            PruductDetailViewController *detailController = [[PruductDetailViewController alloc] init];
            detailController.period = @"60";
            [weakSelf.navigationController pushViewController:detailController
                                                     animated:YES];
        } else {
            NSLog(@"error:::::%@",actions.desc);
            [weakSelf showErrorWithTitle:actions.desc];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf dimissSVProgressHUD];
        [weakSelf showErrorWithTitle:@"请求失败"];
    }];
    
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)submit8:(UIButton *)sender {
    if ([UserUtil isLoginIn]) {
        if (self.actionInfo.amount > 0 && self.actionInfo.gmtCreated.length > 0) {
            [self showSuccessWithTitle:@"你已经预订该活动"];
        } else {
            [self inputPickPWWithAmount:@"200000"];
        }
    } else {
        [self login];
    }
}

- (IBAction)submitPlus:(UIButton *)sender {
    if ([UserUtil isLoginIn]) {
        if (self.actionInfo.amount > 0 && self.actionInfo.gmtCreated.length > 0) {
            [self showSuccessWithTitle:@"你已经预订该活动"];
        } else {
            [self inputPickPWWithAmount:@"300000"];
        }
    } else {
        [self login];
    }
}

- (IBAction)submitX:(UIButton *)sender {
    if ([UserUtil isLoginIn]) {
        if (self.actionInfo.amount > 0 && self.actionInfo.gmtCreated.length > 0) {
            [self showSuccessWithTitle:@"你已经预订该活动"];
        } else {
            [self inputPickPWWithAmount:@"500000"];
        }
    } else {
        [self login];
    }
}


- (IBAction)lingqu8:(UIButton *)sender {
    [self pickPriceWithName:@"iphone8" button:sender];
}

- (IBAction)lingquplus:(UIButton *)sender {
    [self pickPriceWithName:@"iphone8plus" button:sender];
}


- (IBAction)lingqux:(UIButton *)sender {
    [self pickPriceWithName:@"iphoneX" button:sender];
}

- (void)pickPriceWithName:(NSString *)name button:(UIButton *)sender {
    
    self.lingPriceButton = sender;
    NSString *value = [[A0SimpleKeychain keychain] stringForKey:QR_PRICE_STAUTS];
    
    NSString *firstVlaue = @"8";
    if ([name isEqualToString:@"iphone8"]) {
        firstVlaue = @"8";
    } else if ([name isEqualToString:@"iphone8plus"]) {
        firstVlaue = @"p";
    } else if ([name isEqualToString:@"iphoneX"]) {
        firstVlaue = @"x";
    }
    
    NSString *priceValue =
    [NSString stringWithFormat:@"%@%@",firstVlaue,[NSString getStringWithString:[UserUtil currentUser].userId]];
    
    if ([value isEqualToString:priceValue] && [value containsText:[NSString getStringWithString:[UserUtil currentUser].userId]]) {
        [self showSuccessWithTitle:@"奖品已领取，如有问题，请联系客服"];
        return;
    }
    [[A0SimpleKeychain keychain] setString:priceValue forKey:QR_PRICE_STAUTS];
    CGFloat width = IS_IPHONE_5 ? 260.0f : 350;
    CGFloat height = 350.0f;
    if (IS_IPHONE_6P) {
        height = 400.0f;
    } else if (IS_IPHONE_6) {
        height = 380.0f;
    }
    self.priceView =
    [[ActionPriceView alloc] initWithFrame:CGRectMake(0.0f, -100.0f, width, height)];
    
    NSString *imageName = @"iphone_8plus_image";
    
    if ([name isEqualToString:@"iphoneX"]) {
        imageName = @"iphone_x_image";
    }
    self.priceView.phoneImageView.image = [UIImage imageNamed:imageName];
    self.priceView.titleLabel.text = [NSString stringWithFormat:@"恭喜你获得%@一台",name];
    self.popController1 =
    [ASPopupController  alertWithPresentStyle:ASPopupPresentStyleSlideDown
                                 dismissStyle:ASPopupDismissStyleSlideDown
                                    alertView:self.priceView];
    [self.priceView.cancleButton addTarget:self
                                    action:@selector(cancle)
                          forControlEvents:UIControlEventTouchUpInside];
    [self presentViewController:self.popController1
                       animated:YES
                     completion:nil];
}

- (void)cancle {
    [self.view endEditing:YES];
    if (self.popController1) {
        [self.popController1 dismissViewControllerAnimated:YES
                                               completion:nil];
    }
    [self.lingPriceButton setTitle:@"已领取"
                          forState:UIControlStateNormal];
    self.lingPriceButton.layer.borderColor = [UIColor clearColor].CGColor;
}

@end
