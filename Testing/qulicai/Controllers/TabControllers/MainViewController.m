//
//  MainViewController.m
//  qulicai
//
//  Created by admin on 2017/8/14.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MainViewController.h"
#import "MainHeadView.h"
#import "QRInfoTableViewCell.h"
#import "QRWebViewController.h"
#import "PruductDetailViewController.h"
#import "LoginViewController.h"
#import "YesterdayIncomeViewController.h"
#import "TotalPropertyViewController.h"
#import "PropertyPickupViewController.h"
#import "ProductInformationController.h"
#import "UserUtil.h"
#import "QRRequestHeader.h"
#import "UserUtil.h"
#import "User.h"
#import "Product.h"
#import "UIView+ADGifLoading.h"
#import "UILabel+Custom.h"
#import "Version.h"
#import "InviteFriendTableViewCell.h"
#import "MainBottomTableViewCell.h"
#import "MoneyRechargeViewController.h"
#import "FirstRechargeViewController.h"
#import "UIScrollView+Custom.h"
#import "CompanyData.h"
#import "FinancialMoneyViewController.h"
#import "MessageViewController.h"
#import "RegisterViewController.h"
#import "UIImage+Custom.h"
#import "InviteFriendViewController.h"
#import "NewPeopleProductViewCell.h"
#import "NoviceMarkList.h"

//测试调用  
#import "TestTipViewController.h"

@interface MainViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MainHeadView *headView;

@property (copy, nonatomic) NSArray *products;

@property (strong, nonatomic) CompanyData *companyInfo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;

@property (strong, nonatomic) UIButton *rightBackButton;


@end

@implementation MainViewController

#pragma mark -lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self setupTableHeadView];
    [self reloadUI];
    [self getAppVersion];
    self.navigationItem.title = @"理财";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    [self wr_setNavBarBackgroundAlpha:0];
    [self addRefreshControl];
    AddNotificationCenter(updateHeadViewStatus, QR_OUTLOGIN_UPDATE_HEAD_VIEW_STAUTS);
    
    //测试调用
   // [self setupNavigationItemLeft:[UIImage imageNamed:@"login_lock_selected_image"]];
    
    //[self setupNavigationItemRight:[UIImage imageNamed:@"main_message_image"]];
    if (IS_IPHONE_X) {
        self.tableViewTopConstraint.constant = -88;
    }
   // [self setupNavigation];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUserInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self wr_setNavBarBackgroundAlpha:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Priavte

-(void)setupNavigation {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacer setWidth:-4];
    UIImage *image = [UIImage imageNamed:@"main_message_image"];
    self.rightBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBackButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.rightBackButton addTarget:self action:@selector(rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBackButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.rightBackButton];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:spacer, rightBarButton, nil];
}

- (void)addRefreshControl {
    [self.tableView addHeaderControlWithIdleTitle:@"下拉刷新"
                                     pullingTitle:@"松开刷新"
                                  refreshingTitle:@"正在刷新"
                                           target:self
                                         selector:@selector(loadData)];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
   // [self.tableView.mj_header beginRefreshing];
}

- (void)loadData {
    [self requestProduct];
    [self requestCompanyInfo];
    [self updateUserInfo];
}

- (void)updateHeadViewStatus {
    [self setupTableHeadView];
}

