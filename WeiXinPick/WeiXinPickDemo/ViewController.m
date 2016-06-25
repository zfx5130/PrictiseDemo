//
//  ViewController.m
//  WeiXinPickDemo
//
//  Created by chaos on 7/21/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import "ViewController.h"
#import "WeiXinPickView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    
}

- (void)show
{
    WeiXinPickView *pickView = [[WeiXinPickView alloc]init];
    [self.view addSubview:pickView];
    
    
    pickView.clickBlock = ^(UIImage *image, PickPictureEvent event){
        switch (event) {
            case PickPictureSendPicture: {
                NSLog(@"++++++=%@",image);
            }
                break;
            case PickPictureTakePhoto:
                NSLog(@"拍摄!");
                break;
            case PickPictureChoosePicture:
                NSLog(@"从相册选择!");
                break;
            case PickPictureCancel:
                NSLog(@"取消!");
                break;
            default:
                break;
        }
    };
    
    [pickView presentBlock:^(BOOL Complete) {
        NSLog(@"弹出来了!");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
