//
//  MassoryPage.m
//  framework
//
//  Created by 黄成实 on 2018/4/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MasonryPage.h"
#import <WXApi.h>
#import "STObserverManager.h"
#import "STNetUtil.h"
#import "STAlertUtil.h"
@interface MasonryPage ()<STObserverProtocol>

@property(strong,nonatomic)UILabel *phoneLabel;
@property(strong,nonatomic)UILabel *verifyLabel;
@property(strong,nonatomic)UILabel *loginLabel;
@property(strong,nonatomic)UITextField *phoneTF;
@property(strong,nonatomic)UITextField *verifyTF;
@property(strong,nonatomic)UIButton *loginBtn;
@property(strong,nonatomic)UIButton *wechatBtn;

@end

@implementation MasonryPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = c01;
    self.navigationItem.title = @"Massory";
    [[STObserverManager sharedSTObserverManager]registerSTObsever:Notify_WXLogin delegate:self];
    [self initView];
}

-(void)initView{
    _loginLabel = [[UILabel alloc]init];
    _loginLabel.text = @"登录";
    _loginLabel.font = [UIFont systemFontOfSize:18];
    _loginLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_loginLabel];
    
    [_loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(100));
    }];
    
    
    _phoneLabel = [[UILabel alloc]init];
    _phoneLabel.text = @"手机号：";
    _phoneLabel.font = [UIFont systemFontOfSize:16];
    _phoneLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_phoneLabel];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.equalTo(@(100));
        make.left.equalTo(@(20));
        make.width.equalTo(@(self.phoneLabel.contentSize.width));
        
    }];
    
    _phoneTF = [[UITextField alloc]init];
    _phoneTF.placeholder = @"请输入手机号";
    _phoneTF.textColor = [UIColor blackColor];
    _phoneTF.font = [UIFont systemFontOfSize:16];
    _phoneTF.layer.borderColor = [[UIColor blackColor] CGColor];
    _phoneTF.layer.borderWidth = 1;
    _phoneTF.layer.masksToBounds = YES;
    _phoneTF.layer.cornerRadius = 8;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    _phoneTF.leftView = view;
    _phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_phoneTF];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneLabel).offset(-10);
        make.bottom.mas_equalTo(self.phoneLabel).offset(10);
        make.right.mas_equalTo(self.view).offset(-20);
        make.leading.mas_equalTo(self.phoneLabel.mas_trailing);
    }];
    
    _verifyLabel = [[UILabel alloc]init];
    _verifyLabel.text = @"验证码：";
    _verifyLabel.font = [UIFont systemFontOfSize:16];
    _verifyLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_verifyLabel];
    
    [_verifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(40);
        make.left.mas_equalTo(self.phoneLabel.mas_left);
        make.width.mas_equalTo(self.phoneLabel);
    }];
    
    
    
    _verifyTF = [[UITextField alloc]init];
    _verifyTF.placeholder = @"请输入验证码";
    _verifyTF.textColor = [UIColor blackColor];
    _verifyTF.font = [UIFont systemFontOfSize:16];
    _verifyTF.layer.borderColor = [[UIColor blackColor] CGColor];
    _verifyTF.layer.borderWidth = 1;
    _verifyTF.layer.masksToBounds = YES;
    _verifyTF.layer.cornerRadius = 8;
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    _verifyTF.leftViewMode = UITextFieldViewModeAlways;
    _verifyTF.leftView = view2;
    _verifyTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_verifyTF];
    
    [_verifyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyLabel).offset(-10);
        make.bottom.mas_equalTo(self.verifyLabel).offset(10);
        make.right.mas_equalTo(self.view).offset(-20);
        make.leading.mas_equalTo(self.verifyLabel.mas_trailing);
    }];
    
    _loginBtn = [[UIButton alloc]init];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.backgroundColor = [STColorUtil colorWithHexString:@"#63B8FF"];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 24;
    [self.view addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verifyTF.mas_bottom).offset(40);
        make.left.mas_equalTo(self.verifyLabel.mas_left);
        make.right.mas_equalTo(self.verifyTF.mas_right);
        make.height.equalTo(@(48));
    }];
    
    
    _wechatBtn= [[UIButton alloc]init];
    [_wechatBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    _wechatBtn.backgroundColor = [STColorUtil colorWithHexString:@"63B8FF"];
    _wechatBtn.layer.masksToBounds = YES;
    _wechatBtn.layer.cornerRadius = 24;
    [_wechatBtn addTarget:self action:@selector(doWechatLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wechatBtn];
    
    [_wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(40);
        make.left.mas_equalTo(self.loginBtn.mas_left);
        make.right.mas_equalTo(self.loginBtn.mas_right);
        make.height.equalTo(@(48));
    }];
}


-(void)doLogin{
    NSString *phoneNum = _phoneTF.text;
    NSString *verifyCode   =_verifyTF.text;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"phonenum"]= phoneNum;
    dic[@"verifyCode"] = verifyCode;
    dispatch_async(dispatch_get_main_queue(), ^{
        [STNetUtil get:@"http://192.168.0.115:9000/login" parameters:dic success:^(RespondModel *respondModel) {
            if(respondModel.code == 200){
                id result = respondModel.result;
            }
        } failure:^(NSError *error) {
            
        }
         ];
    });
  
}

-(void)doWechatLogin{
    if([WXApi isWXAppInstalled]){
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req];
    }else{
        [STLog print:@"请先安装微信"];
    }
}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager]removeSTObsever:Notify_WXLogin];
}


-(void)onReciveResult:(NSString *)key msg:(NSString *)msg{
    _phoneTF.text = key;
    _verifyTF.text = msg;
}

@end
