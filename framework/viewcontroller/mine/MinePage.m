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
#import "VisitorHomePage.h"
#import "VisitorHistoryPage.h"
#import "CarPage.h"
#import "CarHistoryPage.h"
#import "MessageSettingPage.h"
#import "HabitantPage.h"
#import "SettingPage.h"
#import "STObserverManager.h"

@interface MinePage ()<MineViewDelegate,STObserverProtocol>

@property(strong, nonatomic)MineView *mineView;

@end

@implementation MinePage

+(void)show:(BaseViewController *)controller{
    MinePage *page = [[MinePage alloc]init];
    [controller pushPage:page];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:[UIColor clearColor]];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    MineViewModel *viewModel = [[MineViewModel alloc]init];
    viewModel.delegate = self;
    
    _mineView = [[MineView alloc]initWithViewModel:viewModel];
    _mineView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _mineView.backgroundColor = cwhite;
    [self.view addSubview:_mineView];
    
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_Update_User_Face delegate:self];
}


-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_Update_User_Face];
}


-(void)onGoProfilePage{
    [ProfilePage show:self];
}

-(void)onGoMemberPage{
    [MemberPage show:self];
}

-(void)onGoVictorPage{
    [VisitorHomePage show:self];
}

-(void)onGoVictorHistoryPage{
    [VisitorHistoryPage show:self];
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

-(void)onGoBack{
    [self backLastPage];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if(_mineView){
        [_mineView updateFace];
    }
}

@end
