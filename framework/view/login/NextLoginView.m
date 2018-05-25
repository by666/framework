//
//  NextLoginView.m
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "NextLoginView.h"


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
    
    UIImageView *avatarImageView = [[UIImageView alloc]init];
    avatarImageView.backgroundColor = cblack;
    avatarImageView.frame= CGRectMake(STWidth(157), STHeight(79), STWidth(62), STWidth(62));
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.layer.cornerRadius = STWidth(31);
    avatarImageView.image = [UIImage imageNamed:@"ic_test1"];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:avatarImageView];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFont:STFont(15) text:@"186****6420" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    phoneLabel.frame = CGRectMake(0, STHeight(157), ScreenWidth, STHeight(15));
    [self addSubview:phoneLabel];
    
    UIButton *faceLoginBtn = [[UIButton alloc]initWithFont:STFont(15) text:MSG_FACE_LOGIN textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    faceLoginBtn.frame = CGRectMake(STWidth(50), STHeight(209), STWidth(276), STHeight(50));
    [faceLoginBtn addTarget:self action:@selector(goFaceLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:faceLoginBtn];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFont:STFont(15) text:MSG_VERIFYCODE_LOGIN textColor:c08 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    loginBtn.frame = CGRectMake(STWidth(150), STHeight(274), STWidth(77), STHeight(21));
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
