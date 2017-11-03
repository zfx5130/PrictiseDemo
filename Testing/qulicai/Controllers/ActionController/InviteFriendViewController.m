//
//  InviteFriendViewController.m
//  qulicai
//
//  Created by admin on 2017/10/26.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "zhPopupController.h"
#import "QRActionView.h"
#import "NSString+Custom.h"
#import "QRShareView.h"
#import "QRRequestHeader.h"
#import "InviteCount.h"
#import "UserUtil.h"
#import "User.h"
#import "Friends.h"
#import "InviteFriends.h"
#import "SUTableViewCell.h"
#import "SUTableView.h"
#import "NSString+Addition.h"

@interface InviteFriendViewController ()
<UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIButton *leftBackButton;

@property (strong, nonatomic) zhPopupController *zhController;

@property (weak, nonatomic) IBOutlet UILabel *detailContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *inviteFriendNumLabel;

@property (assign, nonatomic) BOOL isEmptyHistory;


@property (weak, nonatomic) IBOutlet UIView *friendsHolderView;

@property (weak, nonatomic) IBOutlet UIView *titleHolderView;

//45
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;

//155
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *friendsViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inviteHeightConstraint;

@property (strong, nonatomic) InviteCount *counts;

@property (copy, nonatomic) NSArray *friends;

@property (weak, nonatomic) IBOutlet SUTableView *tableView;

@end

@implementation InviteFriendViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 2100.0f)];
    [self setupViews];
    [self reloadData];
    [self registerCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupViews {
    self.title = @"邀请好友";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
    [self wr_setNavBarBackgroundAlpha:0.0f];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setupNavigation];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:20.0f],
                          NSForegroundColorAttributeName : RGBColor(255.0f, 66.0f, 58.0f)
                          };
    [self.detailContentLabel addAttributes:dic
                                   forText:@"800块"];
}

-(void)setupNavigation {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacer setWidth:-4];
    UIImage *image = [UIImage imageNamed:@"back_image"];
    self.leftBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBackButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.leftBackButton addTarget:self action:@selector(leftBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBackButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.leftBackButton];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spacer, rightBarButton, nil];
}

- (void)showHistoryWithStatus:(BOOL)isHidden {
    self.isEmptyHistory = isHidden;
    self.titleHolderView.hidden = self.isEmptyHistory;
    self.friendsHolderView.hidden = self.titleHolderView.hidden;
    self.titleTopConstraint.constant = self.isEmptyHistory ? -50.0f : 45.0f;
    self.friendsViewHeightConstraint.constant = self.isEmptyHistory ? 0.0f : 155.0f;
    self.inviteHeightConstraint.constant = self.isEmptyHistory ? 1850.0f : 2100.0f;
}

#pragma mark - API

- (void)reloadData {
    [self requestShowActionInfo];
    [self requestFriendList];
}

- (void)requestShowActionInfo {
    
    QRRequestGetInviteCount *request = [[QRRequestGetInviteCount alloc] init];
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        InviteCount *counts = [InviteCount mj_objectWithKeyValues:request.responseJSONObject];
        NSLog(@"邀请人数::++++::::%@",request.responseJSONObject);
        if (counts.statusType == IndentityStatusSuccess) {
            self.counts = counts;
            [weakSelf reloadUi];
        } else {
            NSLog(@"error:::::%@",counts.desc);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error:::::%@",request.error);
    }];
}

- (void)requestFriendList {
    if ([UserUtil isLoginIn]) {
        QRRequestGetFriendsList *request = [[QRRequestGetFriendsList alloc] init];
        request.userId  = [UserUtil currentUser].userId;
        __weak typeof(self) weakSelf = self;
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            InviteFriends *friends = [InviteFriends mj_objectWithKeyValues:request.responseJSONObject];
            NSLog(@"邀请人数::++++::::%@",request.responseJSONObject);
            if (friends.statusType == IndentityStatusSuccess) {
                self.friends = friends.friends;
                //刷新数据
                [weakSelf renderFriendlist];
            } else if (friends.statusType == IndentityStatusTypeInvalid) {
                [weakSelf outLogininWithController:weakSelf];
            } else {
                NSLog(@"error:::::%@",friends.desc);
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"error:::::%@",request.error);
        }];
    } else {
        [self showHistoryWithStatus:YES];
    }
}

- (void)renderFriendlist {
    [self showHistoryWithStatus:!self.friends.count];
    [self.tableView reloadData];
}

- (void)reloadUi {
    self.inviteFriendNumLabel.text = [NSString stringWithFormat:@"已有%@人获得现金红包",@(self.counts.inviteCount)];
    NSDictionary *dicOne = @{
                             NSForegroundColorAttributeName : RGBColor(255.0f, 210.0f, 43.0f)
                             };
    [self.inviteFriendNumLabel addAttributes:dicOne
                                     forText:[NSString stringWithFormat:@"%@",@(self.counts.inviteCount)]];
}

- (void)registerCell {
    UINib *suNib = [UINib nibWithNibName:NSStringFromClass([SUTableViewCell class])
                                  bundle:nil];
    [self.tableView registerNib:suNib forCellReuseIdentifier:NSStringFromClass([SUTableViewCell class])];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 22.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor clearColor];
    return aView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SUTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SUTableViewCell class])];
    Friends *friends = self.friends[indexPath.section];
    cell.nameLabel.text = friends.name;
    cell.optionLabel.text  = friends.optInfo;
    NSLog(@"::::::%@",friends.optTime);
    cell.dateTimeLabel.text = [NSString stringWithTimeInterval:[friends.optTime doubleValue] / 1000];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > 0) {
            CGFloat alpha = offsetY / 200;
            [self wr_setNavBarBackgroundAlpha:alpha];
            [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
            [self wr_setNavBarTitleColor:[RGBColor(51, 51, 51) colorWithAlphaComponent:alpha]];
            [self.leftBackButton setBackgroundImage:[UIImage imageNamed:@"forget_back_image"]
                                           forState:UIControlStateNormal];
        } else {
            [self wr_setNavBarBackgroundAlpha:0];
            [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
            [self.leftBackButton setBackgroundImage:[UIImage imageNamed:@"back_image"]
                                           forState:UIControlStateNormal];
            [self wr_setNavBarTitleColor:[UIColor clearColor]];
        }
    }
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionDetail:(UIButton *)sender {
    self.zhController = [zhPopupController popupControllerWithMaskType:zhPopupMaskTypeBlackBlur];
    QRActionView *aView = [[QRActionView alloc] initWithFrame:CGRectMake(15, 110, [UIScreen mainScreen].bounds.size.width - 30, 470)];
    self.zhController.slideStyle = zhPopupSlideStyleShrinkInOut;
    self.zhController.allowPan = YES;
    aView.zhPopController = self.zhController;
    [self.zhController presentContentView:aView];
}

- (IBAction)inviteFriend:(UIButton *)sender {
    if ([UserUtil isLoginIn]) {
        self.zhController = [[zhPopupController alloc] init];
        QRShareView *aView = [[QRShareView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 360)];
        aView.backgroundColor = [UIColor purpleColor];
        aView.currentController = self;
        aView.zhPopController = self.zhController;
        self.zhController.layoutType = zhPopupLayoutTypeBottom;
        [self.zhController presentContentView:aView];
    } else {
        [self login];
    }
}


@end
