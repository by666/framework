//
//  AuthStatuView.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthStatuView.h"
#import "STResultView.h"
#import "AccountManager.h"

@interface AuthStatuView()

@property(strong, nonatomic)AuthStatuViewModel *mViewModel;
@property(strong, nonatomic)UILabel *hurryTipsLabel;
@property(strong, nonatomic)UIButton *hurryBtn;

@end

@implementation AuthStatuView

-(instancetype)initWithViewModel:(AuthStatuViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    NSArray *titleArray = @[MSG_AUTHSTATU_STATU_SUBMIT,MSG_AUTHSTATU_STATU_AUTHING,MSG_AUTHSTATU_STATU_SUCCESS];
    for(int i = 0 ;i < [titleArray count] ; i ++){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(39) + i * STWidth(139), STHeight(35), STWidth(20), STWidth(20))];
        [self addSubview:imageView];
        
        NSString *labelStr = [titleArray objectAtIndex:i];
        UILabel *label = [[UILabel alloc]initWithFont:STFont(14) text:labelStr textAlignment:NSTextAlignmentCenter textColor:c19 backgroundColor:nil multiLine:NO];
        CGSize labelSize = [labelStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
        label.frame = CGRectMake(STWidth(55) + STWidth(136) * i - labelSize.width/2, STHeight(63), labelSize.width, STHeight(14));
        [self addSubview:label];
        
        if(i == 2){
            imageView.image = [UIImage imageNamed:@"ic_verify_wait"];
            label.textColor = c12;
        }else{
            imageView.image = [UIImage imageNamed:@"ic_verify_success"];
            label.textColor = c19;
        }
    }
    
    for(int i = 0 ; i < 2 ; i++){
        UILabel *label = [[UILabel alloc]initWithFont:STFont(14) text:@"-----------------" textAlignment:NSTextAlignmentCenter textColor:c09 backgroundColor:nil multiLine:NO];
        label.frame = CGRectMake(STWidth(65) + STWidth(136) * i, STHeight(35), STWidth(108), STHeight(20));
        [self addSubview:label];
    }

    
    _hurryTipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_AUTHSTATU_STATU_TIPS textAlignment:NSTextAlignmentCenter textColor:c16 backgroundColor:nil multiLine:YES];
    CGSize hurrySize = [MSG_AUTHSTATU_STATU_TIPS sizeWithMaxWidth:ScreenWidth - STWidth(54) font:[UIFont systemFontOfSize:STFont(14)]];
    _hurryTipsLabel.frame = CGRectMake(STWidth(27), STHeight(108), ScreenWidth - STWidth(54), hurrySize.height);
    [self addSubview:_hurryTipsLabel];
    
    _hurryBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_AUTHSTATU_HURRYBTN textColor:cwhite backgroundColor:c23 corner:STHeight(22.5) borderWidth:0 borderColor:nil];
    _hurryBtn.frame = CGRectMake(STWidth(112), STHeight(171), STWidth(151), STHeight(45));
    [_hurryBtn addTarget:self action:@selector(OnClickHurryBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hurryBtn];
    
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_AUTHSTATU_HURRY_TIPS textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:YES];
    CGSize tipsSize = [MSG_AUTHSTATU_HURRY_TIPS sizeWithMaxWidth:ScreenWidth - STWidth(50) font:[UIFont systemFontOfSize:STFont(14)]];
    tipsLabel.frame = CGRectMake(STWidth(25), STHeight(537), ScreenWidth - STWidth(50), tipsSize.height);
    [self addSubview:tipsLabel];
    
    ApplyModel *model = [[AccountManager sharedAccountManager]getApplyModel];
    if(model.visualFlag  == UserAttend){
        [self hasAttend];
    }
    
    UIButton *testBtn = [[UIButton alloc]initWithFont:STFont(14) text:@"测试审核通过" textColor:cwhite backgroundColor:c23 corner:STHeight(22.5) borderWidth:0 borderColor:nil];
    testBtn.frame = CGRectMake(STWidth(112), STHeight(240), STWidth(151), STHeight(45));
    [testBtn addTarget:self action:@selector(OnClickTestBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:testBtn];
}


-(void)OnClickTestBtn{
    [_mViewModel verifyUser];
}


-(void)OnClickHurryBtn{
    if(_mViewModel){
        [_mViewModel doHurryRequest];
    }
}

-(void)onHurryRequest:(Boolean)success{
    if(success){
        [self hasAttend];
    }
}


//已经催办过
-(void)hasAttend{
    [_hurryBtn setBackgroundColor:c27];
    [_hurryBtn setTitle:MSG_AUTHSTATU_HURRYBTN_CLICKED forState:UIControlStateNormal];
    _hurryBtn.enabled = NO;
    
    _hurryTipsLabel.text = MSG_AUTHSTATU_STATU_TIPS2;
    CGSize hurrySize = [MSG_AUTHSTATU_STATU_TIPS2 sizeWithMaxWidth:ScreenWidth - STWidth(54) font:[UIFont systemFontOfSize:STFont(14)]];
    _hurryTipsLabel.frame = CGRectMake(STWidth(27), STHeight(108), ScreenWidth - STWidth(54), hurrySize.height);
    
}

@end
