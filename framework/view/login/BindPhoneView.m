//
//  PhoneNumView.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BindPhoneView.h"

@interface BindPhoneView()

@property(strong, nonatomic) LoginViewModel *mViewModel;

@property(strong, nonatomic) UITextField *phoneNumTF;
@property(strong, nonatomic) UITextField *verifyCodeTF;
@property(strong, nonatomic) UIButton *sendVerifyCodeBtn;
@property(strong, nonatomic) UILabel *tipLabel;
@property(strong, nonatomic) UIButton *loginBtn;
@property(copy, nonatomic)NSString *wxToken;

@end

@implementation BindPhoneView{
    NSString *mTitle;
}

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel title:(NSString *)title{
    if(self == [super init]){
        _mViewModel = viewModel;
        mTitle = title;
        [self initView];
    }
    return self;
}

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel title:(NSString *)title wxToken:(NSString *)wxToken{
    if(self == [super init]){
        _mViewModel = viewModel;
        mTitle = title;
        _wxToken = wxToken;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:mTitle textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:YES];
    titleLabel.frame = CGRectMake(0 , STHeight(85), ScreenWidth,STHeight(16));
    [self addSubview:titleLabel];
    
    
    _phoneNumTF = [[UITextField alloc]initWithFont:STFont(16) textColor:cblack backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(2)];
    _phoneNumTF.frame =  CGRectMake(STWidth(47), STHeight(147), STWidth(280), STHeight(41));
    _phoneNumTF.keyboardType = UIKeyboardTypePhonePad;
    NSAttributedString *phoneNumStr = [[NSAttributedString alloc] initWithString:MSG_LOGIN_PHONENUM_HINT attributes:
                                       @{NSForegroundColorAttributeName:[c09 colorWithAlphaComponent:0.5f],
                                         NSFontAttributeName:_phoneNumTF.font
                                         }];
    _phoneNumTF.attributedPlaceholder = phoneNumStr;
    [_phoneNumTF setMaxLength:@"11"];
    [_phoneNumTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_phoneNumTF];
    
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = c09;
    phoneLine.frame = CGRectMake(STWidth(47), STHeight(188), STWidth(280), 0.5f);
    [self addSubview:phoneLine];
    
    _verifyCodeTF = [[UITextField alloc]initWithFont:STFont(16) textColor:cblack backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(2)];
    _verifyCodeTF.frame =  CGRectMake(STWidth(47), STHeight(207), STWidth(280), STHeight(41));
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    NSAttributedString *verifyCodeStr = [[NSAttributedString alloc] initWithString:MSG_LOGIN_VERIFYCODE_HINT attributes:
                                         @{NSForegroundColorAttributeName:[c09 colorWithAlphaComponent:0.5f],
                                           NSFontAttributeName:_verifyCodeTF.font
                                           }];
    _verifyCodeTF.attributedPlaceholder = verifyCodeStr;
    [_verifyCodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_verifyCodeTF setMaxLength:@"6"];
    [self addSubview:_verifyCodeTF];
    
    UIView *verifyLine = [[UIView alloc]init];
    verifyLine.backgroundColor = c09;
    verifyLine.frame = CGRectMake(STWidth(47), STHeight(248), STWidth(280), 0.5f);
    [self addSubview:verifyLine];
    
    
    _sendVerifyCodeBtn =  [[UIButton alloc]initWithFont:STFont(14) text:_mViewModel.loginModel.verifyStr textColor:c08 backgroundColor:[UIColor clearColor] corner:0 borderWidth:0 borderColor:nil];
    [_sendVerifyCodeBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    _sendVerifyCodeBtn.frame = CGRectMake(STWidth(252), STHeight(188), STWidth(80), STHeight(60));
    _sendVerifyCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sendVerifyCodeBtn];
    [_sendVerifyCodeBtn addTarget:self action:@selector(doSendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    

    _tipLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c06 backgroundColor:nil multiLine:NO];
    _tipLabel.frame = CGRectMake(STWidth(47), STHeight(261.5), STWidth(280), STHeight(20));
    [self addSubview:_tipLabel];
    
    
    _loginBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"提交" textColor:c12 backgroundColor:c37 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _loginBtn.frame = CGRectMake(STWidth(27), STHeight(313), STWidth(320), STWidth(50));
    [_loginBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [_loginBtn setEnabled:NO];
    [self addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(doBindPhone) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)doSendVerifyCode{
    if(_mViewModel){
        [_mViewModel sendVerifyCode:_phoneNumTF.text];
    }
}

-(void)doBindPhone{
    if(_mViewModel){
        [_mViewModel doLogin:_phoneNumTF.text verifyCode:_verifyCodeTF.text wxToken:_wxToken];
    }
}


-(void)updateView{
    _tipLabel.text = _mViewModel.loginModel.msgStr;
    _tipLabel.textColor = _mViewModel.loginModel.msgColor;
}


-(void)updateVerifyBtn:(Boolean)complete{
    [_sendVerifyCodeBtn setTitle:_mViewModel.loginModel.verifyStr forState:UIControlStateNormal];
    [self changeLoginBtnStatu];
    if(complete){
        [_sendVerifyCodeBtn setEnabled:YES];
        [_sendVerifyCodeBtn setTitleColor:c08 forState:UIControlStateNormal];
    }else{
        [_sendVerifyCodeBtn setEnabled:NO];
        [_sendVerifyCodeBtn setTitleColor:c06 forState:UIControlStateNormal];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumTF resignFirstResponder];
    [_verifyCodeTF resignFirstResponder];
}


- (void)textFieldDidChange:(UITextField *)textField{
    [self changeLoginBtnStatu];
}

-(void)changeLoginBtnStatu{
    if(!IS_NS_STRING_EMPTY(_phoneNumTF.text) && !IS_NS_STRING_EMPTY(_verifyCodeTF.text)){
        [_loginBtn setBackgroundColor:c08 forState:UIControlStateNormal];
        _loginBtn.enabled = YES;
        [_loginBtn setTitleColor:cwhite forState:UIControlStateNormal];
    }else{
        [_loginBtn setBackgroundColor:c37 forState:UIControlStateNormal];
        _loginBtn.enabled = NO;
        [_loginBtn setTitleColor:c12 forState:UIControlStateNormal];
    }
}

-(void)blankCode:(NSString *)code{
    [_verifyCodeTF setText:code];
    _loginBtn.enabled = YES;
}


@end
