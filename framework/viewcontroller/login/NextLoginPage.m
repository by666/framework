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
@interface NextLoginPage ()<NextLoginDelegate>

@end

@implementation NextLoginPage

+(void)show:(BaseViewController *)controller{
    NextLoginPage *page = [[NextLoginPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:[UIColor clearColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(void)initView{
    
    self.view.backgroundColor = cwhite;
    
    NextLoginViewModel *viewModel = [[NextLoginViewModel alloc]init];
    viewModel.delegate = self;
    NextLoginView *nextLoginView = [[NextLoginView alloc]initWithViewModel:viewModel];
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
        
    };
    [datas addObject:wechatModel];
    
    
    [STAlertUtil showSheetController:@"" content:MSG_OTHER_LOGIN controller:self sheetModels:datas];
}



@end
