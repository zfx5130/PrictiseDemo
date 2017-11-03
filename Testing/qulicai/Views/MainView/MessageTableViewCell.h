//
//  MessageTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *messageTagImageView;

@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageDateLabel;

- (void)renderUiiWithStatus:(BOOL)status;

@end
