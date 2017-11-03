//
//  ProductHistoryViewController.m
//  qulicai
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ProductHistoryThreeViewController.h"
#import "ProductHistoryTableViewCell.h"
#import "QRRecordDetailViewController.h"
#import "UIScrollView+Custom.h"
#import "QRRequestHeader.h"
#import "BuyHistoryList.h"
#import "BuyHistory.h"
#import "User.h"
#import "UserUtil.h"

@interface ProductHistoryThreeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *historys;

@property (assign, nonatomic) NSInteger status;

@end

@implementation ProductHistoryThreeViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self addRefreshControl];
    [self loadNewData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)addRefreshControl {
    [self.tableView addHeaderControlWithIdleTitle:@"下拉刷新"
                                     pullingTitle:@"松开刷新"
                                  refreshingTitle:@"正在刷新"
                                           target:self
                                         selector:@selector(loadNewData)];
   // [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    [self requestProduct];
}

- (void)requestProduct {
    QRRequestBuyHistory *request = [[QRRequestBuyHistory alloc] init];
    request.statusType = HistoryStatusEnded;
    request.pageSize = 50;
    request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.tableView.mj_header endRefreshing];
        SLog(@"--请求结果----%@",request.responseJSONObject);
        BuyHistoryList *historyList = [BuyHistoryList mj_objectWithKeyValues:request.responseJSONObject];
        [weakSelf saveToken:historyList.token];
        if (historyList.statusType == IndentityStatusSuccess) {
            weakSelf.historys = historyList.historyList;
            [weakSelf renderProductInfo];
        } else {
            [self showErrorWithTitle:@"请求失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showErrorWithTitle:@"网络请求错误"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)renderProductInfo {
    
    [self.tableView reloadData];
}

- (void)registerCell {
    UINib *infoNib = [UINib nibWithNibName:NSStringFromClass([ProductHistoryTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:infoNib
         forCellReuseIdentifier:NSStringFromClass([ProductHistoryTableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.historys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductHistoryTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductHistoryTableViewCell class])];
    BuyHistory *history = self.historys[indexPath.row];
    cell.titleDescLabel.text = @"完成时间";
    cell.productNameLabel.text = [NSString getStringWithString:[NSString stringWithFormat:@"趣钱宝定期%@天",history.period]];
    cell.holdMoneyLabel.text = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(history.money)]];

    cell.timeLabel.text =
    [[[NSString stringWithTimeInterval:([history.addTime doubleValue] + ([history.period integerValue] + 1) * 24 * 60 * 60 * 1000) / 1000]
      componentsSeparatedByString:@" "] firstObject];
    cell.balanceLabel.text = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(history.totalRate)]];
    return cell;
    
}

#pragma mark - Setters && Getters

- (NSArray *)historys {
    if (!_historys) {
        _historys = [[NSArray alloc] init];
    }
    return _historys;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    BuyHistory *history = self.historys[indexPath.row];
    if (![history.period isEqualToString:@"1"]) {
        QRRecordDetailViewController *productController = [[QRRecordDetailViewController alloc] init];
        productController.buyHistory = history;
        [self.navigationController pushViewController:productController animated:YES];
    }
}


@end
