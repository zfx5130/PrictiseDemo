//
//  FinanceViewController.m
//  qulicai
//
//  Created by admin on 2017/8/14.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "FinanceViewController.h"
#import <SDCycleScrollView.h>
#import "NewUserBuyTableViewCell.h"
#import "UIImage+Custom.h"
#import "WRNavigationBar.h"
#import "PruductDetailViewController.h"
#import "UserUtil.h"
#import "QRRequestHeader.h"
#import "ProductList.h"
#import "UIScrollView+Custom.h"
#import "Product.h"
#import "User.h"
#import "FinanceActionViewController.h"

#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT*2)
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 180
#define SCROLL_DOWN_LIMIT 100
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

@interface FinanceViewController ()
<SDCycleScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *imagesUrlString;
@property (copy, nonatomic) NSArray *productArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;

@end

@implementation FinanceViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self addRefreshControl];
    if (IS_IPHONE_X) {
        self.tableViewTopConstraint.constant = -88.0f;
    }
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    self.title = @"理财";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    [self wr_setNavBarBackgroundAlpha:0.0f];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTableViewHeadView];
    [self requestProduct];
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
                                         selector:@selector(requestProduct)];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    //[self.tableView.mj_header beginRefreshing];
}

- (void)requestProduct {
    
    if ([UserUtil isLoginIn]) {
        //登录后请求产品列表
        QRRequestGetAuthProductList *request = [[QRRequestGetAuthProductList alloc] init];
        __weak typeof(self) weakSelf = self;
        request.userId = [UserUtil currentUser].userId;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf.tableView.mj_header endRefreshing];
            SLog(@"登录后产品列表--------%@",request.responseJSONObject);
            ProductList *productList = [ProductList mj_objectWithKeyValues:request.responseJSONObject];
            if (productList.statusType == IndentityStatusSuccess) {
                weakSelf.productArray = productList.products;
                [weakSelf renderProductInfo];
            }  else if (productList.statusType == IndentityStatusTypeInvalid) {
                [weakSelf outLogininWithController:weakSelf];
            } else {
                [self showErrorWithTitle:@"请求失败"];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [self showErrorWithTitle:@"请求失败"];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
    } else {
        QRRequestProductList *request = [[QRRequestProductList alloc] init];
        __weak typeof(self) weakSelf = self;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [weakSelf.tableView.mj_header endRefreshing];
            SLog(@"未登录产品列表-------%@",request.responseJSONObject);
            ProductList *productList = [ProductList mj_objectWithKeyValues:request.responseJSONObject];
            if (productList.statusType == IndentityStatusSuccess) {
                weakSelf.productArray = productList.products;
                [weakSelf renderProductInfo];
            } else {
                [self showErrorWithTitle:@"请求失败"];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [self showErrorWithTitle:@"请求失败"];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    
}

- (void)renderProductInfo {
    [self.tableView reloadData];
}

- (void)registerCell {
    UINib *financebuyNib = [UINib nibWithNibName:NSStringFromClass([NewUserBuyTableViewCell class])
                                          bundle:nil];
    [self.tableView registerNib:financebuyNib
         forCellReuseIdentifier:NSStringFromClass([NewUserBuyTableViewCell class])];
}

- (void)setupTableViewHeadView {
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IMAGE_HEIGHT)
                                                              delegate:self
                                                      placeholderImage:[UIImage imageNamed:@"fiscal_bg_image"]];
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"fiscal_rotation_down_image"];
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"fiscal_rotation_up_image"];
    self.cycleScrollView.imageURLStringsGroup = self.imagesUrlString;
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.tableView.tableHeaderView = self.cycleScrollView;
    [self.cycleScrollView clearCache];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - Getters && Setters

- (NSArray *)imagesUrlString {
    if (!_imagesUrlString) {
        _imagesUrlString = @[
                             @"http://qlc.oss-cn-shanghai.aliyuncs.com/banner1.jpg"
                             ];
    }
    return _imagesUrlString;
}

- (NSArray *)productArray {
    if (!_productArray) {
        _productArray = [[NSArray alloc] init];
    }
    return _productArray;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.productArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewUserBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewUserBuyTableViewCell class])];
    
    cell.yearSaleLabel.font = FontNumberDinBoldWithSize(26.0f);
    cell.deadlineLabel.font = FontNumberDinBoldWithSize(20.0f);
    cell.balanceLabel.font = FontNumberDinBoldWithSize(20.0f);
    Product *product = self.productArray[indexPath.section];
    
    CGFloat rate = product.yearRate * 100;
    CGFloat actRate = product.activeRate * 100;
    
    NSString *yearText = @"";    
    NSString *rateStr = [NSString stringWithFormat:@"%.1f",rate];
    
    cell.firstUseTagImageView.hidden = product.type;
    if (actRate > 0) {
        cell.firstUseTagImageView.hidden = YES;
    }
    
    if ([UserUtil isLoginIn]) {
        cell.fuLiUseHolderView.hidden = !product.haveBenefits;
    } else {
        cell.fuLiUseHolderView.hidden = YES;
    }
    
    if (actRate <= 0) {
        yearText = [NSString stringWithFormat:@"%.1f%%",rate];
        NSDictionary *dic = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:14.0f]
                              };
        cell.yearSaleLabel.text = yearText;
        [cell.yearSaleLabel addAttributes:dic
                                  forText:@"%"];
    } else {
        yearText = [NSString stringWithFormat:@"%.1f%%+%.1f%%", rate, actRate];
        cell.yearSaleLabel.text = yearText;
        NSMutableAttributedString *numText=
        [[NSMutableAttributedString alloc]initWithString:cell.yearSaleLabel.text
                                              attributes:nil];
        [numText addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14.0f]
                        range:NSMakeRange(rateStr.length, 2)];
        [numText addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14.0f]
                        range:NSMakeRange(cell.yearSaleLabel.text.length - 1, 1)];
        cell.yearSaleLabel.attributedText = numText;
    }
    
    cell.deadlineLabel.text = product.period;
    cell.balanceLabel.text =
    [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(product.ableAmount)]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? 55.0f : CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = RGBColor(244.0f, 244.0f, 244.0f);
    return aView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!section) {
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 55.0f)];
        aView.backgroundColor = [UIColor whiteColor];
        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 55.0f)];
        aLabel.text = @"趣钱宝定期";
        aLabel.textColor = RGBColor(51.0f, 51.0f, 51.0f);
        aLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18.0f];
        aLabel.textAlignment = NSTextAlignmentCenter;
        [aView addSubview:aLabel];
        return aView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Product *product = self.productArray[indexPath.section];
    PruductDetailViewController *productController = [[PruductDetailViewController alloc] init];
    productController.period = product.period;
    productController.productId = product.productId;
    productController.type = product.type;
    productController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productController
                                         animated:YES];
}

#pragma mark - Hanlders

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        CGFloat alpha = offsetY  / 64;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView
   didSelectItemAtIndex:(NSInteger)index {
    if (index == 0) {
        [self swapActionController];
    }
}

- (void)swapActionController {
    NSString *urlString = @"http://h5.qulicai8.com:3478/qlc_cunguan.html";
    FinanceActionViewController *webViewController = [[FinanceActionViewController alloc] initWithTitle:@"银行存管协议"
                                                                                              URLString:urlString];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}


@end
