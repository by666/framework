//
//  AuthFaceView.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthFaceView.h"
#import "STResultView.h"

@interface AuthFaceView()

@property(strong, nonatomic)AuthFaceViewModel *mViewModel;
@property(strong, nonatomic)UIButton *addPhotoBtn;
@property(strong, nonatomic)STResultView *resultView;
@property(assign, nonatomic)NSInteger time;
@property(strong, nonatomic)UIButton *nextBtn;
@property(strong, nonatomic)UIView *layerView;
@property(strong, nonatomic)UIImageView *addImageView;
@property(strong, nonatomic)UILabel *tipsLabel;

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
    UILabel *mainContent = [[UILabel alloc]initWithFont:STFont(17) text:MSG_AUTHFACE_MAIN_CONTENT textAlignment:NSTextAlignmentCenter textColor:c08 backgroundColor:nil multiLine:NO];
    mainContent.frame = CGRectMake(0, STHeight(30), ScreenWidth, STHeight(17));
    [self addSubview:mainContent];
    
    
    UILabel *subContent = [[UILabel alloc]initWithFont:STFont(14) text:MSG_AUTHFACE_SUB_CONTENT textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:YES];
    subContent.frame = CGRectMake(0, STHeight(58), ScreenWidth, STHeight(14));
    [self addSubview:subContent];
    
    _addPhotoBtn = [[UIButton alloc]initWithFont:STFont(30) text:@"" textColor:c12 backgroundColor:c36 corner:STWidth(104) borderWidth:0 borderColor:nil];
    _addPhotoBtn.frame = CGRectMake((ScreenWidth - STWidth(208))/2, STHeight(104), STWidth(208), STWidth(208));
    _addPhotoBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_addPhotoBtn addTarget:self action:@selector(onClickAddPhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addPhotoBtn];
    
    
    _addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(76), STHeight(79), STWidth(54), STHeight(44))];
    _addImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addImageView.image = [UIImage imageNamed:@"用户认证_icon_相机大"];
    _addImageView.userInteractionEnabled = NO;
    [_addPhotoBtn addSubview:_addImageView];
    
    _layerView= [[UIView alloc]init];
    _layerView.hidden = YES;
    _layerView.userInteractionEnabled = NO;
    _layerView.backgroundColor = [c35 colorWithAlphaComponent:0.6f];
    _layerView.frame = CGRectMake(0, STWidth(150), STWidth(208), STWidth(58));
    [_addPhotoBtn addSubview:_layerView];
    
    UIImageView *layerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(91), STHeight(13), STWidth(25), STWidth(25))];
    layerImageView.image = [UIImage imageNamed:@"用户认证_icon_相机大"];
    layerImageView.userInteractionEnabled = NO;
    layerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_layerView addSubview:layerImageView];
    
    _addPhotoBtn.clipsToBounds = YES;
    
    
    _tipsLabel = [[UILabel alloc]initWithFont:STFont(17) text:MSG_AUTHFACE_RETAKEPHOTO_TIPS textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    _tipsLabel.frame = CGRectMake(0, STHeight(328), ScreenWidth, STHeight(17));
    _tipsLabel.hidden = YES;
    [self addSubview:_tipsLabel];
    
    _nextBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_AUTHFACE_UPLOAD textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _nextBtn.frame = CGRectMake((ScreenWidth - STWidth(150))/2, ContentHeight - STHeight(120), STWidth(150), STHeight(50));
    _nextBtn.hidden = YES;
    [_nextBtn addTarget:self action:@selector(onClickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    [self addSubview:_nextBtn];
    
    WS(weakSelf)
    _resultView = [[STResultView alloc]initWithTips:MSG_AUTHSTATU_SUBMIT_SUCCESS tips2:MSG_AUTHSTATU_SUBMIT_TIPS btnTxt:MSG_AUTHFACE_BACKHOME click:^(NSString *result) {
        if(weakSelf.mViewModel){
            [weakSelf.mViewModel goMainPage];
        }
    }];
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
    _mViewModel.userCommitModel.facePath = imagePath;
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    [_addPhotoBtn setImage:image forState:UIControlStateNormal];
    [_addPhotoBtn setImage:image forState:UIControlStateHighlighted];
    _nextBtn.hidden = NO;
    _layerView.hidden = NO;
    _addImageView.hidden = YES;
    _tipsLabel.hidden = NO;
}




-(void)onCommitFinish{
//    _time = 5;
    _resultView.hidden = NO;
//    [self startTime];

}


//-(void)startTime{
//    if(_time <= 0){
//        [_resultView setTips1Text:MSG_AUTHSTATU_SUBMIT_SUCCESS];
//        if(_mViewModel){
//            [_mViewModel goMainPage];
//        }
//        return;
//    }
//    [_resultView setTips1Text:[NSString stringWithFormat:@"提交信息成功！%ld秒后进入主页",_time]];
//    _time --;
//    WS(weakSelf)
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf startTime];
//    });
//}


@end
