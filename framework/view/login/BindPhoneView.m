//
//  PhoneNumView.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BindPhoneView.h"

@interface BindPhoneView()

@property(strong, nonatomic) BindPhoneViewModel *mViewModel;

@property(strong, nonatomic) UITextField *phoneNumTF;
@property(strong, nonatomic) UITextField *verifyCodeTF;
@property(strong, nonatomic) UIButton *sendVerifyCodeBtn;
@property(strong, nonatomic) UILabel *tipLabel;
@property(strong, nonatomic) UIButton *submitBtn;

@end

@implementation BindPhoneView{
    NSString *mTitle;
}

-(instancetype)initWithViewModel:(BindPhoneViewModel *)viewModel title:(NSString *)title{
    if(self == [super init]){
        _mViewModel = viewModel;
        mTitle = title;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:mTitle textAlignment:NSTextAlignmentCenter textColor:c08 backgroundColor:nil multiLine:YES];
    titleLabel.frame = CGRectMake(STWidth(27), STHeight(75), ScreenWidth-STWidth(54), [STPUtil textSize:mTitle maxWidth:ScreenWidth-STWidth(54) font:STFont(16)].height);
    [self addSubview:titleLabel];
    
    
    _phoneNumTF = [[UITextField alloc]initWithFont:STFont(16) textColor:cblack backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(2)];
    _phoneNumTF.frame =  CGRectMake(STWidth(47), STHeight(147), STWidth(280), STHeight(41));
    _phoneNumTF.keyboardType = UIKeyboardTypePhonePad;
    [_phoneNumTF setPlaceholder:@"请输入手机号"];
    
    [self addSubview:_phoneNumTF];
    
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = c09;
    phoneLine.frame = CGRectMake(STWidth(47), STHeight(188), STWidth(280), STHeight(0.5f));
    [self addSubview:phoneLine];
    
    _verifyCodeTF = [[UITextField alloc]initWithFont:STFont(16) textColor:cblack backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:STWidth(2)];
    _verifyCodeTF.frame =  CGRectMake(STWidth(47), STHeight(207), STWidth(280), STHeight(41));
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    [_verifyCodeTF setPlaceholder:@"验证码"];
    [self addSubview:_verifyCodeTF];
    
    UIView *verifyLine = [[UIView alloc]init];
    verifyLine.backgroundColor = c09;
    verifyLine.frame = CGRectMake(STWidth(47), STHeight(248), STWidth(280), STHeight(0.5f));
    [self addSubview:verifyLine];
    
    
    _sendVerifyCodeBtn =  [[UIButton alloc]initWithFont:STFont(14) text:_mViewModel.bindPhoneModel.verifyStr textColor:c08 backgroundColor:[UIColor clearColor] corner:0 borderWidth:0 borderColor:nil];
    _sendVerifyCodeBtn.frame = CGRectMake(STWidth(252), STHeight(188), STWidth(80), STHeight(60));
    _sendVerifyCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sendVerifyCodeBtn];
    [_sendVerifyCodeBtn addTarget:self action:@selector(doSendVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    

    _tipLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentLeft textColor:c06 backgroundColor:nil multiLine:NO];
    _tipLabel.frame = CGRectMake(STWidth(47), STHeight(261.5), STWidth(280), STHeight(20));
    [self addSubview:_tipLabel];
    
    
    _submitBtn = [[UIButton alloc]initWithFont:STFont(18) text:@"提交" textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _submitBtn.frame = CGRectMake(STWidth(27), STHeight(313), STWidth(320), STWidth(50));
    [self addSubview:_submitBtn];
    [_submitBtn addTarget:self action:@selector(doBindPhone) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)doSendVerifyCode{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    if(_mViewModel){
        [_mViewModel sendVerifyCode:_phoneNumTF.text];
    }
}

-(void)doBindPhone{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    if(_mViewModel){
        [_mViewModel doBindPhone:_phoneNumTF.text verifyCode:_verifyCodeTF.text];
    }
}

-(void)updateView{
    [MBProgressHUD hideHUDForView:self animated:YES];
    _tipLabel.text = _mViewModel.bindPhoneModel.msgStr;
    _tipLabel.textColor = _mViewModel.bindPhoneModel.msgColor;
}

-(void)updateVerifyBtn:(Boolean)complete{
    [_sendVerifyCodeBtn setTitle:_mViewModel.bindPhoneModel.verifyStr forState:UIControlStateNormal];
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

@end
