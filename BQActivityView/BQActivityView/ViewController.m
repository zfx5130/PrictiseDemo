//
//  ViewController.m
//  BQActivityView
//
//  Created by MAC on 16/12/16.
//  Copyright © 2016年 MrBai. All rights reserved.
//

#import "ViewController.h"
#import "BQActivityView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)startActivity:(UIButton *)sender {
    [BQActivityView showActiviTy];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [BQActivityView hideActiviTy];
    });
}



@end
