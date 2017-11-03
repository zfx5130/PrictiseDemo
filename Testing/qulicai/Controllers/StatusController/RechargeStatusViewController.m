//
//  RechargeStatusViewController.m
//  qulicai
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "RechargeStatusViewController.h"
#import "RecommendProductViewCell.h"
#import "ProductPageTableViewCell.h"
#import "QRResultAnimationView.h"
#import "RecommendHeadTableViewCell.h"
#import "PruductDetailViewController.h"
#import "QRRequestHeader.h"
#import "ProductList.h"
#import "Product.h"

@interface RechargeStatusViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *productArray;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation RechargeStatusViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.bgImageView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestProduct];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setters && Getters

- (NSArray *)productArray {
    if (!_productArray) {
        _productArray = [[NSArray alloc] init];
    }
    return _productArray;
}


#pragma mark - Private

- (void)requestProduct {
    QRRequestProductList *request = [[QRRequestProductList alloc] init];
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

        SLog(@"productList-------%@",request.responseJSONObject);
        ProductList *productList = [ProductList mj_objectWithKeyValues:request.responseJSONObject];
        if (productList.statusType == IndentityStatusSuccess) {
            weakSelf.productArray = productList.products;
            weakSelf.bgImageView.hidden = NO;
            [weakSelf renderProductInfo];
        } else {
            weakSelf.bgImageView.hidden = YES;
            [self showErrorWithTitle:@"请求失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self showErrorWithTitle:@"请求失败"];
    }];
}

- (void)renderProductInfo {
    [self.tableView reloadData];
}


- (void)setupViews {
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self wr_setNavBarBackgroundAlpha:0.0f];
    UINib *recommedNib = [UINib nibWithNibName:NSStringFromClass([RecommendProductViewCell class])
                                        bundle:nil];
    [self.tableView registerNib:recommedNib
         forCellReuseIdentifier:NSStringFromClass([RecommendProductViewCell class])];
    UINib *pageNib = [UINib nibWithNibName:NSStringFromClass([ProductPageTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:pageNib
         forCellReuseIdentifier:NSStringFromClass([ProductPageTableViewCell class])];
    
    UINib *headNib = [UINib nibWithNibName:NSStringFromClass([RecommendHeadTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:headNib
         forCellReuseIdentifier:NSStringFromClass([RecommendHeadTableViewCell class])];
    self.title = @"精选推荐";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSInteger count =
    self.productArray.count > 8 ? 8 : self.productArray.count;
    return section == 2 ? count : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        RecommendProductViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecommendProductViewCell class])];
        ShowResultType type = self.isRechargeSuccess ? ShowResultTypeSuccess : ShowResultTypeFail;
        QRResultAnimationView *failView =
        [[QRResultAnimationView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0f, 50.0f) resultType:type];
        [cell.successView addSubview:failView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.successLabel.text = self.isRechargeSuccess ? @"充值成功!" : @"充值失败!";
            NSString *errorMessage = self.errorMessage.length > 0 ? self.errorMessage : @"交易失败";
            cell.successInfoLabel.text = self.isRechargeSuccess ? @"快去选购定期产品赚钱吧!" : errorMessage;
        });
        [cell.backButton addTarget:self
                            action:@selector(back)
                  forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if (indexPath.section == 1) {
        RecommendHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecommendHeadTableViewCell class])];
        cell.contentView.hidden = !(self.productArray.count > 0);
        return cell;
    }
    
    ProductPageTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductPageTableViewCell class])];
    Product *product = self.productArray[indexPath.row];
    CGFloat rate = product.yearRate * 100;
    CGFloat actRate = product.activeRate * 100;
    cell.yearIncomelabel.font = FontNumberDinBoldWithSize(26.0f);
    cell.periodsLabel.font = FontNumberDinBoldWithSize(20.0f);
    cell.moneyLabel.font = FontNumberDinBoldWithSize(20.0f);
    
    NSString *yearText = @"";
    if (actRate <= 0) {
        yearText = [NSString stringWithFormat:@"%.1f%%",rate];
        NSDictionary *dic = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:14.0f]
                              };
        cell.yearIncomelabel.text = yearText;
        [cell.yearIncomelabel addAttributes:dic
                                  forText:@"%"];
        
    } else {
        yearText = [NSString stringWithFormat:@"%.1f%%+%.1f%%", rate, actRate];
        cell.yearIncomelabel.text = yearText;
        NSMutableAttributedString *numText=
        [[NSMutableAttributedString alloc]initWithString:cell.yearIncomelabel.text
                                              attributes:nil];
        if (rate < 10 && cell.yearIncomelabel.text.length > 6) {
            [numText addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:14.0f]
                            range:NSMakeRange(3, 2)];
        } else {
            [numText addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:14.0f]
                            range:NSMakeRange(4, 2)];
        }
        [numText addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14.0f]
                        range:NSMakeRange(cell.yearIncomelabel.text.length - 1, 1)];
        cell.yearIncomelabel.attributedText = numText;
    }
    
    cell.periodsLabel.text = product.period;
    cell.moneyLabel.text = [NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(product.ableAmount)]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    if (!indexPath.section) {
        height = 280.0f;
    } else if (indexPath.section == 1){
        height = 60.0f;
    } else {
        height = 100.0f;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return section == 2 ? 30.0f : CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        Product *product = self.productArray[indexPath.row];
        PruductDetailViewController *productController = [[PruductDetailViewController alloc] init];
        productController.period = product.period;
        productController.productId = product.productId;
        productController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productController
                                             animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = offsetY  / 300;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)back {
    self.tabBarController.selectedIndex = 1;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end


