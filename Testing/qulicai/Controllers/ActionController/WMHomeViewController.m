//
//  WMHomeViewController.m
//  Demo
//
//  Created by Mark on 16/7/25.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMHomeViewController.h"
#import "MyFuliViewController.h"
#import "WMPanGestureRecognizer.h"
#import "ActionRulesViewController.h"

static CGFloat const kWMHeaderViewHeight = 67;
static CGFloat const kWMMenuViewHeight = 44.0;

@interface WMHomeViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *musicCategories;
@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) UIView *redView;
@end

@implementation WMHomeViewController

- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"未使用", @"已使用"];
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
    self.navigationItem.title = @"我的福利";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(15.0f, kNavigationBarHeight, [UIScreen mainScreen].bounds.size.width, kWMHeaderViewHeight)];
    self.redView = redView;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, redView.frame.size.width, kWMHeaderViewHeight)];
    nameLabel.text = @"我的福利";
    nameLabel.font = [UIFont boldSystemFontOfSize:26.0f];
    nameLabel.textColor = [UIColor colorWithRed:51 / 255.0f green:51 / 255.0f blue:51 / 255.0f alpha:1.0];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.redView addSubview:nameLabel];
    
    [self.view addSubview:self.redView];
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    [self setupNavigationItemRightTitle:@"活动规则"
                                  color:RGBColor(51.0f, 51.0f, 51.0f)];
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Datasource & Delegate

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (!index) {
        MyFuliViewController *vc = [[MyFuliViewController alloc] init];
        vc.type = @"0,2";
        return vc;
    }
    MyFuliViewController *vc = [[MyFuliViewController alloc] init];
    vc.type = @"1";
    return vc;
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

- (void)rightBarButtonAction {
    ActionRulesViewController *ruleController = [[ActionRulesViewController alloc] init];
    [self.navigationController pushViewController:ruleController
                                         animated:YES];
}

@end
