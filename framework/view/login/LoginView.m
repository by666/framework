//
//  LoginView.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "LoginView.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "STNavigationView.h"
@interface LoginView()

@property(strong, nonatomic) LoginViewModel *mViewModel;

@property(strong, nonatomic) UIButton *backBtn;
@property(strong, nonatomic) UIButton *loginBtn;
@property(strong, nonatomic) UIButton *wechatLoginBtn;


@property(strong, nonatomic) UITextField *phoneNumTF;
@property(strong, nonatomic) UITextField *verifyCodeTF;
@property(strong, nonatomic) UIButton *sendVerifyCodeBtn;
@property(strong, nonatomic) UILabel *tipLabel;
@property(strong, nonatomic) LoginPage *page;


@end

@implementation LoginView

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel controller:(LoginPage *)page{
    if(self == [super init]){
        _mViewModel = viewModel;
        _page = page;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _backBtn= [[UIButton alloc]init];
    _backBtn.frame = CGRectMake(0, STHeight(18), STWidth(45), STWidth(45));
    [_backBtn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(17), STHeight(18), STWidth(11), STHeight(11))];
    UIImage *image = [UIImage imageNamed:@"ic_arrow_back_white"];
    backImageView.image = image;
    [_backBtn addSubview:backImageView];
    
    UIImageView *logoImageView = [[UIImageView alloc]init];
    logoImageView.image = [UIImage imageNamed:@"ic_cellos_icon"];
    logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    logoImageView.frame = CGRectMake(STWidth(161), STHeight(86), STWidth(54), STWidth(54));
    [self addSubview:logoImageView];
    
    UIImageView *nameImageView = [[UIImageView alloc]init];
    nameImageView.image = [UIImage imageNamed:@"ic_cellos_text"];
    nameImageView.contentMode = UIViewContentModeScaleAspectFill;
    nameImageView.frame = CGRectMake(STWidth(127), STHeight(171), STWidth(122), STHeight(25));
    [self addSubview:nameImageView];
    
    
    _phoneNumTF = [[UITextField alloc]initWithFont:STFont(16) textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(2)];
    _phoneNumTF.frame =  CGRectMake(STWidth(47), STHeight(256), STWidth(280), STHeight(41));
    _phoneNumTF.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumTF.text = @"18680686420";
    NSAttributedString *phoneNumStr = [[NSAttributedString alloc] initWithString:MSG_LOGIN_PHONENUM_HINT attributes:
                                      @{NSForegroundColorAttributeName:[cwhite colorWithAlphaComponent:0.5f],
                                        NSFontAttributeName:_phoneNumTF.font
                                        }];
    _phoneNumTF.attributedPlaceholder = phoneNumStr;
    [self addSubview:_phoneNumTF];
    
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = cwhite;
    phoneLine.frame = CGRectMake(STWidth(47), STHeight(297), STWidth(280), 0.5f);
    [self addSubview:phoneLine];
    
    _verifyCodeTF = [[UITextField alloc]initWithFont:STFont(16) textColor:cwhite backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(2)];
    _verifyCodeTF.frame =  CGRectMake(STWidth(47), STHeight(313), STWidth(280), STHeight(41));
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    NSAttributedString *verifyCodeStr = [[NSAttributedString alloc] initWithString:MSG_LOGIN_VERIFYCODE_HINT attributes:
                                       @{NSForegroundColorAttributeName:[cwhite colorWithAlphaComponent:0.5f],
                                         NSFontAttributeName:_verifyCodeTF.font
                                         }];
    _verifyCodeTF.attributedPlaceholder = verifyCodeStr;
    [self addSubview:_verifyCodeTF];
    
    UIView *verifyLine = [[UIView alloc]init];
    verifyLine.backgroundColor = cwhite;
    verifyLine.frame = CGRectMake(STWidth(47), STHeight(357), STWidth(280), 0.5f);
    [self addSubview:verifyLine];
    
    _tipLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c06 backgroundColor:nil multiLine:NO];
    _tipLabel.frame = CGRectMake(STWidth(47), STHeight(371), STWidth(280), STHeight(20));
    [self addSubview:_tipLabel];
    
    
    _loginBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_LOGIN_BTN_LOGIN textColor:c04 backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _loginBtn.frame = CGRectMake(STWidth(27), STHeight(414), STWidth(320), STWidth(50));
    [_loginBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [self addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];

    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(114), STHeight(583), STWidth(26), 0.5f)];
    leftView.backgroundColor = c05;
    [self addSubview:leftView];
    
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(236), STHeight(583), STWidth(26), 0.5f)];
    rightView.backgroundColor = c05;
    [self addSubview:rightView];
    
    UILabel *thirdLabel = [[UILabel alloc]initWithFont:STFont(15) text:MSG_LOGIN_THIRD_LOGIN textAlignment:NSTextAlignmentCenter textColor:c05 backgroundColor:nil multiLine:NO];
    thirdLabel.frame = CGRectMake(0, STHeight(577), ScreenWidth, STHeight(15));
    [self addSubview:thirdLabel];
    
    
    _wechatLoginBtn =  [[UIButton alloc]init];
    [_wechatLoginBtn setImage:[UIImage imageNamed:@"ic_wechat"] forState:UIControlStateNormal];
    _wechatLoginBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    _wechatLoginBtn.frame = CGRectMake(STWidth(172), STHeight(617), STWidth(31), STWidth(31));
    [self addSubview:_wechatLoginBtn];
    [_wechatLoginBtn addTarget:self action:@selector(doWechatLogin) forControlEvents:UIControlEventTouchUpInside];

    
    _sendVerifyCodeBtn =  [[UIButton alloc]initWithFont:STFont(14) text:_mViewModel.loginModel.verifyStr textColor:cwhite backgroundColor:[UIColor clearColor] corner:0 borderWidth:0 borderColor:nil];
    _sendVerifyCodeBtn.frame = CGRectMake(STWidth(252), STHeight(300), STWidth(80), STHeight(56));
    _sendVerifyCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sendVerifyCodeBtn];
    [_sendVerifyCodeBtn addTarget:self action:@selector(doSendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    

  
}

-(void)doSendVerifyCode{
    if(_mViewModel){
        [_mViewModel sendVerifyCode:_phoneNumTF.text];
    }
}


-(void)doWechatLogin{
    __weak LoginViewModel *viewModel = _mViewModel;
    [STAlertUtil showAlertController:@"" content:MSG_OPEN_WECHAT controller:_page confirm:^{
        if(viewModel){
            [viewModel doWechatLogin];
        }
    }];
}

-(void)doLogin{
    if(_mViewModel){
        [_mViewModel doLogin:_phoneNumTF.text verifyCode:_verifyCodeTF.text];
    }
}


-(void)updateVerifyBtn:(Boolean)complete{
    [_sendVerifyCodeBtn setTitle:_mViewModel.loginModel.verifyStr forState:UIControlStateNormal];
    if(complete){
        [_sendVerifyCodeBtn setEnabled:YES];
        [_sendVerifyCodeBtn setTitleColor:cwhite forState:UIControlStateNormal];
    }else{
        [_sendVerifyCodeBtn setEnabled:NO];
        [_sendVerifyCodeBtn setTitleColor:c06 forState:UIControlStateNormal];
    }
}

-(void)updateView{
    _tipLabel.text = _mViewModel.loginModel.msgStr;
    _tipLabel.textColor = _mViewModel.loginModel.msgColor;
}

-(void)blankCode:(NSString *)code{
    [_verifyCodeTF setText:code];
}

-(void)doBack{
    if(_mViewModel){
        [_mViewModel goback];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumTF resignFirstResponder];
    [_verifyCodeTF resignFirstResponder];
}

@end
