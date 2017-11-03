//
//  FinanceCarouselTableViewCell.m
//  qulicai
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import "FinanceCarouselTableViewCell.h"
#import "SDCycleScrollView.h"

@interface FinanceCarouselTableViewCell ()
<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation FinanceCarouselTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

- (void)renderDataWithBannerArray:(NSArray *)arrays {
    CGFloat height = 180.0f;
    if (IS_IPHONE_5) {
        height = IPHONE5_WIDTH * 180.0f / IPHONE6_WIDTH;
    }
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)
                                                              delegate:self
                                                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"fiscal_rotation_down_image"];
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"fiscal_rotation_up_image"];
    self.cycleScrollView.imageURLStringsGroup = arrays;
    [self.containView addSubview:self.cycleScrollView];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(carouselImageDidSelectItemAtIndex:)]) {
        [self.delegate carouselImageDidSelectItemAtIndex:index];
    }
}

@end