- (void)getAppVersion {
    QRRequestGetVersion *request = [[QRRequestGetVersion alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        Version *version = [Version mj_objectWithKeyValues:request.responseJSONObject];
        NSLog(@"版本信息:：:：:%@",request.responseJSONObject);
        if (version.statusType == IndentityStatusSuccess) {
            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            NSString *systemVersion = [infoDic objectForKey:@"CFBundleVersion"];
            NSString *apiVersion = version.ableVersion;
            if ([apiVersion isEqualToString:systemVersion]) {
                //版本相同
                NSLog(@"版本号相同");
            } else {
                NSLog(@"版本号不同");
                NSString *apiFirstLetter = [apiVersion substringToIndex:1];
                NSString *systemFirstLetter = [systemVersion substringToIndex:1];
                if (![apiFirstLetter isEqualToString:systemFirstLetter] && [apiFirstLetter integerValue] > [systemFirstLetter integerValue]) {
                    //大版本
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                    message:@"当前版本与最新版本变动较大，需要下载最新版本"
                                                                   delegate:self
                                                          cancelButtonTitle:@"去下载"
                                                          otherButtonTitles:nil, nil];
                    alert.tag = 1;
                    [alert show];
                } else if ([apiFirstLetter integerValue] == [systemFirstLetter integerValue]) {
                    //小版本
                    if (apiVersion.length >= 5 && systemVersion.length >= 5) {
                        NSString *apiNum = [apiVersion substringWithRange:NSMakeRange(2, 1)];
                        NSString *sysNum = [systemVersion substringWithRange:NSMakeRange(2, 1)];
                        if (apiNum < sysNum) {
                            //0 小于 1 不更新
                        } else {
                            //小版本
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                            message:@"当前版本不是最新版本，是否去下载"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"否"
                                                                  otherButtonTitles:@"去下载", nil];
                            alert.tag = 2;
                            [alert show];
                        }
                    }
                }
            }
            
        } else {
            NSLog(@"error:::%@",version.desc);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error:- %@",request.error);
    }];
}

- (void)requestProduct {
    QRRequestNoviceMark *request = [[QRRequestNoviceMark alloc] init];
    __weak typeof(self) weakSelf = self;
    request.userId = [UserUtil isLoginIn] ? [UserUtil currentUser].userId : @"";
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NoviceMarkList *productList = [NoviceMarkList mj_objectWithKeyValues:request.responseJSONObject];
        SLog(@"获取新手标信息------%@",request.responseJSONObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if (productList.statusType == IndentityStatusSuccess) {
            weakSelf.products = productList.products;
            [weakSelf renderProductInfo];
        } else {
            //[self showErrorWithTitle:@"请求失败"];
            NSLog(@"error::::::::%@", request.error);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //[self showErrorWithTitle:@"请求失败"];
        [weakSelf.tableView.mj_header endRefreshing];
        NSLog(@"error::::%@",request.error);
    }];
}

- (void)requestCompanyInfo {
    QRRequestCompanyTotalInfo *request = [[QRRequestCompanyTotalInfo alloc] init];
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        CompanyData *companyInfo = [CompanyData mj_objectWithKeyValues:request.responseJSONObject];
        SLog(@"累计数据------%@",request.responseJSONObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if (companyInfo.statusType == IndentityStatusSuccess) {
            weakSelf.companyInfo = companyInfo;
            [weakSelf renderProductInfo];
        } else {
            NSLog(@"error::::::::%@", request.error);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //[self showErrorWithTitle:@"请求失败"];
        [weakSelf.tableView.mj_header endRefreshing];
        NSLog(@"error::::%@",request.error);
    }];
}

- (void)renderProductInfo {
    [self.tableView reloadData];
}

- (void)reloadUI {
    NSString *keyValue = [[A0SimpleKeychain keychain] stringForKey:QR_LOOK_MONEY];
    BOOL isHidden = [keyValue isEqualToString:@"YES"];
    self.headView.lookButton.selected = isHidden;
    NSString *lookImage =
    isHidden ?  @"main_close_button_image" : @"main_open_button_image";
    [self.headView.lookButton setImage:[UIImage imageNamed:lookImage]
                              forState:UIControlStateNormal];
    self.headView.ablanceTagButton.hidden = !([UserUtil currentUser].availableMoney > 100) ;
    
    if (isHidden) {
        [self renderHiddenlLoginInfo];
    } else {
        [self renderHeadLoginInfo];
    }
}

- (void)updateUserInfo {
    if ([UserUtil isLoginIn]) {
        QRRequestGetUserInfo *request = [[QRRequestGetUserInfo alloc] init];
        request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
        __weak typeof(self) weakSelf = self;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            User *userInfo = [User mj_objectWithKeyValues:request.responseJSONObject];
            [weakSelf saveToken:userInfo.token];
            [weakSelf.tableView.mj_header endRefreshing];
            SLog(@"用户信息:::::::::::::%@",request.responseJSONObject);
            if (userInfo.statusType == IndentityStatusSuccess) {
                [UserUtil saving:userInfo];
                [weakSelf reloadUI];
            } else if (userInfo.statusType == IndentityStatusTypeInvalid) {
                NSLog(@"登录信息失效-error");
                [weakSelf outLogininWithController:weakSelf];
            } else {
                NSLog(@"error:::::%@",request.error);
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf.tableView.mj_header endRefreshing];
            NSLog(@"error:- %@", request.error);
        }];
    } else {
        [self reloadUI];
    }
}

