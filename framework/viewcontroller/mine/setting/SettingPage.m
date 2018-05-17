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
#import "NextLoginPage.h"

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
    [self setStatuBarBackgroud:cwhite];
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

-(void)onLogout:(Boolean)success{
    [NextLoginPage show:self];
}

@end
