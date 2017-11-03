//
//  YesterdayIncomeViewController.m
//  qulicai
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "YesterdayIncomeViewController.h"
#import "NewUserBuyTableViewCell.h"
#import "YesterdayIncomeView.h"
#import "IncomeTableViewCell.h"
#import "UserUtil.h"
#import "User.h"
#import "QRRequestYesterdayIncome.h"
#import "YesterdayIncomeList.h"
#import "YesterdayIncome.h"
#import "UIScrollView+Custom.h"

#define IMAGE_HEIGHT 230

@interface YesterdayIncomeViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) YesterdayIncomeView *headView;

@property (strong, nonatomic) YesterdayIncomeList *incomeList;

@end

@implementation YesterdayIncomeViewController

#pragma mark -lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    self.navigationItem.title = @"收益";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    [self wr_setNavBarBackgroundAlpha:0];
    [self setupTableHeadView];
    [self addRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"white_back_image"]];
    [self loadNewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)addRefreshControl {
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView addHeaderControlWithIdleTitle:@"下拉刷新"
                                     pullingTitle:@"松开刷新"
                                  refreshingTitle:@"正在刷新"
                                           target:self
                                         selector:@selector(loadNewData)];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.tableView.mj_header beginRefreshing];
}

- (void)renderUI {
    self.headView.incomeMoneyLabel.text = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(self.incomeList.totalYestEaring)]];
    [self.tableView reloadData];
}

- (void)loadNewData {
    User *user = [UserUtil currentUser];
    QRRequestYesterdayIncome *request = [[QRRequestYesterdayIncome alloc] init];
    request.userId = [NSString getStringWithString:user.userId];
    request.pageSize = @"10";
    request.currentPage = @"0";
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        SLog(@"数据：:：：：%@",request.responseJSONObject);
        [weakSelf.tableView.mj_header endRefreshing];
        YesterdayIncomeList *incomeList = [YesterdayIncomeList mj_objectWithKeyValues:request.responseJSONObject];
        if (incomeList.statusType == IndentityStatusSuccess) {
            
        } else {
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf showErrorWithTitle:@"请求失败"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}

- (void)registerCell {
    UINib *mainNib = [UINib nibWithNibName:NSStringFromClass([IncomeTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:mainNib
         forCellReuseIdentifier:NSStringFromClass([IncomeTableViewCell class])];
}

- (void)setupTableHeadView {
    self.headView = [[YesterdayIncomeView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,SCREEN_WIDTH, IMAGE_HEIGHT)];
    self.tableView.tableHeaderView = self.headView;
    self.headView.yesterIncomeLabel.font = FontNumberDinBoldWithSize(40.0f);
    self.headView.allIncomeLabel.font = FontNumberDinBoldWithSize(20.0f);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.incomeList.incomes.count;
    return !section ? count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IncomeTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IncomeTableViewCell class])];
    YesterdayIncome *income = self.incomeList.incomes[indexPath.row];
    cell.nameLabel.text = [NSString getStringWithString:income.name];
    cell.earningLabel.text = [NSString stringWithFormat:@"+%.2f",f(income.yestardayEaring)];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = offsetY  / 64;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return !indexPath.section ? 40.0f : 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = !section ? [UIColor whiteColor] : [UIColor clearColor];
    return aView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = !section ? [UIColor whiteColor] : [UIColor clearColor];
    return aView;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