- (void)registerCell {
    
    UINib *mainNib = [UINib nibWithNibName:NSStringFromClass([InviteFriendTableViewCell class])
                                        bundle:nil];
    [self.tableView registerNib:mainNib
         forCellReuseIdentifier:NSStringFromClass([InviteFriendTableViewCell class])];
    
    UINib *infoNib = [UINib nibWithNibName:NSStringFromClass([QRInfoTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:infoNib
         forCellReuseIdentifier:NSStringFromClass([QRInfoTableViewCell class])];
    
    UINib *bottomNib = [UINib nibWithNibName:NSStringFromClass([MainBottomTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:bottomNib
         forCellReuseIdentifier:NSStringFromClass([MainBottomTableViewCell class])];
    
    UINib *newPeopleNib = [UINib nibWithNibName:NSStringFromClass([NewPeopleProductViewCell class])
                                         bundle:nil];
    [self.tableView registerNib:newPeopleNib
         forCellReuseIdentifier:NSStringFromClass([NewPeopleProductViewCell class])];
    
}

- (void)setupTableHeadView {
    CGFloat padding = 0.0f;
    if (@available(iOS 11.0, *)) {
        padding = 64.0f;
    } else {
        padding  = 0.0f;
    }
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    CGFloat headViewHeight = [UserUtil isLoginIn] ? 380.0f : 340.0f;
  //  self.tableView.contentInset = UIEdgeInsetsMake(headViewHeight - padding, 0, 0, 0);
    self.headView = [[MainHeadView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, headViewHeight)];
    //[self.tableView addSubview:self.headView];
    self.tableView.tableHeaderView = self.headView;
    
    self.headView.allMoneyLabel.font = FontNumberDinBoldWithSize(20.0f);
    self.headView.yesterdayEarningLabel.font = FontNumberDinBoldWithSize(40.0f);
    self.headView.incomeLabel.font = FontNumberDinBoldWithSize(20.0f);
    self.headView.balanceLabel.font = FontNumberDinBoldWithSize(20.0f);
    self.headView.regularLabel.font = FontNumberDinBoldWithSize(20.0f);
    self.headView.sendMoneyLabel.font = FontNumberDinBoldWithSize(20.0f);
    
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : RGBColor(242.0f, 89.0f, 47.0f),
                          NSFontAttributeName : [UIFont boldSystemFontOfSize:36.0f]
                          };
    NSDictionary *dicRate = @{
                          NSForegroundColorAttributeName : RGBColor(242.0f, 89.0f, 47.0f),
                          NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0f]
                          };
    [self.headView.noLoginRateLabel addAttributes:dicRate
                                          forText:@"13%"];
    [self.headView.noLoginMoneyLabel addAttributes:dic forText:@"2888"];
    
    self.headView.pickupButton.layer.cornerRadius = 2.0f;
    self.headView.chargeButton.layer.cornerRadius = 2.0f;
    
    [self.headView.lookButton addTarget:self
                                 action:@selector(look:)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView.pickupButton addTarget:self
                                   action:@selector(pickUp:)
                         forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView.chargeButton addTarget:self
                                   action:@selector(chargeMoney:)
                         forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView.totalButton addTarget:self
                                  action:@selector(showTotalProperty)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView.yesterdayIncomeButton addTarget:self
                                            action:@selector(yesterdayIncome:)
                                  forControlEvents:UIControlEventTouchUpInside];
    [self.headView.finanalMoneyButton addTarget:self
                                         action:@selector(finanalMoney:)
                               forControlEvents:UIControlEventTouchUpInside];
    
    self.headView.loginHolderView.hidden = ![UserUtil isLoginIn];
    self.headView.noLoginHolderView.hidden = !self.headView.loginHolderView.hidden;
    
    NSMutableAttributedString *oldAccountString =
    [[NSMutableAttributedString alloc] initWithString:self.headView.oldAccountLabel.text
                                          attributes:nil];
    [oldAccountString addAttribute:NSForegroundColorAttributeName
                     value:[UIColor whiteColor]
                     range:NSMakeRange(self.headView.oldAccountLabel.text.length - 2, 2)];
    
    [oldAccountString addAttribute:NSUnderlineStyleAttributeName
                             value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                             range:NSMakeRange(self.headView.oldAccountLabel.text.length - 2, 2)];
    self.headView.oldAccountLabel.attributedText = oldAccountString;
    
    [self.headView.loginButton addTarget:self
                                  action:@selector(loginButtonWasPressed:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView.openAccountButton addTarget:self
                                        action:@selector(registerUser)
                              forControlEvents:UIControlEventTouchUpInside];
}


- (void)registerUser {
    RegisterViewController *registerController = [[RegisterViewController alloc] init];
    registerController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerController
                                         animated:YES];
}

- (void)loginButtonWasPressed:(UIButton *)sender {
    [self login];
}

- (void)yesterdayIncome:(UIButton *)sender {
//    YesterdayIncomeViewController *yesterdayController = [[YesterdayIncomeViewController alloc] init];
//    yesterdayController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:yesterdayController
//                                         animated:YES];
}

- (void)finanalMoney:(UIButton *)sender {
//    FinancialMoneyViewController *financialController = [[FinancialMoneyViewController alloc] init];
//    financialController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:financialController
//                                         animated:YES];
}

- (void)showTotalProperty {
    TotalPropertyViewController *propertyController = [[TotalPropertyViewController alloc] init];
    propertyController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:propertyController
                                         animated:YES];
}

- (void)pickUp:(UIButton *)sender {
    [self pickupMoney];
}

- (void)chargeMoney:(UIButton *)sender {
    User *currentUser = [UserUtil currentUser];
    if (currentUser.appBanks.count) {
        MoneyRechargeViewController *rechargeController = [[MoneyRechargeViewController alloc] init];
        rechargeController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rechargeController
                                             animated:YES];
    } else {
        FirstRechargeViewController *firstController = [[FirstRechargeViewController alloc] init];
        firstController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:firstController
                                             animated:YES];
    }
}

