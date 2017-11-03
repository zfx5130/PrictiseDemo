//
//  MyFuliViewController.m
//  qulicai
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MyFuliViewController.h"
#import "MyFuliTableViewCell.h"
#import "QRRequestHeader.h"
#import "UIScrollView+Custom.h"

@interface MyFuliViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyFuliViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    //NSLog(@":type:sdfadf:::::%@",self.type);
    [self addRefreshControl];
    [self loadNewData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)registerCell {
    UINib *fuliNib = [UINib nibWithNibName:NSStringFromClass([MyFuliTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:fuliNib
         forCellReuseIdentifier:NSStringFromClass([MyFuliTableViewCell class])];
}

- (void)addRefreshControl {
    [self.tableView addHeaderControlWithIdleTitle:@"下拉刷新"
                                     pullingTitle:@"松开刷新"
                                  refreshingTitle:@"正在刷新"
                                           target:self
                                         selector:@selector(loadNewData)];
    //[self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    NSLog(@":type::::::%@",self.type);
    [self requestProduct];
}

- (void)requestProduct {
    QRRequestBuyHistory *request = [[QRRequestBuyHistory alloc] init];
    request.statusType = HistoryStatusHolding;
    request.pageSize = 50;
    request.userId = @"";
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.tableView.mj_header endRefreshing];
        SLog(@"--请求结果----%@",request.responseJSONObject);
//        else if (friends.statusType == IndentityStatusTypeInvalid) {
//            [weakSelf outLogininWithController:weakSelf];
//        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showErrorWithTitle:@"网络请求错误"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)renderProductInfo {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFuliTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyFuliTableViewCell class])];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
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
