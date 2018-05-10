//
//  BaseViewController.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//


@interface BaseViewController : UIViewController

//隐藏导航栏
-(void)hideNavigationBar : (Boolean) hidden;

//设置状态栏背景色
-(void)setStatuBarBackgroud : (UIColor *)color;

//push viewcontroller
-(void)pushPage : (BaseViewController *)targetPage;

-(void)backLastPage;

@end