- (void)look:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"main_close_button_image"]
                forState:UIControlStateNormal];
        [self renderHiddenlLoginInfo];
        [[A0SimpleKeychain keychain] setString:@"YES" forKey:QR_LOOK_MONEY];
    } else {
        [sender setImage:[UIImage imageNamed:@"main_open_button_image"]
                forState:UIControlStateNormal];
        [self renderHeadLoginInfo];
        [[A0SimpleKeychain keychain] setString:@"NO" forKey:QR_LOOK_MONEY];
    }
}

- (void)renderHiddenlLoginInfo {
    self.headView.allMoneyLabel.text = @"****";
    self.headView.yesterdayEarningLabel.text = @"****";
    self.headView.incomeLabel.text = @"****";
    self.headView.balanceLabel.text = @"****";
    self.headView.regularLabel.text = @"****";
    self.headView.sendMoneyLabel.text = @"****";
}

- (void)renderHeadLoginInfo {
    User *user = [UserUtil currentUser];
    BOOL isLogin = [UserUtil isLoginIn];
    self.headView.allMoneyLabel.text =
    isLogin ? [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(user.totalMoney)]] : @"0.0";
    self.headView.yesterdayEarningLabel.text =
    isLogin ? [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(user.dailyEarnings)]] : @"0.0";
    self.headView.incomeLabel.text =
    isLogin ? [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(user.accumulatedIncome)]] : @"0.0";
    
    self.headView.balanceLabel.text =
    isLogin ? [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(user.availableMoney)]] : @"0.0";
    self.headView.regularLabel.text =
    isLogin ? [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(user.regularMoney)]] : @"0.0";
    self.headView.sendMoneyLabel.text =
    isLogin ? [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%@",@(user.totalFinancialGold)]] : @"0.0";
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1) {
        NSLog(@"大版本");
        [self swapAppStoreUrl];
    } else if (alertView.tag == 2) {
        NSLog(@"小版本");
        if (buttonIndex) {
            [self swapAppStoreUrl];
        }
    }
    
}

