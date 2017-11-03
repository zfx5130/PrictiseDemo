//
//  TotalPropertyViewController.m
//  qulicai
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "TotalPropertyViewController.h"
#import "ProductDetailListTableViewCell.h"
#import "PropertyHeadTableViewCell.h"
#import "DZ_ScaleCircle.h"
#import "MorePropertyTableViewCell.h"
#import "EmptyPropertyTableViewCell.h"
#import "PropertyInfoTableViewCell.h"
#import "PropertyPickupViewController.h"
#import "PropertyIncomeViewController.h"
#import "MoneyRechargeViewController.h"
#import "FirstRechargeViewController.h"
#import "User.h"
#import "UserUtil.h"
#import "QRRequestHeader.h"
#import "TransationFlowing.h"
#import "TransationFlowingList.h"

@interface TotalPropertyViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *totalMoneys;

@property (strong, nonatomic) EmptyPropertyTableViewCell *cell;

@property (copy, nonatomic) NSArray *flowings;

@property (copy, nonatomic) NSArray *allFlowings;

@property (assign, nonatomic) BOOL isFirstLoad;

@end

@implementation TotalPropertyViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"总资产";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    [self registerCell];
    [self reloadTotalProperty];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)reloadTotalProperty {
    //支付网管流水
    NSString *userId = [NSString getStringWithString:[UserUtil currentUser].userId];
    QRRequestTotalMoneyDetail *request = [[QRRequestTotalMoneyDetail alloc] init];
    request.currentPage = @"1";
    request.pageSize = @"50";
    request.userId = userId;
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        TransationFlowingList *list = [TransationFlowingList mj_objectWithKeyValues:request.responseJSONObject];
        [weakSelf saveToken:list.token];
        SLog(@"获取支付网管流水_:::::::::%@",request.responseJSONObject);
        weakSelf.totalMoneys = list.flowings;
        if (list.statusType == IndentityStatusSuccess) {
            QRRequestGetTransactionFlowing *request = [[QRRequestGetTransactionFlowing alloc] init];
            request.currentPage = @"1";
            request.pageSize = @"50";
            request.userId = userId;
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                TransationFlowingList *flowing = [TransationFlowingList mj_objectWithKeyValues:request.responseJSONObject];
                [weakSelf saveToken:flowing.token];
                SLog(@":总收益流水:::::::%@",request.responseJSONObject);
                if (flowing.statusType == IndentityStatusSuccess) {
                    weakSelf.flowings = flowing.flowings;
                    [weakSelf renderUI];
                    weakSelf.cell.contentView.hidden = YES;
                } else {
                    [weakSelf showErrorWithTitle:@"请求失败"];
                    weakSelf.cell.contentView.hidden = NO;
                }
                
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [weakSelf showErrorWithTitle:@"请求失败"];
                NSLog(@"error:::::%@",request.error);
                weakSelf.cell.contentView.hidden = NO;
            }];

        } else if (list.statusType == IndentityStatusTypeInvalid) {
            [weakSelf outLogininWithController:weakSelf];
        } else {
            [weakSelf showErrorWithTitle:@"请求失败"];
            weakSelf.cell.contentView.hidden = NO;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf showErrorWithTitle:@"请求失败"];
        NSLog(@"error:::::%@",request.error);
        weakSelf.cell.contentView.hidden = NO;
    }];
}

