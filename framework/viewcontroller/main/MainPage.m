//
//  MainPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainPage.h"
#import "MainViewModel.h"
#import "MainView.h"
#import "STNavigationView.h"
#import "MinePage.h"
#import "AuthUserPage.h"

@interface MainPage ()<MainViewDelegate>

@property(strong, nonatomic)MainViewModel *mViewModel;
@property(strong, nonatomic)MainView *mMainView;
@property(strong, nonatomic)STNavigationView *mNavigationView;

@end

@implementation MainPage

+(void)show:(BaseViewController *)controller{
    MainPage *page = [[MainPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatuBarBackgroud:cwhite];
    _mViewModel = [[MainViewModel alloc]init];
    _mViewModel.delegate = self;
    [self initView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(void)initView{
    
    _mNavigationView = [[STNavigationView alloc]initWithTitle:@"首页" needBack:NO];
    [self.view addSubview:_mNavigationView];
    
    _mMainView = [[MainView alloc]initWithViewModel:_mViewModel];
    _mMainView.frame = CGRectMake(0, StatuBarHeight+NavigationBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight-NavigationBarHeight);
    _mMainView.backgroundColor = c01;
    [self.view addSubview:_mMainView];
    
    WS(weakSelf)
    [STAlertUtil showAlertController:@"" content:@"请先认证身份信息" controller:self confirm:^{
        [AuthUserPage show:weakSelf];
    }];
}

-(void)onGoMinePage{
    [MinePage show:self];
}

@end
