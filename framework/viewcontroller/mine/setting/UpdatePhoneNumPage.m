//
//  UpdatePhoneNumPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UpdatePhoneNumPage.h"
#import "UpdatePhoneNumView.h"
#import "BindPhoneView.h"
#import "BindPhoneViewModel.h"
#import "AccountManager.h"


@interface UpdatePhoneNumPage ()<UpdatePhoneNumViewDelegate,PhoneDelegate>

@property(strong, nonatomic) UpdatePhoneNumView *updatePhoneNumView;
@property(strong, nonatomic) BindPhoneView *bindPhoneView;

@end

@implementation UpdatePhoneNumPage

+(void)show:(BaseViewController *)controller{
    UpdatePhoneNumPage *page = [[UpdatePhoneNumPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_UPDATEPHONENUM_TITLE needback:YES];
    [self initView];
}

-(void)initView{
    [self.view addSubview:[self updatePhoneNumView]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:cwhite];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(UIView *)updatePhoneNumView{
    if(_updatePhoneNumView == nil){
        UpdatePhoneNumViewModel *viewModel = [[UpdatePhoneNumViewModel alloc]init];
        viewModel.delegate = self;
        _updatePhoneNumView = [[UpdatePhoneNumView alloc]initWithViewModel:viewModel];
        _updatePhoneNumView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    }
    return _updatePhoneNumView;
}

-(UIView *)bindPhoneView{
    if(_bindPhoneView == nil){
        UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
        BindPhoneViewModel *viewModel = [[BindPhoneViewModel alloc]init];
        viewModel.delegate = self;
        _bindPhoneView = [[BindPhoneView alloc]initWithViewModel:viewModel title:[NSString stringWithFormat:MSG_UPDATEPHONENUM_TIPS3,[STPUtil getSecretPhoneNum:userModel.phoneNum]]];
        _bindPhoneView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    }
    return _bindPhoneView;
}

-(void)onCheckVerifyCode:(Boolean)success{
    [_updatePhoneNumView removeFromSuperview];
    [self.view addSubview:[self bindPhoneView]];
    
}

-(void)onSendUpdateVerifyCode:(Boolean)success{
    
}

-(void)onBindPhone:(Boolean)success{
    [MBProgressHUD hideHUDForView:_bindPhoneView animated:YES];
    [_bindPhoneView updateView];
    if(success){
        [_bindPhoneView updateView];
        [self backLastPage];
    }
}

- (void)onSendVerifyCode:(Boolean)success {
    [_bindPhoneView updateView];
}


- (void)onTimeCount:(Boolean)complete {
    [_bindPhoneView updateVerifyBtn:complete];
}



@end
