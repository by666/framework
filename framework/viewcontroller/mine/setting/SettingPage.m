//
//  SettingPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SettingPage.h"
#import "SettingView.h"
#import "UpdatePhoneNumPage.h"
#import "AboutPage.h"
#import "LoginPage.h"

@interface SettingPage ()<SettingViewDelegate>

@end

@implementation SettingPage

+(void)show:(BaseViewController *)controller{
    SettingPage *page = [[SettingPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_SETTING_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initView{
    SettingViewModel *viewModel = [[SettingViewModel alloc]init];
    viewModel.delegate = self;
    SettingView *settingView = [[SettingView alloc]initWithViewModel:viewModel];
    settingView.frame = CGRectMake(0, StatuBarHeight+NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:settingView];
}


-(void)onGoUpdatePhoneNumPage{
    [UpdatePhoneNumPage show:self];
}

-(void)onGoAboutPage{
    [AboutPage show:self];
}

-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [LoginPage show:self needBack:NO];
}


@end
