//
//  UIViewController+Addition.h
//  MMKB
//
//  Created by yangkun on 8/12/14.
//  Copyright (c) 2014 yangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Addition)

-(void)setupNavigationItemLeftTitle:(NSString *)title;
-(void)setupNavigationItemRightTitle:(NSString *)title
                               color:(UIColor *)textColor;
-(void)setupNavigationItemLeft:(UIImage *)image;
-(void)setupNavigationItemRight:(UIImage *)image;
-(void)setupNavigationItemRights:(NSArray *)images;


-(void)leftBarButtonAction;
-(void)rightBarButtonAction;

- (void)saveToken:(NSString *)token;

- (void)outLogininWithController:(UIViewController *)controller;

- (void)login;

@end
