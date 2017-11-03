//
//  ActionRulesViewController.m
//  qulicai
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "ActionRulesViewController.h"
#import "UILabel+Custom.h"

@interface ActionRulesViewController ()
<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *actionOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionTwoLabel;

@end

@implementation ActionRulesViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    self.navigationItem.title = @"活动规则";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    NSDictionary *dicOne = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
                          NSForegroundColorAttributeName : RGBColor(242.0f, 89.0f, 47.0f)
                          };
    [self.actionOneLabel addAttributes:dicOne
                               forText:@"理财金使用说明："];
    NSDictionary *dicTwo = @{
                             NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
                             NSForegroundColorAttributeName : RGBColor(51.0f, 51.0f, 51.0f)
                             };
    [self.actionTwoLabel addAttributes:dicTwo
                               forText:@"加息券使用说明："];
    
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

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
