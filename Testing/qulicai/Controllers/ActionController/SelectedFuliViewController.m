//
//  SelectedFuliViewController.m
//  qulicai
//
//  Created by admin on 2017/10/27.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "SelectedFuliViewController.h"
#import "FuliTableViewCell.h"
#import "UIScrollView+Custom.h"
#import "QRRequestHeader.h"
#import "UserUtil.h"
#import "FuliTicket.h"
#import "Ticket.h"
#import "User.h"

@interface SelectedFuliViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSArray *tickets;

@end

@implementation SelectedFuliViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self addRefreshControl];
    [self renderFuliData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
    NSLog(@":type::::%@:::money::%@:::::period::%@",@(self.type), @(self.money), self.period);
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
                                         selector:@selector(renderFuliData)];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    //[self.tableView.mj_header beginRefreshing];
}


- (void)registerCell {
    UINib *fuliNib = [UINib nibWithNibName:NSStringFromClass([FuliTableViewCell class])
                                            bundle:nil];
    [self.tableView registerNib:fuliNib
         forCellReuseIdentifier:NSStringFromClass([FuliTableViewCell class])];
}

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
    self.navigationItem.title = @"选择福利";
    [self wr_setNavBarTitleColor:[UIColor clearColor]];
}

- (void)renderFuliData {
    QRRequestUserTicket *request = [[QRRequestUserTicket alloc] init];
    request.userId = [UserUtil currentUser].userId;
    request.status = @"0";
    __weak typeof(self) weakSelf = self;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        FuliTicket *tickets = [FuliTicket mj_objectWithKeyValues:request.responseJSONObject];
        SLog(@"福利列表::::::::%@:::::::::",request.responseJSONObject);
        [weakSelf.tableView.mj_header endRefreshing];
        if (tickets.statusType == IndentityStatusSuccess) {
            [weakSelf handleTicketsWithTickets:tickets.tickets];
        } else if (tickets.statusType == IndentityStatusTypeInvalid) {
            [weakSelf outLogininWithController:weakSelf];
        } else {
            [weakSelf showErrorWithTitle:tickets.desc];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf showErrorWithTitle:@"请求失败"];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}


- (void)handleTicketsWithTickets:(NSArray *)tickets {
    
    NSMutableArray *ticketsArray = [NSMutableArray arrayWithArray:tickets];
    
    NSMutableArray *currentTicketsArray = [[NSMutableArray alloc] init];
    NSMutableArray *newArrays = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < ticketsArray.count; i++) {
        Ticket *ticket = ticketsArray[i];
        BOOL isUsed = [self isUsedCardWithTicket:ticket];
        if (isUsed) {
            [newArrays addObject:ticket];
        } else {
            [currentTicketsArray addObject:ticket];
        }
    }
    [newArrays addObjectsFromArray:[currentTicketsArray copy]];
    self.tickets = [newArrays copy];
    [self.tableView reloadData];
}


- (BOOL)isUsedCardWithTicket:(Ticket *)ticket {
    BOOL flag = NO;
    if (!ticket.maxBorrowTime && ticket.minBorrowTime) {
        if ([self.period integerValue] >= ticket.minBorrowTime) {
            flag = YES;
        }
    } else if (!ticket.minBorrowTime && ticket.maxBorrowTime) {
        if ([self.period integerValue] <= ticket.maxBorrowTime) {
            flag = YES;
        }
    } else {
        if ([self.period integerValue] >= ticket.minBorrowTime && [self.period integerValue] <= ticket.maxBorrowTime) {
            flag = YES;
        }
    }
    
    BOOL isUsed = NO;
    if (ticket.name == 0) {
        if (self.type == 1 || self.money < ticket.investLimit) {
        } else {
            isUsed = YES;
        }
    } else if (ticket.name == 1) {
        if (self.money >= ticket.investLimit && flag) {
            isUsed = YES;
        }
    } else if (ticket.name == 2) {
        if (self.money >= ticket.investLimit && flag) {
            isUsed = YES;
        }
    }
    return isUsed;
}

#pragma mark - Setters && Getters

