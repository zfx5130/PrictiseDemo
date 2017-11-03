//
//  PropertyIncomeViewController.m
//  qulicai
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "PropertyIncomeViewController.h"
#import "PropertyInfoTableViewCell.h"
#import "QRRequestHeader.h"
#import "UIScrollView+Custom.h"
#import "User.h"
#import "UserUtil.h"
#import "TransationFlowing.h"

@interface PropertyIncomeViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PropertyIncomeViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    self.navigationItem.title = @"资产流水";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)registerCell {
    
    UINib *propertyInfoNib = [UINib nibWithNibName:NSStringFromClass([PropertyInfoTableViewCell class])
                                            bundle:nil];
    [self.tableView registerNib:propertyInfoNib
         forCellReuseIdentifier:NSStringFromClass([PropertyInfoTableViewCell class])];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.totalFlowings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PropertyInfoTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PropertyInfoTableViewCell class])];
    TransationFlowing *money = self.totalFlowings[indexPath.row];
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
    } else {
        typeLabelColor = RGBColor(153.0f, 153.0f, 153.0f);
    }
    cell.typeLabel.textColor = typeLabelColor;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
