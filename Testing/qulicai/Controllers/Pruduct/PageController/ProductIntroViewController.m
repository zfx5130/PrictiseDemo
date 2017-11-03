//
//  ProductIntroViewController.m
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ProductIntroViewController.h"
#import "ProductIntroTableViewCell.h"
#import "QRRequestHeader.h"
#import "ProductDetail.h"
#import "QRWebViewController.h"
#import "NSDate+Custom.h"

@interface ProductIntroViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *titleArrays;

@property (strong, nonatomic) NSMutableArray *contentArrays;

@end

@implementation ProductIntroViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self renderUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)renderUI {
    if (self.productDetail) {
        CGFloat rate = self.productDetail.yearRate * 100;
        CGFloat actRate = self.productDetail.activeRate * 100;
        NSString *yearText = @"";
        if (actRate <= 0) {
            yearText = [NSString stringWithFormat:@"%.1f%%",rate];
        } else {
            yearText = [NSString stringWithFormat:@"%.1f%%+%.1f%%", rate, actRate];
        }
        NSString *name = [NSString getStringWithString:[NSString stringWithFormat:@"趣钱宝定期%@天",self.period]];
        NSString *limit =
        [NSString stringWithFormat:@"%@元起投",[NSString getStringWithString:[NSString stringWithFormat:@"%ld",self.productDetail.lowestAmount]]];
        NSString *period = [NSString stringWithFormat:@"%@天",[NSString getStringWithString:self.period]];
        NSString *bala = @"到期一次性还本付息";
        NSString *rateStr = [NSString stringWithFormat:@"%@",yearText];
        
        NSString *startTime = [NSDate dateStringAllOneMorthWithCurrentTime:1];
        NSString *endTime = [NSDate dateStringAllOneMorthWithCurrentTime:([self.period integerValue] + 1)];
        [self.contentArrays removeAllObjects];
        [self.contentArrays addObject:name];
        [self.contentArrays addObject:limit];
        [self.contentArrays addObject:period];
        [self.contentArrays addObject:bala];
        [self.contentArrays addObject:rateStr];
        [self.contentArrays addObject:startTime];
        [self.contentArrays addObject:endTime];
        [self.tableView  reloadData];
    } else if (self.buyHistory) {
        
        //CGFloat actRate = self.buyHistory.totalRate;
        CGFloat actRact = self.buyHistory.rate * 100; // self.buyHistory.totalRate * 365 / ([self.buyHistory.period integerValue] * self.buyHistory.money);
        NSString *yearText = [NSString stringWithFormat:@"%.2f%%",f(actRact)];
        
        NSString *name = [NSString getStringWithString:[NSString stringWithFormat:@"趣钱宝定期%@天",self.buyHistory.period]];
        NSString *period = [NSString stringWithFormat:@"%@天",[NSString getStringWithString:self.buyHistory.period]];
        NSString *bala = @"到期一次性还本付息";
        NSString *rateStr = [NSString stringWithFormat:@"%@",yearText];
        NSString *startTime = [NSDate dateStringAllOneMorthWithCurrentTime:1
                                                              intertalTime:[self.buyHistory.addTime doubleValue] / 1000];
        NSString *endTime = [NSDate dateStringAllOneMorthWithCurrentTime:([self.buyHistory.period integerValue] + 1)
                                                            intertalTime:[self.buyHistory.addTime doubleValue] / 1000];
        [self.contentArrays removeAllObjects];
        [self.contentArrays addObject:name];
        [self.contentArrays addObject:period];
        [self.contentArrays addObject:bala];
        [self.contentArrays addObject:rateStr];
        [self.contentArrays addObject:startTime];
        [self.contentArrays addObject:endTime];
        [self.tableView  reloadData];
    }

}

- (void)registerCell {
    UINib *infoNib = [UINib nibWithNibName:NSStringFromClass([ProductIntroTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:infoNib
         forCellReuseIdentifier:NSStringFromClass([ProductIntroTableViewCell class])];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.titleArrays.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductIntroTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductIntroTableViewCell class])];
    cell.productTitleLabel.text = self.titleArrays[indexPath.row];
    cell.productContentLabel.text = self.contentArrays[indexPath.row];
    return cell;
}

#pragma mark - Setters & Getters

- (NSArray *)titleArrays {
    if (!_titleArrays) {
        if (self.buyHistory) {
            _titleArrays = @[
                             @"产品名称",
                             @"加入条件",
                             @"还款方式",
                             @"预计年化收益",
                             @"预计起息时间",
                             @"预计到期时间"
                             ];
        } else if (self.productDetail) {
            _titleArrays = @[
                             @"产品名称",
                             @"加入条件",
                             @"投资期限",
                             @"还款方式",
                             @"预计年化收益",
                             @"预计起息时间",
                             @"预计到期时间"
                             ];
        }
    }
    return _titleArrays;
}

- (NSMutableArray *)contentArrays {
    if (!_contentArrays) {
        _contentArrays = [[NSMutableArray alloc] init];
    }
    return _contentArrays;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor whiteColor];
    return aView;
}

- (UIView *)tableView:(UITableView *)tableView
viewForFooterInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 60.0f)];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 5, SCREEN_WIDTH - 30.0f, 55.0f)];
    aLabel.text = @"本产品是由杭州趣融信息科技有限公司匹配给个人供投资者提供投资信息的资产管理工具，趣钱宝提供5-30天短期灵活的资产配置方案，供投资者选择。";
    aLabel.font = [UIFont systemFontOfSize:14.0f];
    aLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
    aLabel.adjustsFontSizeToFitWidth = YES;
    aLabel.minimumScaleFactor = 0.6f;
    aLabel.numberOfLines = 0;
    aLabel.textAlignment = NSTextAlignmentLeft;
    [aView addSubview:aLabel];
    return aView;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Handlers

- (void)protocol:(UIButton *)sender {
    NSString *urlString = @"https://www.qulicai8.com/#/agreement_service";
    QRWebViewController *webViewController = [[QRWebViewController alloc] initWithTitle:@"投资服务协议"
                                                                              URLString:urlString];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];

}

@end
