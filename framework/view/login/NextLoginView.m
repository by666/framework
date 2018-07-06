//
//  NextLoginView.m
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "NextLoginView.h"
#import "AccountManager.h"

@interface NextLoginView()

@property(strong, nonatomic)NextLoginViewModel *mViewModel;

@end
@implementation NextLoginView

-(instancetype)initWithViewModel:(NextLoginViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    UIImageView *avatarImageView = [[UIImageView alloc]init];
    avatarImageView.backgroundColor = cblack;
    avatarImageView.frame= CGRectMake(STWidth(157), STHeight(79), STWidth(62), STWidth(62));
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.layer.cornerRadius = STWidth(31);
    [avatarImageView sd_setImageWithURL:[[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:model.headUrl]];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:avatarImageView];
    
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    UILabel *phoneLabel = [[UILabel alloc]initWithFont:STFont(15) text:[STPUtil getSecretPhoneNum:userModel.phoneNum] textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    phoneLabel.frame = CGRectMake(0, STHeight(157), ScreenWidth, STHeight(15));
    [self addSubview:phoneLabel];
    
    UIButton *faceLoginBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_FACE_LOGIN textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    faceLoginBtn.frame = CGRectMake(STWidth(50), STHeight(209), STWidth(276), STHeight(50));
    [faceLoginBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [faceLoginBtn addTarget:self action:@selector(goFaceLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:faceLoginBtn];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFont:STFont(15) text:MSG_VERIFYCODE_LOGIN textColor:c08 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize loginStrSize =  [MSG_VERIFYCODE_LOGIN sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(15)]];
    loginBtn.frame = CGRectMake((ScreenWidth - loginStrSize.width )/2, STHeight(274), loginStrSize.width, STHeight(21));
    [loginBtn addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
}


-(void)goFaceLogin{
    if(_mViewModel){
        [_mViewModel goFaceLoginPage];
    }
}

-(void)goLogin{
    if(_mViewModel){
        [_mViewModel goLoginPage];
    }
}

@end
