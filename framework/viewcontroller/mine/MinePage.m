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
#import "AuthUserPage.h"
#import "DeviceSharePage.h"
#import "ReportFixPage.h"
#import "AboutPage.h"
#import "LoginPage.h"
#import "PageManager.h"

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

-(void)onGoReportFixPage{
    [ReportFixPage show:self];
}

-(void)onGoDeviceSharePage{
    [DeviceSharePage show:self];
}

-(void)onGoAboutPage{
    [AboutPage show:self];
}

-(void)onOpenCheckInfoAlert{
    WS(weakSelf)
    [STAlertUtil showAlertController:@"" content:MSG_MAIN_CHECKIN controller:self confirm:^{
        [AuthUserPage show:weakSelf];
    }];
}

-(void)onGoAuthStatuPage{
    [AuthStatuPage show:self];
}

-(void)onShowAuthFailDialog{
    WS(weakSelf)
    [STAlertUtil showAlertController:@"" content:MSG_MESSAGE_AUTH_FAIL_CONTENT controller:self confirm:^{
        [AuthUserPage show:weakSelf];
    } cancel:^{
        
    } confirmStr:MSG_REAUTH cancelStr:MSG_CANCEL];
}


-(void)onGoBack{
    [self backLastPage];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if(_mineView){
        [_mineView updateFace];
    }
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
    [[PageManager sharedPageManager] popToLoginPage:self];
}



@end
