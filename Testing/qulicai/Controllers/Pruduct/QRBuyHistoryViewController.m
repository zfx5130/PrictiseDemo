//
//  QRProjectDetailViewController.m
//  qulicai
//
//  Created by admin on 2017/10/23.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "QRBuyHistoryViewController.h"
#import "WMPanGestureRecognizer.h"
#import "ProductHistoryThreeViewController.h"
#import "ProductHistoryTwoViewController.h"
#import "QRRequestHeader.h"
#import "ExpectedTotal.h"
#import "UserUtil.h"
#import "User.h"

static CGFloat const kWMMenuViewHeight = 44.0;

@interface QRBuyHistoryViewController ()
<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *musicCategories;
@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) UIView *redView;

@property (strong, nonatomic) UILabel *historyMoneyLabel;
@property (strong, nonatomic) ExpectedTotal *expectedTotal;

@end

@implementation QRBuyHistoryViewController

- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"持有中", @"已完成"];
    }
    return _musicCategories;
}

- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count  / 2;
        self.viewTop = kNavigationBarHeight + kWMHeaderViewHeight;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购买记录";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(15.0f, kNavigationBarHeight, [UIScreen mainScreen].bounds.size.width - 30, kWMHeaderViewHeight)];
    self.redView = redView;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, redView.frame.size.width, 67.0f)];
    nameLabel.text = @"购买记录";
    nameLabel.font = [UIFont boldSystemFontOfSize:26.0f];
    nameLabel.textColor = [UIColor colorWithRed:51 / 255.0f green:51 / 255.0f blue:51 / 255.0f alpha:1.0];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.redView addSubview:nameLabel];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 67.0f, redView.frame.size.width, 100.0f)];
    [self.redView addSubview:backView];
    
    self.historyMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, redView.frame.size.width, 56)];
    self.historyMoneyLabel.font = [UIFont boldSystemFontOfSize:40.0f];
    self.historyMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.historyMoneyLabel.textColor = RGBColor(242.0f, 89.0f, 47.0f);
    [backView addSubview:self.historyMoneyLabel];
    
    UILabel *titleContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 56, redView.frame.size.width, 17)];
    titleContentLabel.text = @"当前待收本息(元)";
    titleContentLabel.font = [UIFont systemFontOfSize:12.0f];
    titleContentLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
    titleContentLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleContentLabel];
    
    [self.view addSubview:self.redView];
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    [self requestApi];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
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
    self.historyMoneyLabel.text =
    [NSString stringWithFormat:@"%@",[NSString countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",f(self.expectedTotal.revenue)]]];
    
}

- (void)btnClicked:(id)sender {
    NSLog(@"touch up inside");
}

- (void)panOnView:(WMPanGestureRecognizer *)recognizer {
    // NSLog(@"pannnnnning received..");
    
    CGPoint currentPoint = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.lastPoint = currentPoint;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat targetPoint = velocity.y < 0 ? kNavigationBarHeight : kNavigationBarHeight + kWMHeaderViewHeight;
        NSTimeInterval duration = fabs((targetPoint - self.viewTop) / velocity.y);
        
        if (fabs(velocity.y) * 1.0 > fabs(targetPoint - self.viewTop)) {
            // NSLog(@"velocity: %lf", velocity.y);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.viewTop = targetPoint;
            } completion:nil];
            
            return;
        }
        
    }
    CGFloat yChange = currentPoint.y - self.lastPoint.y;
    self.viewTop += yChange;
    self.lastPoint = currentPoint;
}

// MARK: ChangeViewFrame (Animatable)
- (void)setViewTop:(CGFloat)viewTop {
    _viewTop = viewTop;
    
    if (_viewTop <= kNavigationBarHeight) {
        _viewTop = kNavigationBarHeight;
    }
    
    if (_viewTop > kWMHeaderViewHeight + kNavigationBarHeight) {
        _viewTop = kWMHeaderViewHeight + kNavigationBarHeight;
    }
    
    self.redView.frame = ({
        CGRect oriFrame = self.redView.frame;
        oriFrame.origin.y = _viewTop - kWMHeaderViewHeight;
        oriFrame;
    });
    //  NSLog(@"::::::%@:::::",NSStringFromCGRect(self.redView.frame));
    if (self.redView.frame.origin.y < 0) {
        CGFloat alpha = 1;
        [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
    } else {
        [self wr_setNavBarTitleColor:[UIColor clearColor]];
    }
    
    [self forceLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (!index) {
        ProductHistoryTwoViewController *twoVc = [[ProductHistoryTwoViewController alloc] init];
        return twoVc;
    }
    ProductHistoryThreeViewController *threeVc = [[ProductHistoryThreeViewController alloc] init];
    return threeVc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, _viewTop, self.view.frame.size.width, kWMMenuViewHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = _viewTop + kWMMenuViewHeight;
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end


