//
//  AuthFaceView.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthFaceView.h"
#import "STResultView.h"

@interface AuthFaceView()<MBProgressHUDDelegate>

@property(strong, nonatomic)AuthFaceViewModel *mViewModel;
@property(strong, nonatomic)UIButton *addPhotoBtn;
@property(strong, nonatomic)STResultView *resultView;
@property(strong, nonatomic)MBProgressHUD *hud;
@property(assign, nonatomic)NSInteger time;
@property(strong, nonatomic)UIButton *nextBtn;

@end

@implementation AuthFaceView

-(instancetype)initWithViewModel:(AuthFaceViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *mainContent = [[UILabel alloc]initWithFont:STFont(18) text:MSG_AUTHFACE_MAIN_CONTENT textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    mainContent.frame = CGRectMake(0, STHeight(16), ScreenWidth, STHeight(18));
    [self addSubview:mainContent];
    
    
    UILabel *subContent = [[UILabel alloc]initWithFont:STFont(14) text:MSG_AUTHFACE_SUB_CONTENT textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:YES];
    CGSize subSize = [MSG_AUTHFACE_SUB_CONTENT sizeWithMaxWidth:ScreenWidth - STWidth(64) font:[UIFont systemFontOfSize:STFont(14)]];
    subContent.frame = CGRectMake(STWidth(32), STHeight(62), ScreenWidth - STWidth(64), subSize.height);
    [self addSubview:subContent];
    
    _addPhotoBtn = [[UIButton alloc]initWithFont:STFont(30) text:@"" textColor:c12 backgroundColor:c15 corner:STHeight(70) borderWidth:3.25f borderColor:c22];
    _addPhotoBtn.frame = CGRectMake(STWidth(118), STHeight(161), STWidth(140), STWidth(140));
    _addPhotoBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_addPhotoBtn addTarget:self action:@selector(onClickAddPhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addPhotoBtn];
    
    UILabel *layerLabel= [[UILabel alloc]initWithFont:STFont(17) text:@"+" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:[c13 colorWithAlphaComponent:0.6f] multiLine:NO];
    layerLabel.frame = CGRectMake(0, STHeight(101), STWidth(140), STHeight(39));
    [_addPhotoBtn addSubview:layerLabel];
    _addPhotoBtn.clipsToBounds = YES;
    
    _nextBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_AUTHFACE_UPLOAD textColor:cwhite backgroundColor:c19 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _nextBtn.frame = CGRectMake(STWidth(50), STHeight(513), STWidth(276), STHeight(50));
    _nextBtn.hidden = YES;
    [_nextBtn addTarget:self action:@selector(onClickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    [self addSubview:_nextBtn];
    
    _resultView = [[STResultView alloc]initWithTips:MSG_AUTHSTATU_SUBMIT_SUCCESS tips2:MSG_AUTHSTATU_SUBMIT_TIPS];
    _resultView.hidden = YES;
    [self addSubview:_resultView];
    
}

-(void)onClickAddPhotoBtn{
    if(_mViewModel){
        [_mViewModel addPhoto];
    }
}

-(void)onClickNextBtn{
    if(_mViewModel){
        [_mViewModel commitUserInfo];
    }
}

-(void)updateView:(NSString *)imagePath{
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    [_addPhotoBtn setImage:image forState:UIControlStateNormal];
    [_addPhotoBtn setImage:image forState:UIControlStateHighlighted];
    _nextBtn.hidden = NO;
}

-(void)onCommitStart{
    _hud = [[MBProgressHUD alloc]initWithView:self];
    _hud.labelText = @"正在提交用户信息，请稍后";
    _hud.mode = MBProgressHUDModeDeterminate;
    _hud.delegate = self;
    [self addSubview:_hud];
    [_hud show:YES];
}

-(void)onCommitProgress:(float)progress{
    _hud.progress = progress;
}

-(void)onCommitFinish{
    _time = 5;
    _resultView.hidden = NO;
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.customView =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_finish"]];
    [self startTime];

}


-(void)startTime{
    if(_time <= 0){
        [_hud hide:YES];
        [_hud removeFromSuperview];
        if(_mViewModel){
            [_mViewModel goMainPage];
        }
        return;
    }
    _hud.labelText = [NSString stringWithFormat:@"提交信息成功！%ld秒后进入主页",_time];
    _time --;
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf startTime];
    });
}


@end
