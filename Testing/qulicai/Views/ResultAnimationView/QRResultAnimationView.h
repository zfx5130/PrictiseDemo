//
//  QRResultAnimationView.h
//  qulicai
//
//  Created by admin on 2017/9/21.
//  Copyright © 2017年 qurong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShowResultTypeSuccess = 0,
    ShowResultTypeFail
} ShowResultType;

@interface QRResultAnimationView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                   resultType:(ShowResultType)resultType;


@end
