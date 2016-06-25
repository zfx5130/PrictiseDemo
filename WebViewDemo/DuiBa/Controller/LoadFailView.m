//
//  LoadFailView.m
//  DuiBa
//
//  Created by czy on 16/4/19.
//  Copyright © 2016年 Caiziyi coporation. All rights reserved.
//

#import "LoadFailView.h"

@implementation LoadFailView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.defaultPic];
        [self addSubview:self.noNetBtn];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (UIImageView *)defaultPic {
    if (!_defaultPic) {
        UIImage *img = [UIImage imageNamed:@"noNetwork@2x"];
        self.defaultPic = [[UIImageView alloc] initWithFrame:CGRectMake((kMainScreenWidth-img.size.width)/2, (kMainScreenHeight-img.size.height*2)/2-45, img.size.width, img.size.height)];
        self.defaultPic.image = img;
        
    }
    return _defaultPic;
}
- (UIButton *)noNetBtn {
    
    if (!_noNetBtn) {
        self.noNetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat y = kMainScreenHeight/2+10;
        self.noNetBtn.frame = CGRectMake((kMainScreenWidth-120)/2, y, 120, 30);
        self.noNetBtn.backgroundColor = [UIColor whiteColor];
        [self.noNetBtn.layer setCornerRadius:6.0];
        self.noNetBtn.layer.borderWidth = 0.5f;
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 169.0/255.0f, 169/255.0f, 169/255.0f, 1 });
        [self.noNetBtn.layer setBorderColor:colorref];//边框颜色
        
        [self.noNetBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [self.noNetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.noNetBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        self.noNetBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return _noNetBtn;
}

@end