- (void)swapAppStoreUrl {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:QR_APPSTORE_URL]];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        InviteFriendTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InviteFriendTableViewCell class])];
        return cell;
    } else if (indexPath.section == 1) {
        NewPeopleProductViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewPeopleProductViewCell class])];
        cell.contentView.hidden = !self.products.count;
        cell.rateLabel.font = FontNumberDinBoldWithSize(26.0f);
        cell.periodLabel.font = FontNumberDinBoldWithSize(20.0f);
        if (self.products.count) {
            Product *product = self.products.firstObject;
            CGFloat rate = product.yearRate * 100;
            CGFloat actRate = product.activeRate * 100;
            cell.rateLabel.text = [NSString stringWithFormat:@"%.1f%%",(rate + actRate)];
            NSDictionary *dic = @{
                                  NSFontAttributeName : FontNumberDinBoldWithSize(14.0f)
                                  };
            [cell.rateLabel addAttributes:dic
                                  forText:@"%"];
            cell.periodLabel.text = [NSString stringWithFormat:@"%@",product.period];
        }

        return cell;
    } else if (indexPath.section == 2) {
        QRInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QRInfoTableViewCell class])];
        [cell.platformDataButton addTarget:self
                                    action:@selector(platformDataButtonWasPressed:)
                          forControlEvents:UIControlEventTouchUpInside];
        [cell.qrInfoButton addTarget:self
                              action:@selector(qrInfoButtonWasPressed:)
                    forControlEvents:UIControlEventTouchUpInside];
        [cell.safeButton addTarget:self
                            action:@selector(safeButtonWasPressed:)
                  forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    MainBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MainBottomTableViewCell class])];
    cell.contentView.hidden = self.companyInfo == nil;
    
    CGFloat totalMoney =  self.companyInfo.sum;
    CGFloat totalRate = self.companyInfo.rate;
    CGFloat totalCount = self.companyInfo.count;

    NSString *totalMoneyFirst = [NSString stringWithFormat:@"%d",(int)totalMoney / 10000 / 10000];
    
    NSString *totalMoneySecond = [NSString stringWithFormat:@"%@",@((int)totalMoney / 10000 - 10000 * [totalMoneyFirst integerValue])];
    //NSLog(@":::dfsdgsd::::%@",totalMoneySecond);
    NSString *totalMoneyLasted =
    [NSString stringWithFormat:@"%d",(int)(totalMoney - (int)(totalMoney / 10000) * 10000)];
   // NSLog(@":::dfsdgsd::::%@",totalMoneyLasted);
    
    if ([totalMoneyFirst integerValue] == 0) {
        cell.totalMoneyLabel.text =
        [NSString stringWithFormat:@"%@ 万 %@ 元", totalMoneySecond, totalMoneyLasted];
    } else {
        cell.totalMoneyLabel.text =
        [NSString stringWithFormat:@"%@ 亿 %@ 万 %@ 元", totalMoneyFirst, totalMoneySecond, totalMoneyLasted];
    }
    
    NSString *totalRateFirst = [NSString stringWithFormat:@"%d",(int)totalRate / 10000 / 10000];
    //NSLog(@":::dfsdgsd::::%@",totalRateFirst);
    
    NSString *totalRateSecond = [NSString stringWithFormat:@"%@",@((int)totalRate / 10000 - 10000 * [totalRateFirst integerValue])];
    //NSLog(@":::dfsdgsd::::%@",totalRateSecond);
    
    NSString *totalRateLasted =
    [NSString stringWithFormat:@"%d",(int)(totalRate - (int)(totalRate / 10000) * 10000)];
    //NSLog(@":::dfsdgsd::::%@",totalRateLasted);
    
    if ([totalRateFirst integerValue] == 0) {
        cell.allIncomelabel.text =
        [NSString stringWithFormat:@"%@ 万 %@ 元", totalRateSecond, totalRateLasted];
    } else {
        cell.allIncomelabel.text =
        [NSString stringWithFormat:@"%@ 亿 %@ 万 %@ 元", totalRateFirst, totalRateSecond, totalRateLasted];
    }
    
    NSString *totalCountFirst = [NSString stringWithFormat:@"%d",(int)totalCount / 10000];
    NSString *totalCountLasted =
    [NSString stringWithFormat:@"%d",(int)(totalCount - (int)(totalCount / 10000) * 10000)];
    cell.allUserLabel.text =
    [NSString stringWithFormat:@"%@ 万 %@ 人",totalCountFirst, totalCountLasted];
    
    
    cell.totalMoneyLabel.font = FontNumberDinBoldWithSize(26.0f);
    cell.allUserLabel.font = FontNumberDinBoldWithSize(26.0f);
    cell.allIncomelabel.font = FontNumberDinBoldWithSize(26.0f);
    
    NSMutableAttributedString *moneyText=
    [[NSMutableAttributedString alloc]initWithString:cell.totalMoneyLabel.text
                                          attributes:nil];
    if ([totalMoneyFirst integerValue] != 0) {
        [moneyText addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0f]
                          range:NSMakeRange(totalMoneyFirst.length + 1, 1)];
        [moneyText addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(153.0f, 153.0f, 153.0f)
                          range:NSMakeRange(totalMoneyFirst.length + 1, 1)];
        
        [moneyText addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0f]
                          range:NSMakeRange(totalMoneySecond.length + totalMoneyFirst.length + 4, 1)];
        [moneyText addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(153.0f, 153.0f, 153.0f)
                          range:NSMakeRange(totalMoneySecond.length + totalMoneyFirst.length + 4, 1)];
    } else {
        [moneyText addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0f]
                          range:NSMakeRange(totalMoneySecond.length + 1, 1)];
        [moneyText addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(153.0f, 153.0f, 153.0f)
                          range:NSMakeRange(totalRateSecond.length + 1, 1)];
    }
    
    [moneyText addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:14.0f]
                      range:NSMakeRange(cell.totalMoneyLabel.text.length - 1, 1)];
    [moneyText addAttribute:NSForegroundColorAttributeName
                      value:RGBColor(153.0f, 153.0f, 153.0f)
                      range:NSMakeRange(cell.totalMoneyLabel.text.length - 1, 1)];
    cell.totalMoneyLabel.attributedText = moneyText;
    
    
    NSMutableAttributedString *userText=
    [[NSMutableAttributedString alloc]initWithString:cell.allUserLabel.text
                                          attributes:nil];
    [userText addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:14.0f]
                      range:NSMakeRange(totalCountFirst.length + 1, 1)];
    [userText addAttribute:NSForegroundColorAttributeName
                     value:RGBColor(153.0f, 153.0f, 153.0f)
                     range:NSMakeRange(totalCountFirst.length + 1, 1)];
    
    [userText addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:14.0f]
                      range:NSMakeRange(cell.allUserLabel.text.length - 1, 1)];
    [userText addAttribute:NSForegroundColorAttributeName
                      value:RGBColor(153.0f, 153.0f, 153.0f)
                      range:NSMakeRange(cell.allUserLabel.text.length - 1, 1)];
    cell.allUserLabel.attributedText = userText;
    
    
    NSMutableAttributedString *incomeText=
    [[NSMutableAttributedString alloc]initWithString:cell.allIncomelabel.text
                                          attributes:nil];
    if ([totalRateFirst integerValue] != 0) {
        [incomeText addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:14.0f]
                           range:NSMakeRange(totalRateFirst.length + 1, 1)];
        [incomeText addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(153.0f, 153.0f, 153.0f)
                           range:NSMakeRange(totalRateFirst.length + 1, 1)];
        [incomeText addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0f]
                          range:NSMakeRange(totalRateSecond.length + totalRateFirst.length + 4, 1)];
        [incomeText addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(153.0f, 153.0f, 153.0f)
                          range:NSMakeRange(totalRateSecond.length + totalRateFirst.length + 4, 1)];
    } else {
        [incomeText addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:14.0f]
                           range:NSMakeRange(totalRateSecond.length + 1, 1)];
        [incomeText addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(153.0f, 153.0f, 153.0f)
                           range:NSMakeRange(totalRateSecond.length + 1, 1)];
    }
    
    [incomeText addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:14.0f]
                      range:NSMakeRange(cell.allIncomelabel.text.length - 1, 1)];
    [incomeText addAttribute:NSForegroundColorAttributeName
                      value:RGBColor(153.0f, 153.0f, 153.0f)
                      range:NSMakeRange(cell.allIncomelabel.text.length - 1, 1)];
    cell.allIncomelabel.attributedText = incomeText;
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = offsetY  / 64;
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
        
        [self.rightBackButton setBackgroundImage:[UIImage imageNamed:@"mine_message_image"]
                                        forState:UIControlStateNormal];
    } else {
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
        [self.rightBackButton setBackgroundImage:[UIImage imageNamed:@"main_message_image"]
                                        forState:UIControlStateNormal];
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 150.0f;
    if (!indexPath.section) {
        height = 120.0f;
    } else if (indexPath.section == 1) {
        if (self.products.count) {
            height = 200.0f;
        } else {
            height = 0.0f;
        }
    }  else if (indexPath.section == 2) {
        height = 160.0f;
    } else {
        if (self.companyInfo) {
            height = 400.0f;
        } else {
            height = 0.0f;
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    CGFloat padding = section == 3 ? CGFLOAT_MIN : 10.0f;
    return padding;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor clearColor];
    return aView;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        InviteFriendViewController *inviteController = [[InviteFriendViewController alloc] init];
        inviteController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:inviteController
                                             animated:YES];
    } else if (indexPath.section == 1) {
        PruductDetailViewController *productController = [[PruductDetailViewController alloc] init];
        productController.hidesBottomBarWhenPushed = YES;
        Product *product = self.products.firstObject;
        productController.period = product.period;
        productController.type = product.type;
        productController.productId = product.productId;
        [self.navigationController pushViewController:productController
                                             animated:YES];

    }
}