- (NSArray *)tickets {
    if (!_tickets) {
        _tickets = [[NSArray alloc] init];
    }
    return _tickets;
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
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FuliTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FuliTableViewCell class])];
    
    Ticket *ticket = self.tickets[indexPath.section];
    
    if (!ticket.maxBorrowTime && ticket.minBorrowTime) {
        cell.descContentLabel.text = [NSString stringWithFormat:@"限【%@天及以上项目】使用",@(ticket.minBorrowTime)];
    } else if (!ticket.minBorrowTime && ticket.maxBorrowTime) {
        cell.descContentLabel.text = [NSString stringWithFormat:@"限【%@天及以下项目】使用",@(ticket.maxBorrowTime)];
    } else {
        cell.descContentLabel.text =
        [NSString stringWithFormat:@"限【%@-%@天以内项目】使用",@(ticket.minBorrowTime), @(ticket.maxBorrowTime)];
    }
    
    BOOL flag = NO;
    if (!ticket.maxBorrowTime && ticket.minBorrowTime) {
        if ([self.period integerValue] >= ticket.minBorrowTime) {
            flag = YES;
        }
    } else if (!ticket.minBorrowTime && ticket.maxBorrowTime) {
        if ([self.period integerValue] <= ticket.maxBorrowTime) {
            flag = YES;
        }
    } else {
        if ([self.period integerValue] >= ticket.minBorrowTime && [self.period integerValue] <= ticket.maxBorrowTime) {
            flag = YES;
        }
    }
    
    if (ticket.name == 0) {
        //理财金
        cell.welfareLabel.text = [NSString stringWithFormat:@"￥%@",ticket.welfare];
        cell.nameLabel.text = @"理财金";
        cell.descContentLabel.text = @"限【新手专享】使用";
        
        if (self.type == 1 || self.money < ticket.investLimit) {
            //置灰
            cell.fuliImageView.image = [UIImage imageNamed:@"fuli_money_no_button_image"];
            cell.welfareLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
            [cell.selectedButton setImage:[UIImage imageNamed:@"fuli_no_button_image"]
                                 forState:UIControlStateNormal];
            cell.backImageView.image =
            ticket.type == 0 ? [UIImage imageNamed:@"fuli_bg_no_use_tag_image"] : [UIImage imageNamed:@"fuli_bg_no_tag_image"];
            
        } else {
            cell.fuliImageView.image = [UIImage imageNamed:@"fuli_money_button_image"];
            cell.welfareLabel.textColor = RGBColor(242.0f, 89.0f, 47.0f);
            [cell.selectedButton setImage:[UIImage imageNamed:@"fuli_unselected_button_image"]
                                 forState:UIControlStateNormal];
            cell.backImageView.image =
            ticket.type == 0 ? [UIImage imageNamed:@"fuli_bg_has_tag_image"] : [UIImage imageNamed:@"fuli_bg_no_tag_image"];
        }
        NSDictionary *dic = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:24.0f]
                              };
        [cell.welfareLabel addAttributes:dic
                                 forText:@"￥"];
        
    } else if (ticket.name == 1) {
        //加息卷
        cell.welfareLabel.text = [NSString stringWithFormat:@"%@%%",ticket.welfare];
        NSDictionary *dic = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:24.0f]
                              };
        [cell.welfareLabel addAttributes:dic
                                 forText:@"%"];
        cell.nameLabel.text = @"加息卷";
        
        if (self.money >= ticket.investLimit && flag) {
            cell.fuliImageView.image = [UIImage imageNamed:@"fuli_juan_button_image"];
            cell.welfareLabel.textColor = RGBColor(242.0f, 89.0f, 47.0f);
            [cell.selectedButton setImage:[UIImage imageNamed:@"fuli_unselected_button_image"]
                                 forState:UIControlStateNormal];
            cell.backImageView.image =
            ticket.type == 0 ? [UIImage imageNamed:@"fuli_bg_has_tag_image"] : [UIImage imageNamed:@"fuli_bg_no_tag_image"];
        } else {
            cell.fuliImageView.image = [UIImage imageNamed:@"fuli_juan_no_button_image"];
            cell.welfareLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
            [cell.selectedButton setImage:[UIImage imageNamed:@"fuli_no_button_image"]
                                 forState:UIControlStateNormal];
            cell.backImageView.image =
            ticket.type == 0 ? [UIImage imageNamed:@"fuli_bg_no_use_tag_image"] : [UIImage imageNamed:@"fuli_bg_no_tag_image"];
        }
        
    } else if (ticket.name == 2) {
        //红包
        cell.welfareLabel.text = [NSString stringWithFormat:@"￥%@",ticket.welfare];
        
        NSDictionary *dic = @{
                              NSFontAttributeName : [UIFont systemFontOfSize:24.0f]
                              };
        [cell.welfareLabel addAttributes:dic
                                 forText:@"￥"];
        cell.nameLabel.text = @"红包";
        
        if (self.money >= ticket.investLimit && flag) {
            cell.fuliImageView.image = [UIImage imageNamed:@"fuli_hongbao_button_image"];
            cell.welfareLabel.textColor = RGBColor(242.0f, 89.0f, 47.0f);
            [cell.selectedButton setImage:[UIImage imageNamed:@"fuli_unselected_button_image"]
                                 forState:UIControlStateNormal];
            cell.backImageView.image =
            ticket.type == 0 ? [UIImage imageNamed:@"fuli_bg_has_tag_image"] : [UIImage imageNamed:@"fuli_bg_no_tag_image"];
        } else {
            cell.fuliImageView.image = [UIImage imageNamed:@"fuli_hongbao_no_button_image"];
            cell.welfareLabel.textColor = RGBColor(153.0f, 153.0f, 153.0f);
            [cell.selectedButton setImage:[UIImage imageNamed:@"fuli_no_button_image"]
                                 forState:UIControlStateNormal];
            cell.backImageView.image =
            ticket.type == 0 ? [UIImage imageNamed:@"fuli_bg_no_use_tag_image"] : [UIImage imageNamed:@"fuli_bg_no_tag_image"];
        }
        
    }
    
    if (ticket.ticketId == self.ticket.ticketId && self.isCancelSelected == YES) {
        [cell.selectedButton setImage:[UIImage imageNamed:@"fuli_selected_button_image"]
                             forState:UIControlStateNormal];
    }
    cell.limitMoneyLabel.text = [NSString stringWithFormat:@"投资满%@元",@(ticket.investLimit)];
    NSString *dateTime =
    [[[NSString stringWithTimeInterval:[ticket.expireTime doubleValue] / 1000] componentsSeparatedByString:@" "] firstObject];
    cell.expireTimeLabel.text =
    [NSString stringWithFormat:@"%@过期",dateTime];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    Ticket *ticket = self.tickets[indexPath.section];
    BOOL isUsed = [self isUsedCardWithTicket:ticket];
    if (isUsed) {
        __weak typeof(self) weakSelf = self;
        if (self.selectBlock) {
            BOOL isCancelSelect = NO;
            if (ticket.ticketId == weakSelf.ticket.ticketId) {
                isCancelSelect = !self.isCancelSelected;
            } else {
                isCancelSelect = YES;
            }
            self.selectBlock(ticket, isCancelSelect);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Handlers

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
