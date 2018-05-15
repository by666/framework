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
#import "UserModel.h"
#import "AccountManager.h"
#import "MainPage.h"
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
    [self setStatuBarBackgroud:[UIColor clearColor]];
    [STColorUtil setGradientColor:self.view startColor:c01 endColor:c02 director:Top];
    [self initView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_WXLogin];
}


-(void)initView{
    _mLoginView = [[LoginView alloc]initWithViewModel:_mViewModel controller:self];
    _mLoginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_mLoginView];

}

-(void)onSendVerifyCode:(Boolean)success{
    [_mLoginView updateView];
}


- (void)onLogin:(Boolean)success{
    [_mLoginView updateView];
    if(success){
        [MainPage show:self];
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
        _mViewModel.loginModel.msgStr = msg;
        BindPhonePage *page = [[BindPhonePage alloc]init];
        [self pushPage:page];
    }
}

-(void)onGoback{
    if([[AccountManager sharedAccountManager] isLogin]){
        [self backLastPage];
    }else{
        [MainPage show:self];
    }
}
@end
