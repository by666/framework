//
//  LoginViewPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginPage.h"
#import "LoginView.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "STObserverManager.h"
#import "BindPhonePage.h"
#import "FaceLoginPage.h"
@interface LoginPage ()<LoginDelegate,STObserverProtocol>

@property(strong, nonatomic)LoginViewModel *mViewModel;
@property(strong, nonatomic)LoginView *mLoginView;

@end

@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _mViewModel = [[LoginViewModel alloc]init];
    _mViewModel.delegate = self;
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_WXLogin delegate:self];
    [self initView];
}


-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_WXLogin];
}


-(void)initView{
    _mLoginView = [[LoginView alloc]initWithViewModel:_mViewModel];
    _mLoginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatuBarHeight);
    _mLoginView.backgroundColor = c01;
    [self.view addSubview:_mLoginView];
}

-(void)onSendVerifyCode:(Boolean)success msg:(NSString *)msg{
    [MBProgressHUD hideHUDForView:_mLoginView animated:YES];
    if(success){
        [_mLoginView updateView];
    }else{
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }
}


- (void)onLogin:(Boolean)success msg:(NSString *)msg{
    [MBProgressHUD hideHUDForView:_mLoginView animated:YES];
    if(success){
        [_mLoginView updateView];
    }else{
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }
}

-(void)onWechatLogin:(Boolean)success msg:(NSString *)msg{
    if(!success){
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }
}

-(void)onFaceLogin{
    FaceLoginPage *page = [[FaceLoginPage alloc]init];
    [self pushPage:page];
}

- (void)onTimeCount:(Boolean)complete{
    [_mLoginView updateVerifyBtn:complete];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([Notify_WXLogin isEqualToString:key]){
        _mViewModel.loginModel.username = msg;
        BindPhonePage *page = [[BindPhonePage alloc]init];
        [self pushPage:page];
    }
}

@end
