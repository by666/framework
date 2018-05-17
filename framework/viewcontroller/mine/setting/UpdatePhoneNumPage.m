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
        BindPhoneViewModel *viewModel = [[BindPhoneViewModel alloc]init];
        viewModel.delegate = self;
        _bindPhoneView = [[BindPhoneView alloc]initWithViewModel:viewModel title:MSG_UPDATEPHONENUM_TIPS3];
        _bindPhoneView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
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
