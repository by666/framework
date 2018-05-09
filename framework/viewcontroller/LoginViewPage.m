//
//  LoginViewPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginViewPage.h"
#import "LoginView.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "STObserverManager.h"
#import "PhoneNumPage.h"
@interface LoginViewPage ()<LoginDelegate,STObserverProtocol>

@property(strong, nonatomic)LoginViewModel *mViewModel;
@property(strong, nonatomic)LoginView *mLoginView;

@end

@implementation LoginViewPage

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
    _mLoginView.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    _mLoginView.backgroundColor = c01;
    [self.view addSubview:_mLoginView];
}


-(void)OnSendVerifyCode:(Boolean)success msg:(NSString *)msg{
    [MBProgressHUD hideHUDForView:_mLoginView animated:YES];
    if(success){
        [_mLoginView updateView];
    }else{
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }
}


-(void)OnLogin:(Boolean)success msg:(NSString *)msg{
    [MBProgressHUD hideHUDForView:_mLoginView animated:YES];
    if(success){
        [_mLoginView updateView];
    }else{
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }
}

-(void)OnWechatLogin:(Boolean)success msg:(NSString *)msg{
    if(!success){
        [STAlertUtil showAlertController:@"提示" content:msg controller:self];
    }
}

-(void)OnTimeCount:(Boolean)complete{
    [_mLoginView updateVerifyBtn:complete];
}

-(void)OnReciveResult:(NSString *)key msg:(id)msg{
    if([Notify_WXLogin isEqualToString:key]){
        _mViewModel.loginModel.username = msg;
        PhoneNumPage *page = [[PhoneNumPage alloc]init];
        [self pushPage:page];
    }
}

@end
