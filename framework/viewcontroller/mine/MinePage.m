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
#import "AccountManager.h"
#import "AuthStatuPage.h"

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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
    if([self hasLiveInfo]){
        [MemberPage show:self];
    }else{
        [AuthStatuPage show:self];
    }
}

-(void)onGoVictorPage{
    if([self hasLiveInfo]){
        [VisitorHomePage show:self];
    }else{
        [AuthStatuPage show:self];
    }
}

-(void)onGoVictorHistoryPage{
    if([self hasLiveInfo]){
        [VisitorHistoryPage show:self];
    }else{
        [AuthStatuPage show:self];
    }
}

-(void)onGoCarPage{
    if([self hasLiveInfo]){
        [CarPage show:self];
    }else{
        [AuthStatuPage show:self];
    }
}

-(void)onGoCarHistoryPage{
    if([self hasLiveInfo]){
        [CarHistoryPage show:self];
    }else{
        [AuthStatuPage show:self];
    }
}

-(void)onGoMessageSettingPage{
    if([self hasLiveInfo]){
        [MessageSettingPage show:self];
    }else{
        [AuthStatuPage show:self];
    }
}

-(void)onGoAccountManagePage{
    if([self hasLiveInfo]){
        [HabitantPage show:self];
    }else{
        [AuthStatuPage show:self];
    }
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


-(Boolean)hasLiveInfo{
    LiveModel *model = [[AccountManager sharedAccountManager] getLiveModel];
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    if(IS_NS_STRING_EMPTY(userModel.headUrl)){
        model.statu = STATU_NO;
    }
    return  (model.statu == STATU_YES);
}
@end
