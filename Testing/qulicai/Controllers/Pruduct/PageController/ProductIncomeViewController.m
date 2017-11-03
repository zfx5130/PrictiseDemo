//
//  ProductIncomeViewController.m
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ProductIncomeViewController.h"
#import "ProductIncomeTableViewCell.h"
#import "UIScrollView+Custom.h"
#import "QRRequestHeader.h"
#import "MaskList.h"
#import "ProductMask.h"
#import "BorrowMoneyDetailTableViewController.h"

@interface ProductIncomeViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *maskArray;

@end

@implementation ProductIncomeViewController

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
    //[self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData {
    [self requestProduct];
}

- (void)loadMoreData {
    [self requestProduct];
}

- (void)requestProduct {
    QRRequestProductMarkList *request = [[QRRequestProductMarkList alloc] init];
    request.productId = [NSString getStringWithString:self.productId];
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.tableView.mj_header endRefreshing];
        SLog(@"------%@",request.responseJSONObject);
        MaskList *maskList = [MaskList mj_objectWithKeyValues:request.responseJSONObject];
        if (maskList.statusType == IndentityStatusSuccess) {
            // NSLog(@"count:::::%@",@(productList.products.count));
            weakSelf.maskArray = maskList.masks;
            [weakSelf renderProductInfo];
        } else {
            [self showErrorWithTitle:@"请求失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showErrorWithTitle:@"网络请求错误"];
    }];
}

- (void)renderProductInfo {
    [self.tableView reloadData];
}

- (void)registerCell {
    UINib *infoNib = [UINib nibWithNibName:NSStringFromClass([ProductIncomeTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:infoNib
         forCellReuseIdentifier:NSStringFromClass([ProductIncomeTableViewCell class])];
}

#pragma mark - Setters && Getters

- (NSArray *)maskArray {
    if (!_maskArray) {
        _maskArray = [[NSArray alloc] init];
    }
    return _maskArray;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.maskArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductIncomeTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductIncomeTableViewCell class])];
    ProductMask *mask = self.maskArray[indexPath.row];
    NSString *name =
    [NSString getStringWithString:[NSString stringWithFormat:@"%@",[NSString getStringWithString:mask.name]]];
    if (!name.length) {
        name = @"未知用户";
    }
    cell.nameLabel.text = name;

    cell.moneyLabel.text =
    [NSString stringWithFormat:@"%@",[NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(mask.amount)]]];
    NSString *cardId =
    [NSString stringWithFormat:@"%@",[NSString getStringWithString:mask.idCard]];
    cell.indentifyLabel.text = cardId;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductMask *mask = self.maskArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([BorrowMoneyDetailTableViewController class])
                                                         bundle:nil];
    BorrowMoneyDetailTableViewController *borrowController =
    [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([BorrowMoneyDetailTableViewController class])];
    borrowController.markId = mask.maskId;
    [self.navigationController pushViewController:borrowController
                                         animated:YES];
    
}

@end
