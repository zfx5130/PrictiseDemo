//
//  FinanceCarouselTableViewCell.h
//  qulicai
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FinanceCarouselTableViewCellDelegate <NSObject>

- (void)carouselImageDidSelectItemAtIndex:(NSInteger)index;

@end

@interface FinanceCarouselTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containView;

@property (weak, nonatomic) id <FinanceCarouselTableViewCellDelegate> delegate;

- (void)renderDataWithBannerArray:(NSArray *)arrays;

@end
