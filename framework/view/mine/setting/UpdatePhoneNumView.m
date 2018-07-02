//
//  UpdatePhoneNumView.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UpdatePhoneNumView.h"
#import "STCodeView.h"
#import "AccountManager.h"

@interface UpdatePhoneNumView()<STCodeViewDelegate>

@property(strong, nonatomic)UpdatePhoneNumViewModel *mViewModel;
@property(strong, nonatomic)UIButton *sendVerifyBtn;
@property(strong, nonatomic)UILabel *verifyTipsLabel;
@property(strong, nonatomic)STCodeView *codeView;

@end
@implementation UpdatePhoneNumView

-(instancetype)initWithViewModel:(UpdatePhoneNumViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_UPDATEPHONENUM_TIPS textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:YES];
    tipsLabel.frame = CGRectMake(STWidth(27), STHeight(20), ScreenWidth - STWidth(54), [STPUtil textSize:MSG_UPDATEPHONENUM_TIPS maxWidth:(ScreenWidth - STWidth(54)) font:STFont(14)].height);
    [self addSubview:tipsLabel];
    
    UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
    UILabel *phoneNumLabel = [[UILabel alloc]initWithFont:STFont(18) text:[STPUtil getSecretPhoneNum:model.phoneNum] textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    phoneNumLabel.frame = CGRectMake(0, STHeight(84), ScreenWidth, STHeight(18));
    [self addSubview:phoneNumLabel];
    
    _codeView = [[STCodeView alloc]init];
    _codeView.frame = CGRectMake(0, STHeight(131), ScreenWidth, STHeight(50));
    _codeView.delegate = self;
    [self addSubview:_codeView];
    
    _sendVerifyBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"发送验证码" textColor:cwhite backgroundColor:c19 corner:STHeight(22.5) borderWidth:0 borderColor:nil];
    _sendVerifyBtn.frame = CGRectMake(STWidth(112), STHeight(211), STWidth(151), STHeight(45));
    [_sendVerifyBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    [_sendVerifyBtn addTarget:self action:@selector(OnClickSendVerifyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendVerifyBtn];
    
    _verifyTipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_UPDATEPHONENUM_TIPS2 textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    _verifyTipsLabel.frame = CGRectMake(0, STHeight(276), ScreenWidth, STHeight(14));
    _verifyTipsLabel.hidden = YES;
    [self addSubview:_verifyTipsLabel];
}

-(void)OnClickSendVerifyBtn{
    [_sendVerifyBtn setTitleColor:c12 forState:UIControlStateNormal];
    _sendVerifyBtn.backgroundColor = c22;
    _verifyTipsLabel.hidden = NO;

}


-(void)onCodeInputStatu:(NSString *)code{
    [STLog print:@"code" content:code];
    if(!IS_NS_STRING_EMPTY(code) && (code.length == 6)){
        if(_mViewModel){
            [_mViewModel checkVerifyCode:code];
        }
    }else{
        [_sendVerifyBtn setTitleColor:cwhite forState:UIControlStateNormal];
        _sendVerifyBtn.backgroundColor = c19;
    }
}

@end