- (void)renderUI {
    
    //对两个数组合并
    
    NSMutableArray *allFlowings =  [[NSMutableArray alloc] init];
    [allFlowings addObjectsFromArray:self.totalMoneys];
    [allFlowings addObjectsFromArray:self.flowings];
    
    //替换
    
    NSMutableArray *currentFlowingArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < allFlowings.count ; i++) {
        TransationFlowing *flowing = allFlowings[i];
        if (!flowing.transactionDate.length) {
            flowing.transactionDate = flowing.gmtCreated;
        }
        
        if (!flowing.money) {
            flowing.money = flowing.amount;
        }
        allFlowings[i] = flowing;
        
        if ([flowing.status isEqualToString:@"1"] && (flowing.type == 0 || flowing.type == 1)) {
            //方法1
//            [allFlowings removeObjectAtIndex:i];
//            i--;
        } else {
            //方法二
            [currentFlowingArray addObject:allFlowings[i]];
        }
        
    }
    //降序排序
    [currentFlowingArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        TransationFlowing *ob1 = obj1;
        TransationFlowing *ob2 = obj2;
        return [ob2.transactionDate compare:ob1.transactionDate];
    }];
    
    self.allFlowings = currentFlowingArray;
    [self.tableView reloadData];
    
}

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

