//
//  LoginView.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginView.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface LoginView()

@property(strong, nonatomic) LoginViewModel *mViewModel;

@property(strong, nonatomic) UITextField *phoneNumTF;
@property(strong, nonatomic) UITextField *verifyCodeTF;
@property(strong, nonatomic) UIButton *sendVerifyCodeBtn;
@property(strong, nonatomic) UIButton *loginBtn;
@property(strong, nonatomic) UIButton *wechatLoginBtn;
@property(strong, nonatomic) UILabel *titleLabel;

@end

@implementation LoginView

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLabel = [[UILabel alloc]initWithFont:STFont(36) text:_mViewModel.loginModel.username textAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] multiLine:NO];
    [self addSubview:_titleLabel];
    
    _phoneNumTF = [[UITextField alloc]initWithFont:STFont(36) textColor:[UIColor redColor] backgroundColor:[UIColor whiteColor] corner:STHeight(10) borderWidth:STWidth(2) borderColor:[UIColor redColor] padding:STWidth(20)];
    [self addSubview:_phoneNumTF];
    
    _verifyCodeTF =  [[UITextField alloc]initWithFont:STFont(36) textColor:[UIColor redColor] backgroundColor:[UIColor whiteColor] corner:STHeight(10) borderWidth:STWidth(2) borderColor:[UIColor redColor] padding:STWidth(20)];
    [self addSubview:_verifyCodeTF];
    
    _sendVerifyCodeBtn =  [[UIButton alloc]initWithFont:STFont(36) text:_mViewModel.loginModel.verifyStr textColor:[UIColor blueColor] backgroundColor:[UIColor cyanColor] corner:STHeight(10) borderWidth:STWidth(2) borderColor:[UIColor blueColor]];
    [self addSubview:_sendVerifyCodeBtn];
    [_sendVerifyCodeBtn addTarget:self action:@selector(doSendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    _wechatLoginBtn =  [[UIButton alloc]initWithFont:STFont(36) text:@"微信登录" textColor:[UIColor blueColor] backgroundColor:[UIColor cyanColor] corner:STHeight(10) borderWidth:STWidth(2) borderColor:[UIColor blueColor]];
    [self addSubview:_wechatLoginBtn];
    [_wechatLoginBtn addTarget:self action:@selector(doWechatLogin) forControlEvents:UIControlEventTouchUpInside];


    _loginBtn = [[UIButton alloc]initWithFont:STFont(36) text:@"登录" textColor:[UIColor blueColor] backgroundColor:[UIColor cyanColor] corner:STHeight(10) borderWidth:STWidth(2) borderColor:[UIColor blueColor]];
    [self addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self initFrame];
  
}


-(void)initFrame{
    
    __weak LoginView *weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(STHeight(80));
        make.top.mas_equalTo(0);

    }];
    
    [_phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth - STWidth(80));
        make.height.mas_equalTo(STHeight(80));
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(STHeight(30));
        make.left.mas_equalTo(STWidth(40));
    }];
    
    [_verifyCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth - STWidth(80));
        make.height.mas_equalTo(STHeight(80));
        make.top.mas_equalTo(weakSelf.phoneNumTF.mas_bottom).mas_offset(STHeight(30));
        make.left.mas_equalTo(STWidth(40));
    }];
    
    [_sendVerifyCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth - STWidth(80));
        make.height.mas_equalTo(STHeight(100));
        make.left.mas_equalTo(STWidth(40));
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-STHeight(320));
    }];
    
    [_wechatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth - STWidth(80));
        make.height.mas_equalTo(STHeight(100));
        make.left.mas_equalTo(STWidth(40));
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-STHeight(200));
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth - STWidth(80));
        make.height.mas_equalTo(STHeight(100));
        make.left.mas_equalTo(STWidth(40));
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-STHeight(80));
    }];
}

-(void)doSendVerifyCode{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    if(_mViewModel){
        [_mViewModel sendVerifyCode:_phoneNumTF.text];
    }
}

-(void)doWechatLogin{
    if(_mViewModel){
        [_mViewModel doWechatLogin];
    }
}

-(void)doLogin{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    if(_mViewModel){
        [_mViewModel doLogin:_phoneNumTF.text verifyCode:_verifyCodeTF.text];
    }
}

-(void)updateView{
    _titleLabel.text = _mViewModel.loginModel.username;
}

-(void)updateVerifyBtn:(Boolean)complete{
    [_sendVerifyCodeBtn setTitle:_mViewModel.loginModel.verifyStr forState:UIControlStateNormal];
    if(complete){
        [_sendVerifyCodeBtn setEnabled:YES];
        [_sendVerifyCodeBtn setBackgroundColor:[UIColor cyanColor]];
    }else{
        [_sendVerifyCodeBtn setEnabled:NO];
        [_sendVerifyCodeBtn setBackgroundColor:[UIColor grayColor]];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumTF resignFirstResponder];
    [_verifyCodeTF resignFirstResponder];
}

@end
