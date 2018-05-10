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
@property(strong, nonatomic) UIButton *submitBtn;

@end

@implementation BindPhoneView

-(instancetype)initWithViewModel:(BindPhoneViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _phoneNumTF = [[UITextField alloc]initWithFont:STFont(36) textColor:[UIColor redColor] backgroundColor:[UIColor whiteColor] corner:STHeight(10) borderWidth:STWidth(2) borderColor:[UIColor redColor] padding:STWidth(20)];
    _phoneNumTF.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:_phoneNumTF];
    
    _submitBtn =  [[UIButton alloc]initWithFont:STFont(36) text:@"绑定" textColor:[UIColor blueColor] backgroundColor:[UIColor cyanColor] corner:STHeight(10) borderWidth:STWidth(2) borderColor:[UIColor blueColor]];
    [self addSubview:_submitBtn];
    [_submitBtn addTarget:self action:@selector(doSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    [self initFrame];
}

-(void)initFrame{
    
    __weak BindPhoneView *weakSelf = self;
    
    [_phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth - STWidth(80));
        make.height.mas_equalTo(STHeight(80));
        make.top.mas_equalTo(STHeight(30));
        make.left.mas_equalTo(STWidth(40));
    }];

    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth - STWidth(80));
        make.height.mas_equalTo(STHeight(100));
        make.left.mas_equalTo(STWidth(40));
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-STHeight(80));
    }];
}

-(void)doSubmit{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    if(_mViewModel){
        [_mViewModel doBindPhoneNum:_phoneNumTF.text];
    }
}

-(void)updateView{
    NSLog(@"更新UI");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumTF resignFirstResponder];
}

@end
