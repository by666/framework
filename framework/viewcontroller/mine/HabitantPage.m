//
//  HabitantPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "HabitantPage.h"
#import "HabitantView.h"
#import "HabitantViewModel.h"
#import "UserInfoPage.h"
#import "BaseNoNetView.h"
#import "STNetUtil.h"
#import "STObserverManager.h"

@interface HabitantPage ()<HabitantViewDelegate,STObserverProtocol>

@property(strong, nonatomic)HabitantView *habitantView;
@property(strong, nonatomic)HabitantViewModel *viewModel;
@property(strong, nonatomic)BaseNoNetView *noNetView;

@end

@implementation HabitantPage

+(void)show:(BaseViewController *)controller{
    HabitantPage *page = [[HabitantPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c15;
    [self showSTNavigationBar:MSG_HABITANT_TITLE needback:YES];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_UpdateHabitant delegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_UpdateHabitant];
}

-(void)initView{
    _viewModel = [[HabitantViewModel alloc]initWithController:self];
    _viewModel.delegate = self;
    _habitantView = [[HabitantView alloc]initWithViewModel:_viewModel];
    _habitantView.backgroundColor = c15;
    _habitantView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_habitantView];
    
    if([STNetUtil isNetAvailable]){
        _habitantView.hidden = NO;
        [_viewModel requestDatas];

    }else{
        _habitantView.hidden = YES;
        WS(weakSelf)
        _noNetView = [[BaseNoNetView alloc]initWithBlock:^{
            if(weakSelf.viewModel){
                [weakSelf.viewModel requestDatas];
            }
        }];
        [self.view addSubview:_noNetView];
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
    [STToastUtil showFailureAlertSheet:msg];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    _habitantView.hidden = NO;
    _noNetView.hidden = YES;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if(_habitantView){
        [_habitantView updateView];
    }
}

-(void)onGoUserInfoPage:(HabitantModel *)model{
    [UserInfoPage show:self model:model];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    if(_viewModel){
        [_viewModel requestDatas];
    }
}

@end
