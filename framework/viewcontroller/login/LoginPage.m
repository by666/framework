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
@property(assign, nonatomic)Boolean needBack;
@end

@implementation LoginPage

+(void)show:(BaseViewController *)controller needBack:(Boolean)needBack{
    LoginPage *page = [[LoginPage alloc]init];
    page.needBack = needBack;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mViewModel = [[LoginViewModel alloc]init];
    _mViewModel.delegate = self;
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_WXLogin delegate:self];
    [STColorUtil setGradientColor:self.view startColor:c01 endColor:c02 director:Top];
    [self initView];
}



-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:[UIColor clearColor]];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_WXLogin];
}


-(void)initView{
    _mLoginView = [[LoginView alloc]initWithViewModel:_mViewModel controller:self needBack:_needBack];
    _mLoginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:_mLoginView];

}


-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mLoginView updateView];
    if([respondModel.requestUrl isEqualToString:URL_GETVERIFYCODE]){
        NSString *phoneNum = data;
        [_mViewModel getTestCode:phoneNum];
    }else if([respondModel.requestUrl isEqualToString:URL_LOGIN]){
         [MainPage show:self];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mLoginView updateView];
}


////////测试验证码代码
-(void)onGetTestCode:(NSString *)code{
    [_mLoginView blankCode:code];
}


////////
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
