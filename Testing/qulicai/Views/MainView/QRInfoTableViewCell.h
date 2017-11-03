//
//  QRInfoTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/8/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *safeButton;

@property (weak, nonatomic) IBOutlet UIButton *platformDataButton;

@property (weak, nonatomic) IBOutlet UIButton *qrInfoButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightTopConstraint;


@end
