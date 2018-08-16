//
//  PhoneNumPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BindPhonePage.h"
#import "BindPhoneView.h"
#import "MainPage.h"

@interface BindPhonePage ()<LoginDelegate>

@property(strong, nonatomic)LoginViewModel *mViewModel;
@property(strong, nonatomic)BindPhoneView *mBindPhoneView;
@property(strong, nonatomic)NSString *wxToken;

@end

@implementation BindPhonePage


+(void)show:(BaseViewController *)controller wxToken:(NSString *)wxToken viewModel:(LoginViewModel *)viewModel{
    BindPhonePage *page = [[BindPhonePage alloc]init];
    page.wxToken = wxToken;
    page.mViewModel = viewModel;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:[UIColor clearColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(void)initView{
    self.view.backgroundColor = cwhite;
    
    _mViewModel.delegate = self;
    _mBindPhoneView = [[BindPhoneView alloc]initWithViewModel:_mViewModel title:MSG_WECHAT_TITLE wxToken:_wxToken];
    _mBindPhoneView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _mBindPhoneView.backgroundColor = cwhite;
    [self.view addSubview:_mBindPhoneView];
}



- (void)onTimeCount:(Boolean)complete {
    [_mBindPhoneView updateVerifyBtn:complete];
}

-(void)onRequestBegin{
    WS(weakSelf)
    dispatch_main_async_safe(^{
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
    });
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mBindPhoneView updateView];
    if([respondModel.requestUrl isEqualToString:URL_GETVERIFYCODE]){
        NSString *phoneNum = data;
        [_mViewModel getTestCode:phoneNum];
    }else if([respondModel.requestUrl isEqualToString:URL_LOGIN]){
        [MainPage show:self];
    }
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mBindPhoneView updateView];
}


////////测试验证码代码
-(void)onGetTestCode:(NSString *)code{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_mBindPhoneView blankCode:code];
}



@end
