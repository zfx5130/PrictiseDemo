//
//  CustomerViewController.m
//  qulicai
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation CustomerViewController

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

#pragma mark - Priavte

- (void)setupViews {
    [self setupNavigationItemLeft:[UIImage imageNamed:@"forget_back_image"]];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return !section ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView
                       cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [super tableView:tableView
              heightForRowAtIndexPath:indexPath];
    return height;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                }
                    break;
                case 1: {
                    [self callPhone];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: {
        }
            break;
        default:
            break;
    }
}

#pragma mark - Hanlders

- (void)callPhone {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneLabel.text]]];
}

- (void)leftBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
