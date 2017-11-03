//
//  BuyHistoryViewController.m
//  qulicai
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#define TitleHeight 40  //头高度
#define NavBarHeight  (IS_IPHONE_X ? 88 : 64)  //nav高度
#define YYScreenH [UIScreen mainScreen].bounds.size.height
#define YYScreenW [UIScreen mainScreen].bounds.size.width
static NSString * const ID = @"CELL";

#import "BuyHistoryViewController.h"
#import "AppDelegate.h"
#import "UIView+XJExtension.h"
#import <Masonry.h>
#import "UserUtil.h"
#import "User.h"
#import "QRRequestHeader.h"
#import "ExpectedTotal.h"
#import "ProductHistoryTwoViewController.h"
#import "ProductHistoryThreeViewController.h"

@interface BuyHistoryViewController ()
<UICollectionViewDataSource,
UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *noBuyHistoryView;

@property (weak, nonatomic) IBOutlet UIView *historyView;

@property (weak, nonatomic) IBOutlet UIView *bottomPageContainView;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIScrollView *topView;

@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, weak) UIButton *selectButton;

@property (nonatomic, strong) NSMutableArray *titleButtons;

@property (strong, nonatomic) ExpectedTotal *expectedTotal;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHistoryConstraint;

@end

@implementation BuyHistoryViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopView];
    [self setupBottomContentView];
    [self setupAllChildViewController];
    [self setupAllTitle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
    [self requestApi];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)requestApi {
    QRRequestExpectedInterest *request = [[QRRequestExpectedInterest alloc] init];
    request.userId = [NSString getStringWithString:[UserUtil currentUser].userId];
    __weak typeof(self) weakSlef = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"code::::::::%@",request.responseJSONObject);
        ExpectedTotal *expectedTotal = [ExpectedTotal mj_objectWithKeyValues:request.responseJSONObject];
        if (expectedTotal.statusType == IndentityStatusSuccess) {
            self.expectedTotal = expectedTotal;
            [weakSlef renderData];
        } else {
            //[weakSlef showErrorWithTitle:@"提交失败"];
            [weakSlef.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSlef dimissSVProgressHUD];
       // [weakSlef showErrorWithTitle:@"提交失败"];
        [weakSlef.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)renderData {
    self.totalMoneyLabel.text =
    [NSString stringWithFormat:@"%@",[NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(self.expectedTotal.revenue)]]];
    //方便车市
    self.historyView.hidden = NO;// !(self.expectedTotal.revenue > 0) ;
    self.noBuyHistoryView.hidden = YES;
}

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

- (void)setupTopView {
    UIScrollView *topView =
    [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, YYScreenW, TitleHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    _topView = topView;
    //UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, TitleHeight - 0.5f, YYScreenW, 0.5f)];
    //aLabel.backgroundColor = RGBColor(221.0f, 221.0f, 221.0f);
    [self.bottomPageContainView addSubview:topView];
    //[self.bottomPageContainView addSubview:aLabel];
    
    if (IS_IPHONE_X) {
        self.topHistoryConstraint.constant = 88.0f;
    }
    
}

- (void)setupAllChildViewController {
 
    ProductHistoryTwoViewController *twoVc = [[ProductHistoryTwoViewController alloc] init];
    twoVc.title = @"持有中";
    [self addChildViewController:twoVc];
    
    ProductHistoryThreeViewController *threeVc = [[ProductHistoryThreeViewController alloc] init];
    threeVc.title = @"已完成";
    [self addChildViewController:threeVc];
    
}

- (void)setupAllTitle {
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnW = YYScreenW/count;
    CGFloat btnH = _topView.xj_height;
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        // 设置标题颜色
        [titleButton setTitleColor:RGBColor(242.0f, 89.0f, 47.0f)
                          forState:UIControlStateSelected];
        [titleButton setTitleColor:RGBColor(102.0f, 102.0f, 102.0f)
                          forState:UIControlStateNormal];
        
        // 设置标题字体
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        btnX = i * btnW;
        
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        
        // 监听按钮点击
        [titleButton addTarget:self
                        action:@selector(titleClick:)
              forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:titleButton];
        
        if (i == 0) {
            // 添加下划线
            // 下划线宽度 = 按钮文字宽度
            // 下划线中心点x = 按钮中心点x
            CGFloat h = 2;
            CGFloat y = 38 ;
            UIView *lineView =[[UIView alloc] init];
            // 位置和尺寸
            lineView.xj_height = h;
            // 先计算文字尺寸,在给label去赋值
            [titleButton.titleLabel sizeToFit];
            lineView.xj_width = titleButton.titleLabel.xj_width;
            lineView.xj_centerX = titleButton.xj_centerX;
            lineView.xj_y = y;
            lineView.backgroundColor = RGBColor(242.0f, 89.0f, 47.0f);
            _lineView = lineView;
            [_topView addSubview:lineView];
            
            [self titleClick:titleButton];
        }
        [self.titleButtons addObject:titleButton];
    }
}

- (void)setupBottomContentView {
    // 创建一个流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(YYScreenW, YYScreenH - (230 - 64 + NavBarHeight) - TitleHeight);
    
    // 设置水平滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    // 创建UICollectionView
    UICollectionView *collectionView =
    [[UICollectionView alloc] initWithFrame:CGRectMake(0,TitleHeight, YYScreenW, YYScreenH - (230 - 64 + NavBarHeight) - TitleHeight) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.bottomPageContainView addSubview:collectionView];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(TitleHeight, 0, 0, 0);
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomPageContainView.mas_top).with.offset(padding.top);
        make.left.equalTo(self.bottomPageContainView.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.bottomPageContainView.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(self.bottomPageContainView.mas_right).with.offset(-padding.right);
    }];
    
    _collectionView = collectionView;
    collectionView.scrollsToTop = NO;
    collectionView.scrollEnabled = YES;
    // 开启分页
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = YES;
    
    // 展示cell
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 注册cell
    [collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:ID];
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger i = scrollView.contentOffset.x / YYScreenW;
    UIButton *selButton = self.titleButtons[i];
    [self selButton:selButton];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.childViewControllers[indexPath.row];
    [cell.contentView addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    
    return cell;
}

#pragma mark - Setters && Getters

- (NSMutableArray *)titleButtons {
    if (!_titleButtons) {
        _titleButtons = [[NSMutableArray alloc] init];
    }
    return _titleButtons;
}

#pragma mark - Handlers

- (void)titleClick:(UIButton *)titleButton{
    
    NSInteger i = titleButton.tag;
    if (titleButton == _selectButton) {
    }
    [self selButton:titleButton];

    CGFloat offsetX = i * YYScreenW;
    _collectionView.contentOffset = CGPointMake(offsetX, 0);
}

- (void)selButton:(UIButton *)titleButton{
    
    _selectButton.selected = NO;
    titleButton.selected = YES;
    _selectButton = titleButton;

    [UIView animateWithDuration:0.25 animations:^{
        _lineView.xj_centerX = titleButton.xj_centerX;
    }];
}


- (void)leftBarButtonAction {
    if (self.isPresent) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)goBuy:(UIButton *)sender {
    self.tabBarController.selectedIndex = 1;
    [self.navigationController popViewControllerAnimated:NO];
}


@end
