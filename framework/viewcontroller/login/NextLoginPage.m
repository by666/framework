//
//  NextLoginPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "NextLoginPage.h"
#import "NextLoginView.h"
#import "NextLoginViewModel.h"
#import "LoginPage.h"
#import "FaceLoginPage.h"
#import "STObserverManager.h"
#import "MainPage.h"
#import "BindPhonePage.h"
@interface NextLoginPage ()<NextLoginDelegate,STObserverProtocol>

@property(strong, nonatomic)NextLoginViewModel *viewModel;
@end

@implementation NextLoginPage

+(void)show:(BaseViewController *)controller{
    NextLoginPage *page = [[NextLoginPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_WXLogin delegate:self];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:[UIColor clearColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_WXLogin];
}

-(void)initView{
    
    self.view.backgroundColor = cwhite;
    
    _viewModel = [[NextLoginViewModel alloc]init];
    _viewModel.delegate = self;
    NextLoginView *nextLoginView = [[NextLoginView alloc]initWithViewModel:_viewModel];
    nextLoginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:nextLoginView];
    
}

-(void)onGoFaceLoginPage{
    [FaceLoginPage show:self];
}

-(void)onGoLoginPage{
    WS(weakSelf)

    NSMutableArray *datas  =[[NSMutableArray alloc]init];

    //手机号登录
    STSheetModel *phoneModel = [[STSheetModel alloc]init];
    phoneModel.title = MSG_PHONE_LOGIN;
    phoneModel.click = ^{
        [LoginPage show:weakSelf needBack:YES];
    };
    [datas addObject:phoneModel];
    
    //微信登录
    STSheetModel *wechatModel = [[STSheetModel alloc]init];
    wechatModel.title = MSG_WECHAT_LOGIN;
    wechatModel.click = ^{
        [weakSelf.viewModel doWechatLogin];
    };
    [datas addObject:wechatModel];
    
    
    [STAlertUtil showSheetController:@"" content:MSG_OTHER_LOGIN controller:self sheetModels:datas];
}




-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if([respondModel.requestUrl isEqualToString:URL_LOGIN]){
        [MainPage show:self];
    }else if([respondModel.requestUrl isEqualToString:URL_WX_LOGIN]){
        if([data isEqualToString:MSG_SUCCESS]){
            [MainPage show:self];
        }else{
            [BindPhonePage show:self wxToken:data];
        }
    }
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if([Notify_WXLogin isEqualToString:key]){
        [_viewModel requestWechatLogin:msg];
    }
}
@end
