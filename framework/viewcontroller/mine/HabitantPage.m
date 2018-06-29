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

@interface HabitantPage ()<HabitantViewDelegate>

@property(strong, nonatomic)HabitantView *habitantView;
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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    HabitantViewModel *viewModel = [[HabitantViewModel alloc]initWithController:self];
    viewModel.delegate = self;
    _habitantView = [[HabitantView alloc]initWithViewModel:viewModel];
    _habitantView.backgroundColor = c15;
    _habitantView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_habitantView];
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
    if(_habitantView){
        [_habitantView updateView];
    }
}

@end
