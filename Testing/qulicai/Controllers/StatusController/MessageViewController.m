//
//  MessageViewController.m
//  qulicai
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageDetailViewController.h"

@interface MessageViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageViewController

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

#pragma mark - Private

- (void)registerCell {
    UINib *nibName = [UINib nibWithNibName:NSStringFromClass([MessageTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:nibName
         forCellReuseIdentifier:NSStringFromClass([MessageTableViewCell class])];
}

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    self.navigationItem.title = @"消息";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageTableViewCell class])];
    BOOL isFlag = indexPath.row % 2 == 0;
    [cell renderUiiWithStatus:isFlag];
    cell.messageTitleLabel.text = isFlag ? @"充值成功" : @"提现成功";
    cell.messageContentLabel.text = isFlag ? @"尊敬的用户，您于2017-06-19 11:02:58注册成功趣理ad发大水打发斯蒂芬把安保费巴尔发送到吧拜拜尔冬升的发生的发生的发生的发生大发大事发生的发的沙发发的沙发沙发上的发生大法师法师打发顺丰。" : @"你完成任务获得了一笔平台体验金地方拿房卡斯诺伐克手动阀那是开发纳斯达克放哪手动阀卡戴珊你发誓开发商快递费把手动阀咖啡吧开始对方把手按时发生的发生的发生法撒旦法发斯蒂芬斯蒂芬手动阀是的发生发斯蒂芬。";
    cell.messageDateLabel.text = isFlag ? @"2017-10-18" : @"2017-10-25";
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    BOOL isFlag = indexPath.row % 2 == 0;
    MessageDetailViewController *detailController = [[MessageDetailViewController alloc] init];
    detailController.messageTitle = isFlag ? @"充值成功" : @"提现成功";
    detailController.messageContent = isFlag ? @"尊敬的用户，您于2017-06-19 11:02:58注册成功趣理ad发大水打发斯蒂芬把安保费巴尔发送到吧拜拜尔冬升的发生的发生的发生的发生大发大事发生的发的沙发发的沙发沙发上的发生大法师法师打发顺丰。" : @"你完成任务获得了一笔平台体验金地方拿房卡斯诺伐克手动阀那是开发纳斯达克放哪手动阀卡戴珊你发誓开发商快递费把手动阀咖啡吧开始对方把手按时发生的发生的发生法撒旦法发斯蒂芬斯蒂芬手动阀是的发生发斯蒂芬。";
    detailController.messageDate = isFlag ? @"2017-10-18" : @"2017-10-25";
    [self.navigationController pushViewController:detailController
                                         animated:YES];
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
