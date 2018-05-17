//
//  PhoneNumPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BindPhonePage.h"
#import "BindPhoneViewModel.h"
#import "BindPhoneView.h"
#import "MainPage.h"

@interface BindPhonePage ()<PhoneDelegate>

@property(strong, nonatomic)BindPhoneViewModel *mViewModel;
@property(strong, nonatomic)BindPhoneView *mBindPhoneView;

@end

@implementation BindPhonePage


- (void)viewDidLoad {
    [super viewDidLoad];
    _mViewModel = [[BindPhoneViewModel alloc]init];
    _mViewModel.delegate = self;
    [self initView];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(void)initView{
    self.view.backgroundColor = cwhite;
    
    _mBindPhoneView = [[BindPhoneView alloc]initWithViewModel:_mViewModel title:MSG_WECHAT_TITLE];
    _mBindPhoneView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _mBindPhoneView.backgroundColor = cwhite;
    [self.view addSubview:_mBindPhoneView];
}

-(void)onBindPhone:(Boolean)success{
    [MBProgressHUD hideHUDForView:_mBindPhoneView animated:YES];
    [_mBindPhoneView updateView];
    if(success){
        [_mBindPhoneView updateView];
        [MainPage show:self];
    }
}

- (void)onSendVerifyCode:(Boolean)success {
    [_mBindPhoneView updateView];
}


- (void)onTimeCount:(Boolean)complete {
    [_mBindPhoneView updateVerifyBtn:complete];
}



@end
