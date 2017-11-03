//
//  InputTextView1.h
//  模仿优酷的文本输入框
//
//  Created by     songguolin on 16/2/16.
//  Copyright © 2016年 SYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InputTextView1;
@protocol InputTextView1Delgate <NSObject>

-(void)finishedInput1:(InputTextView1 *)InputTextView1;

@end
/**
 * 这是创建一个view
 */
@interface InputTextView1 : UIView <UITextFieldDelegate>
@property (nonatomic,weak) id<InputTextView1Delgate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UILabel *descPeriodDayLabel;

@property (copy, nonatomic) NSString *periodDay;

@property (assign, nonatomic) CGFloat rate;

+(instancetype)creatInputTextView1;

-(void)show;


@end



