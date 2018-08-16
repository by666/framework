//
//  BaseViewController.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"
#import "STObserverManager.h"
#import "NextLoginPage.h"
#import "PageManager.h"
#import "BaseNoNetView.h"
@interface BaseViewController ()<STNavigationViewDelegate,STObserverProtocol>

@property(copy,nonatomic)void(^onRightBtnClick)(void);

@end

@implementation BaseViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self hideNavigationBar:YES];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_AUTHFAIL delegate:self];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_AUTHFAIL];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    NSLog(@"跳转到登录");
    [[PageManager sharedPageManager]popToLoginPage:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [[PageManager sharedPageManager] pageAppear:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[PageManager sharedPageManager] pageDisappear:self];
}

-(void)hideNavigationBar : (Boolean) hidden{
    self.navigationController.navigationBarHidden = hidden;
}


-(void)setStatuBarBackgroud : (UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


-(void)pushPage:(BaseViewController *)targetPage{
    [self.navigationController pushViewController:targetPage animated:YES];
}

-(void)backLastPage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback{
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr block:(void (^)(void))click{
    _onRightBtnClick = click;
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback rightBtn:rightStr];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr rightColor:(UIColor *)color block:(void (^)(void))click{
    _onRightBtnClick = click;
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback rightBtn:rightStr rightColor:color];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)OnBackBtnClicked{
    [self backLastPage];
}

-(void)onRightBtnClicked{
    _onRightBtnClick();
}




@end
