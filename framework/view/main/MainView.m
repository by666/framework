//
//  MainView.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainView.h"

@interface MainView()

@property(strong, nonatomic) MainViewModel *mViewModel;
@property(strong, nonatomic) UIButton *mineBtn;
@property(strong, nonatomic) UIButton *msgBtn;

@end

@implementation MainView

-(instancetype)initWithViewModel:(MainViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    _mineBtn = [[UIButton alloc]initWithFont:STFont(20) text:@"我的" textColor:c01 backgroundColor:cwhite corner:0 borderWidth:0 borderColor:nil];
    _mineBtn.frame = CGRectMake(0, STHeight(100), ScreenWidth, STHeight(60));
    [_mineBtn addTarget:self action:@selector(clickMineBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mineBtn];
    
    _msgBtn = [[UIButton alloc]initWithFont:STFont(20) text:@"消息主页" textColor:c01 backgroundColor:cwhite corner:0 borderWidth:0 borderColor:nil];
    _msgBtn.frame = CGRectMake(0, STHeight(200), ScreenWidth, STHeight(60));
    [_msgBtn addTarget:self action:@selector(clickMsgBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_msgBtn];
}

-(void)clickMineBtn{
    [_mViewModel goMinePage];
}

-(void)clickMsgBtn{
    [_mViewModel goMessagePage];
}

@end
