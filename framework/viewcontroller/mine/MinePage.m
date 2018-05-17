//
//  MinePage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MinePage.h"
#import "MineViewModel.h"
#import "MineView.h"
#import "STNavigationView.h"
#import "ProfilePage.h"
#import "MemberPage.h"
#import "VictorPage.h"
#import "VictorHistoryPage.h"
#import "CarPage.h"
#import "CarHistoryPage.h"
#import "MessageSettingPage.h"
#import "HabitantPage.h"
#import "SettingPage.h"

@interface MinePage ()<MineViewDelegate>


@end

@implementation MinePage

+(void)show:(BaseViewController *)controller{
    MinePage *page = [[MinePage alloc]init];
    [controller pushPage:page];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:[UIColor clearColor]];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    MineViewModel *viewModel = [[MineViewModel alloc]init];
    viewModel.delegate = self;
    
    MineView *mineView = [[MineView alloc]initWithViewModel:viewModel];
    mineView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    mineView.backgroundColor = cwhite;
    [self.view addSubview:mineView];
}


-(void)onGoProfilePage{
    [ProfilePage show:self];
}

-(void)onGoMemberPage{
    [MemberPage show:self];
}

-(void)onGoVictorPage{
    [VictorPage show:self];
}

-(void)onGoVictorHistoryPage{
    [VictorHistoryPage show:self];
}

-(void)onGoCarPage{
    [CarPage show:self];
}

-(void)onGoCarHistoryPage{
    [CarHistoryPage show:self];
}

-(void)onGoMessageSettingPage{
    [MessageSettingPage show:self];
}

-(void)onGoAccountManagePage{
    [HabitantPage show:self];
}

-(void)onGoSettingPage{
    [SettingPage show:self];
}

@end
