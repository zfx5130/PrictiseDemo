//
//  BankCardSelectedViewController.m
//  qulicai
//
//  Created by admin on 2017/8/22.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "BankCardSelectedViewController.h"
#import "ProductRecordTableViewCell.h"
#import "BankCartTableViewCell.h"

@interface BankCardSelectedViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *bankArray;

@end

@implementation BankCardSelectedViewController

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

#pragma mark - lifeCycle

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    
    self.navigationItem.title = @"银行卡支持列表";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)registerCell {
    UINib *cycleNib = [UINib nibWithNibName:NSStringFromClass([BankCartTableViewCell class])
                                     bundle:nil];
    [self.tableView registerNib:cycleNib
         forCellReuseIdentifier:NSStringFromClass([BankCartTableViewCell class])];
}

#pragma mark - Setters && Gettters

- (NSArray *)bankArray {
    if (!_bankArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Bank" ofType:@"plist"];
        NSMutableArray *bankArr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        _bankArray = [bankArr copy];
    }
    return _bankArray;
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
    return (self.bankArray.count + 1) / 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BankCartTableViewCell class])];

    for( int i=0; i<2; i++) {
        NSInteger productIndex = (indexPath.row) * 2 + i;
        if(productIndex < 21) {
            NSDictionary *dic = self.bankArray[productIndex];
            if (!i) {
                cell.leftBankImageView.image = [UIImage imageNamed:dic[@"bankImageName"]];
                cell.leftBankNameLabel.text = [NSString stringWithFormat:@"%@",dic[@"bankName"]];
            } else {
                cell.rightBankImageView.image = [UIImage imageNamed:dic[@"bankImageName"]];
                cell.rightBankNameLabel.text = [NSString stringWithFormat:@"%@",dic[@"bankName"]];
            }
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