- (void)registerCell {
    UINib *infoNib = [UINib nibWithNibName:NSStringFromClass([ProductDetailListTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:infoNib
         forCellReuseIdentifier:NSStringFromClass([ProductDetailListTableViewCell class])];
    
    UINib *propertyNib = [UINib nibWithNibName:NSStringFromClass([PropertyHeadTableViewCell class])
                                        bundle:nil];
    [self.tableView registerNib:propertyNib
         forCellReuseIdentifier:NSStringFromClass([PropertyHeadTableViewCell class])];
    
    UINib *moreCell = [UINib nibWithNibName:NSStringFromClass([MorePropertyTableViewCell class])
                                        bundle:nil];
    [self.tableView registerNib:moreCell
         forCellReuseIdentifier:NSStringFromClass([MorePropertyTableViewCell class])];
    
    UINib *emptyNib = [UINib nibWithNibName:NSStringFromClass([EmptyPropertyTableViewCell class])
                                     bundle:nil];
    [self.tableView registerNib:emptyNib
         forCellReuseIdentifier:NSStringFromClass([EmptyPropertyTableViewCell class])];
    
    UINib *propertyInfoNib = [UINib nibWithNibName:NSStringFromClass([PropertyInfoTableViewCell class])
                                     bundle:nil];
    [self.tableView registerNib:propertyInfoNib
         forCellReuseIdentifier:NSStringFromClass([PropertyInfoTableViewCell class])];
}

- (void)addScacleCircleWithCell:(PropertyHeadTableViewCell *)cell {
    
    if (!self.isFirstLoad) {
        DZ_ScaleCircle *circle =
        [[DZ_ScaleCircle alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
        User *user = [UserUtil currentUser];
        if (user.totalMoney > 0) {
            circle.firstColor = [UIColor colorWithRed:113.0f / 255 green:175.0f / 255 blue:255.0f / 255 alpha:1.0];
            circle.secondColor =[UIColor colorWithRed:255.0f / 255 green:168.0f / 255 blue:0 alpha:1.0];
            CGFloat rate = user.availableMoney * 1.0f / (user.availableMoney + user.regularMoney);
            circle.firstScale = 1 - rate;
            circle.secondScale = rate;
            circle.lineWith = 20;
        } else {
            circle.firstColor = RGBColor(204.0f, 204.0f, 204.0f);
            circle.firstScale = 1.0f;
            circle.lineWith = 20;
        }
        circle.unfillColor = [UIColor whiteColor];
        circle.animation_time = 0.5;
        circle.centerLable.text = @"";
        [cell.propertyCircleView addSubview:circle];
        
        self.isFirstLoad = YES;
    }
}

#pragma mark - Setters && Getters

- (NSArray *)totalMoneys {
    if (!_totalMoneys) {
        _totalMoneys = [[NSArray alloc] init];
    }
    return _totalMoneys;
}

- (NSArray *)flowings {
    if (!_flowings) {
        _flowings = [[NSArray alloc] init];
    }
    return _flowings;
}

- (NSArray *)allFlowings {
    if (!_allFlowings) {
        _allFlowings = [[NSArray alloc] init];
    }
    return _allFlowings;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSInteger num = 1;
    if (section == 2) {
        if (self.allFlowings.count > 0) {
            if (self.allFlowings.count > 5) {
                num = 5;
            } else {
                num = self.allFlowings.count;
            }
        } else {
            num = 1;
        }
    }
    return num;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        PropertyHeadTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PropertyHeadTableViewCell class])];
        User *user = [UserUtil currentUser];
        cell.totalPropertyLabel.text = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(user.totalMoney)]];
        cell.balanceLabel.text = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f", f(user.availableMoney)]];
        cell.regularLabel.text = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(user.regularMoney)]];
        [self addScacleCircleWithCell:cell];
        return cell;
    } else if (indexPath.section == 2) {
        if (!self.allFlowings.count) {
            self.cell =
            [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EmptyPropertyTableViewCell class])];
            return self.cell;
        } else {
            PropertyInfoTableViewCell *cell =
            [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PropertyInfoTableViewCell class])];
            TransationFlowing *money = self.allFlowings[indexPath.row];
            cell.nameLabel.text = money.stautsName;
            cell.typeLabel.text = money.statusTypeString;
            cell.timeLabel.text = [NSString stringWithTimeInterval:[money.transactionDate doubleValue] / 1000];
            
            NSString *moneyText = @"";
            moneyText = [NSString stringWithFormat:@"%@%@",money.signalType, [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(fabs(money.money))]]];
            cell.moneyLabel.text = moneyText;
            
            UIColor *typeLabelColor = RGBColor(255.0f, 0.0f, 0.0f);
            if ([cell.typeLabel.text isEqualToString:@"充值失败"] || [cell.typeLabel.text isEqualToString:@"提现失败"]) {
                typeLabelColor = RGBColor(255.0f, 0.0f, 0.0f);
            } else if ([cell.typeLabel.text isEqualToString:@"正在充值中"] || [cell.typeLabel.text isEqualToString:@"提现处理中"]) {
                typeLabelColor = RGBColor(255.0f, 168.0f, 0.0f);
            }
            cell.typeLabel.textColor = typeLabelColor;
            return cell;
        }
    }
    MorePropertyTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MorePropertyTableViewCell class])];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0) {
        CGFloat alpha = 1;
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    if (!indexPath.section) {
        height = 250.0f;
    } else if (indexPath.section == 1) {
        height = 45.0f;
    } else if (indexPath.section == 2) {
        height = self.allFlowings.count ? 60.0f : 250.0f;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return section == 1 ? CGFLOAT_MIN : 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] init];
    if (section != 2) {
        aView.backgroundColor = RGBColor(244.0f, 244.0f, 244.0f);
    }
    return aView;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    if (indexPath.section == 1) {
        PropertyIncomeViewController *incomeController = [[PropertyIncomeViewController alloc] init];
        incomeController.totalFlowings = self.allFlowings;
        [self.navigationController pushViewController:incomeController
                                             animated:YES];
    }
}

#pragma mark - Handlers

- (void)pickUpMoney {
    PropertyPickupViewController *pickContoller = [[PropertyPickupViewController alloc] init];
    [self.navigationController pushViewController:pickContoller animated:YES];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)leftBarButtonAction {
    if (self.isBankHanding) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)charge:(UIButton *)sender {
    User *currentUser = [UserUtil currentUser];
    if (currentUser.appBanks.count) {
        MoneyRechargeViewController *rechargeController = [[MoneyRechargeViewController alloc] init];
        [self.navigationController pushViewController:rechargeController
                                             animated:YES];
    } else {
        FirstRechargeViewController *firstController = [[FirstRechargeViewController alloc] init];
        [self.navigationController pushViewController:firstController
                                             animated:YES];
    }
}

- (IBAction)pickup:(UIButton *)sender {
    User *user = [UserUtil currentUser];
    if (user.availableMoney <= 0) {
        [self showAlertWithMessage:@"对不起，你无余额可提现!"];
    } else {
        if (user.appBanks.count) {
            [self pickUpMoney];
        } else {
            [self showAlertWithMessage:@"对不起，请先绑定银行卡!"];
        }
    }
}

@end
