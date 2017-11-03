//
//  MessageDetailViewController.m
//  qulicai
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "UILabel+Custom.h"

@interface MessageDetailViewController ()
<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;

@end


@implementation MessageDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderData];
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
    self.navigationItem.title = self.messageTitle;
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)renderData {
    self.messageTitleLabel.text = self.messageTitle;
    self.messageDateLabel.text = self.messageDate;
    self.messageContentLabel.text = self.messageContent;
    [UILabel changeLineSpaceForLabel:self.messageContentLabel WithSpace:5.0f];
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
