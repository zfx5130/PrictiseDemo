//
//  UIViewController+Addition.m
//  MMKB
//
//  Created by yangkun on 8/12/14.
//  Copyright (c) 2014 yangkun. All rights reserved.
//

#import "UIViewController+Addition.h"
#import "LoginViewController.h"
#import "UIButton+Addition.h"
#import "UserUtil.h"

@implementation UIViewController (Addition)

-(void)setupNavigationItemLeftTitle:(NSString *)title {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacer setWidth:-10];
    
    CGSize labelSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGRect labelFrame = [title boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(0, 0, labelFrame.size.width, 44.0f) title:title font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
    [button addTarget:self action:@selector(leftBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spacer, leftBarButton, nil];
}

-(void)setupNavigationItemRightTitle:(NSString *)title
                               color:(UIColor *)textColor {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacer setWidth:5];
    
    CGSize labelSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGRect labelFrame = [title boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(0, 0, labelFrame.size.width, 44.0f) title:title font:[UIFont systemFontOfSize:15] color:textColor];
    [button addTarget:self action:@selector(rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:spacer, rightBarButton, nil];
}


-(void)setupNavigationItemLeft:(UIImage *)image {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacer setWidth:-4];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image
            forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(leftBarButtonAction)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(-20, 0, image.size.width + 50, image.size.height + 50);
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -35.0, 0.0f, 0.0f);
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spacer, leftBarButton, nil];
}

-(void)setupNavigationItemRight:(UIImage *)image {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacer setWidth:-4];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:spacer, rightBarButton, nil];
}

-(void)setupNavigationItemRights:(NSArray *)images {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacer setWidth:-4];
    
    NSMutableArray *rightBarButtonItems = [NSMutableArray arrayWithObjects:spacer, nil];
    for( int i=0; i<[images count]; i++ ) {
        UIImage *image = [UIImage imageNamed:[images objectAtIndex:i]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        
        NSString *selectorStr = [NSString stringWithFormat:@"rightBarButtonAction%d",i];
        SEL selector = NSSelectorFromString(selectorStr);
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        [rightBarButtonItems addObject:rightBarButton];
    }
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithArray:rightBarButtonItems];
}

-(void)leftBarButtonAction {
    
}

-(void)rightBarButtonAction {
    
}

- (void)saveToken:(NSString *)token {
    if ([NSString isEmpty:token]) {
        return;
    }
    NSLog(@"token:::::::::::%@",token);
    [[A0SimpleKeychain keychain] setString:token
                                    forKey:QR_CURRENT_TOKEN];
}

- (void)outLogininWithController:(UIViewController *)controller {
    if ([UserUtil outLoginIn]) {
        [controller showErrorWithTitle:@"请求失效"];
        PostNotification(QR_OUTLOGIN_UPDATE_HEAD_VIEW_STAUTS);
        [self login];
    }
}

- (void)login {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [loginViewController wr_setStatusBarStyle:UIStatusBarStyleLightContent];
   // [navigationController setNavigationBarHidden:YES animated:YES];
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
}

@end
