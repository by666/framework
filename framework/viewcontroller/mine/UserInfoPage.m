//
//  UserInfoPage.m
//  framework
//
//  Created by 黄成实 on 2018/8/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UserInfoPage.h"
#import "UserInfoView.h"
#import "STObserverManager.h"

@interface UserInfoPage ()<UserInfoViewDelegate>

@property(strong, nonatomic)HabitantModel *model;
@property(strong, nonatomic)UserInfoView *userInfoView;

@end

@implementation UserInfoPage


+(void)show:(BaseViewController *)controller model:(HabitantModel *)model{
    UserInfoPage *page = [[UserInfoPage alloc]init];
    page.model = model;
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_USERINFO_TITLE needback:YES];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initView{
    UserInfoViewModel *viewModel = [[UserInfoViewModel alloc]initWithModel:_model];
    viewModel.delegate = self;
    _userInfoView = [[UserInfoView alloc]initWithViewModel:viewModel];
    _userInfoView.backgroundColor = c15;
    _userInfoView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_userInfoView];
}


-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showSuccessTips:MSG_UPDATE_SUCCESS];
    [[STObserverManager sharedSTObserverManager] sendMessage:Notify_UpdateHabitant msg:nil];
    [self backLastPage];
}
@end