#pragma mark - Hanlders

- (void)totalPropertyButtonWasPressed:(UIButton *)sender {
    if ([UserUtil isLoginIn]) {
        TotalPropertyViewController *propertyController = [[TotalPropertyViewController alloc] init];
        propertyController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:propertyController
                                             animated:YES];
    } else {
        [self login];
    }
}

- (void)pickupMoney {
    if ([UserUtil isLoginIn]) {
        User *user = [UserUtil currentUser];
        if (user.availableMoney <= 0) {
            [self showAlertWithMessage:@"对不起，你无余额可提现!"];
        } else {
            if (user.appBanks.count) {
                PropertyPickupViewController *pickContoller = [[PropertyPickupViewController alloc] init];
                pickContoller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:pickContoller animated:YES];
            } else {
                [self showAlertWithMessage:@"对不起，请先绑定银行卡!"];
            }
        }
    } else {
        [self login];
    }
}

- (void)incomeButtonWasPressed:(UIButton *)sender {
    if ([UserUtil isLoginIn]) {
        YesterdayIncomeViewController *incomeController = [[YesterdayIncomeViewController alloc] init];
        incomeController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:incomeController
                                             animated:YES];
    } else {
        [self login];
    }
}

- (void)platformDataButtonWasPressed:(UIButton *)sender {
    NSString *urlString = @"http://h5.qulicai8.com:3478/qlc_company.html?nav=1";//@"https://www.qulicai8.com/#/companyAndproduct?m=c2";
    QRWebViewController *webViewController = [[QRWebViewController alloc] initWithTitle:@"产品介绍"
                                                                              URLString:urlString];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}

- (void)qrInfoButtonWasPressed:(UIButton *)sender {
    NSString *urlString = @"http://h5.qulicai8.com:3478/qlc_company.html?nav=0";//@"https://www.qulicai8.com/#/companyAndproduct?m=c3";
    QRWebViewController *webViewController = [[QRWebViewController alloc] initWithTitle:@"企业简介"
                                                                              URLString:urlString];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}

- (void)safeButtonWasPressed:(UIButton *)sender {
    NSString *urlString = @"http://h5.qulicai8.com:3478/qlc_company.html?nav=2";//@"https://www.qulicai8.com/#/companyAndproduct?m=c1";
    QRWebViewController *webViewController = [[QRWebViewController alloc] initWithTitle:@"安全保障"
                                                                              URLString:urlString];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

//测试调用
- (void)leftBarButtonAction {
    TestTipViewController *testController = [[TestTipViewController alloc] init];
    testController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:testController
                                         animated:YES];
}

- (void)rightBarButtonAction {
    if ([UserUtil isLoginIn]) {
        MessageViewController *messageController = [[MessageViewController alloc] init];
        messageController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messageController
                                             animated:YES];
    } else {
        [self login];
    }
}

@end
