//
//  VideoView.m
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VideoView.h"
#import "WYManager.h"
@interface VideoView()

@property(strong, nonatomic)VideoViewModel *mViewModel;

@property(strong, nonatomic)UIImageView *faceImageView;
@property(strong, nonatomic)UIButton *positionBtn;
@property(strong, nonatomic)UIButton *acceptBtn;
@property(strong, nonatomic)UILabel *acceptLabel;
@property(strong, nonatomic)UIButton *opendoorBtn;
@property(strong, nonatomic)UILabel *opendoorLabel;
@property(strong, nonatomic)UIButton *rejectBtn;
@property(strong, nonatomic)UILabel *rejectLabel;
@property(strong, nonatomic)UIButton *audioAcceptBtn;
@property(strong, nonatomic)UILabel *timeLabel;

@property(strong, nonatomic)UIButton *cutShootBtn;
@property(strong, nonatomic)UIButton *muteBtn;

@property(strong, nonatomic)UIView *displayView;
@property(strong, nonatomic)UIImageView *myView;
@property(strong, nonatomic)UIImageView *otherView;

@property(strong, nonatomic)UIToolbar *toolbar;

@end

@implementation VideoView{
    //statu =0 ,默认接听
    //statu = 1, 转为语音
    //statu = 2, 转为视频
    int statu;
}

-(instancetype)initWithViewModel:(VideoViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _displayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self addSubview:_displayView];
    
    [self myView];
    [self otherView];
    [self faceImageView];
    [self positionBtn];
    [self acceptBtn];
    [self setAcceptText:@"接听"];
    [self rejectBtn];
    [self setRejectText:@"拒绝"];
    [self opendoorBtn];
    [self opendoorLabel];
    [self audioAcceptBtn];
    [self cutShootBtn];
    [self muteBtn];
    [self timeLabel];
    [self toolbar];
   
}

//我的视频流
-(UIImageView *)myView{
    if(_myView == nil){
        _myView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _myView.image = [UIImage imageNamed:@"test_myview"];
        _myView.hidden = YES;
        _myView.contentMode = UIViewContentModeScaleAspectFill;
        [_displayView addSubview:_myView];
    }
    return _myView;
}

//他人视频流
-(UIImageView *)otherView{
    if(_otherView == nil){
        _otherView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(118), STHeight(30), STWidth(100), STWidth(130))];
        _otherView.image = [UIImage imageNamed:@"test_otherview"];
        _otherView.hidden = YES;
        _otherView.contentMode = UIViewContentModeScaleAspectFill;
        [_displayView addSubview:_otherView];
    }
    return _otherView;
}


//来电头像
-(UIImageView *)faceImageView{
    if(_faceImageView == nil){
        CGFloat width = ScreenWidth - STWidth(36);
        _faceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(18), STHeight(56), width, width* 240 / 340)];
        _faceImageView.contentMode = UIViewContentModeScaleAspectFill;
        _faceImageView.backgroundColor = c01;
        _faceImageView.image = [UIImage imageNamed:@"test_video"];
        [self addSubview:_faceImageView];
    }
    return _faceImageView;
}

//来电姓名
-(UIButton *)positionBtn{
    if(_positionBtn == nil){
        NSString *positionStr = @"A栋一单元本门口";
        CGSize pSize = [positionStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        CGFloat pWidth = pSize.width + STWidth(22);
        
        _positionBtn = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - pWidth)/2, STHeight(318),pWidth, STHeight(16))];
        [_positionBtn setImage:[UIImage imageNamed:@"icon_坐标"] forState:UIControlStateNormal];
        [_positionBtn setTitle:positionStr forState:UIControlStateNormal];
        [self addSubview:_positionBtn];
    }
    return _positionBtn;
}

//语音接听
-(UIButton *)audioAcceptBtn{
    if(_audioAcceptBtn == nil){
        NSString *audioAcceptStr = @"语音接听";
        _audioAcceptBtn = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(70))/2, STHeight(413), STWidth(70), STWidth(70) )];
        [self addSubview:_audioAcceptBtn];
        
        UIImageView *audioAcceptImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(25), 0, STWidth(20), STHeight(28.5))];
        audioAcceptImageView.image = [UIImage imageNamed:@"icon_转为语音"];
        audioAcceptImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_audioAcceptBtn addSubview:audioAcceptImageView];
        
        UILabel *audioAcceptLabel = [[UILabel alloc]initWithFont:STFont(16) text:audioAcceptStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
        audioAcceptLabel.frame = CGRectMake(0, STHeight(54), STWidth(70), STHeight(16));
        [_audioAcceptBtn addSubview:audioAcceptLabel];
        [_audioAcceptBtn addTarget:self action:@selector(onClickAudioAcceptBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _audioAcceptBtn;
}


//功能键（左）
-(UIButton *)acceptBtn{
    if(_acceptBtn == nil){
        _acceptBtn = [[UIButton alloc]initWithFrame:CGRectMake(STWidth(40), ScreenHeight - STHeight(131), STWidth(60), STWidth(60))];
        [_acceptBtn setImage:[UIImage imageNamed:@"icon_接听"] forState:UIControlStateNormal];
        [_acceptBtn setImage:[UIImage imageNamed:@"icon_接听__pressed"] forState:UIControlStateHighlighted];
        [self addSubview:_acceptBtn];
        [_acceptBtn addTarget:self action:@selector(onClickAccept) forControlEvents:UIControlEventTouchUpInside];
    }
    return _acceptBtn;
}

-(UILabel *)acceptLabel{
    if(_acceptLabel == nil){
        _acceptLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:NO];
        [self addSubview:_acceptLabel];
    }
    return _acceptLabel;
}

-(void)setAcceptText:(NSString *)acceptStr{
    CGSize acceptSize = [acceptStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    [self acceptLabel].text = acceptStr;
    [self acceptLabel].frame = CGRectMake(STWidth(70) - acceptSize.width / 2, ScreenHeight - STHeight(131) + STWidth(60) + STHeight(16), acceptSize.width, STFont(16));
}


//功能键(右)

-(UIButton *)rejectBtn{
    if(_rejectBtn == nil){
        _rejectBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(99), ScreenHeight - STHeight(131), STWidth(60), STWidth(60))];
        [_rejectBtn setImage:[UIImage imageNamed:@"icon_拒绝"] forState:UIControlStateNormal];
        [_rejectBtn setImage:[UIImage imageNamed:@"icon_拒绝__pressed"] forState:UIControlStateHighlighted];
        [self addSubview:_rejectBtn];
        [_rejectBtn addTarget:self action:@selector(onClickReject) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rejectBtn;
}

-(UILabel *)rejectLabel{
    if(_rejectLabel == nil){
        _rejectLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentLeft textColor:cwhite backgroundColor:nil multiLine:NO];
        [self addSubview:_rejectLabel];
    }
    return _rejectLabel;
}

-(void)setRejectText:(NSString *)rejectStr{
    CGSize rejectSize = [rejectStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    [self rejectLabel].text = rejectStr;
    [self rejectLabel].frame = CGRectMake(ScreenWidth -( STWidth(70) + rejectSize.width / 2), ScreenHeight - STHeight(131) + STWidth(60) + STHeight(16), rejectSize.width, STFont(16));
}


//功能键(中)
-(UIButton *)opendoorBtn{
    if(_opendoorBtn == nil){
        _opendoorBtn = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(76))/2, ScreenHeight - STHeight(147), STWidth(76), STWidth(76))];
        [_opendoorBtn setImage:[UIImage imageNamed:@"icon_开门"] forState:UIControlStateNormal];
        [_opendoorBtn setImage:[UIImage imageNamed:@"icon_开门__pressed"] forState:UIControlStateHighlighted];
        [self addSubview:_opendoorBtn];
        [_opendoorBtn addTarget:self action:@selector(onClickOpenDoor) forControlEvents:UIControlEventTouchUpInside];
    }
    return _opendoorBtn;
}

-(UILabel *)opendoorLabel{
    if(_opendoorLabel == nil){
        _opendoorLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"开门" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
        _opendoorLabel.frame = CGRectMake(ScreenWidth /4, ScreenHeight - STHeight(131) + STWidth(60) + STHeight(16), ScreenWidth /2, STFont(16));
        [self addSubview:_opendoorLabel];
    }
    return _opendoorLabel;
}


//切换镜头
-(UIButton *)cutShootBtn{
    if(_cutShootBtn == nil){
        NSString *cutShootStr = @"切换镜头";
        CGSize cutShootSize =  [cutShootStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
        _cutShootBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(20) - cutShootSize.width, STHeight(325), cutShootSize.width, cutShootSize.width)];
        [self addSubview:_cutShootBtn];
        
        UIImageView *cutShootImageView = [[UIImageView alloc]initWithFrame:CGRectMake((cutShootSize.width - STWidth(40))/2, 0, STWidth(40), STWidth(40))];
        cutShootImageView.image = [UIImage imageNamed:@"icon_切换镜头"];
        cutShootImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_cutShootBtn addSubview:cutShootImageView];
        
        UILabel *cutShootLabel = [[UILabel alloc]initWithFont:STFont(14) text:cutShootStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
        cutShootLabel.frame = CGRectMake(0, STWidth(48), cutShootSize.width, STHeight(14));
        [_cutShootBtn addSubview:cutShootLabel];
        [_cutShootBtn addTarget:self action:@selector(onClickCutShootBtn) forControlEvents:UIControlEventTouchUpInside];
        _cutShootBtn.hidden = YES;
    }
    return _cutShootBtn;
}


//静音
-(UIButton *)muteBtn{
    if(_muteBtn == nil){
        NSString *muteStr = @"静音";
        CGSize muteSize =  [@"切换镜头" sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
        _muteBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - STWidth(20) - muteSize.width, STHeight(396), muteSize.width, muteSize.width)];
        [self addSubview:_muteBtn];
        
        UIImageView *muteImageView = [[UIImageView alloc]initWithFrame:CGRectMake((muteSize.width - STWidth(40))/2, 0, STWidth(40), STWidth(40))];
        muteImageView.image = [UIImage imageNamed:@"icon_静音"];
        muteImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_muteBtn addSubview:muteImageView];
        
        UILabel *muteLabel = [[UILabel alloc]initWithFont:STFont(14) text:muteStr textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
        muteLabel.frame = CGRectMake(0, STWidth(48), muteSize.width, STHeight(14));
        [_muteBtn addSubview:muteLabel];
        [_muteBtn addTarget:self action:@selector(onClickMuteBtn) forControlEvents:UIControlEventTouchUpInside];
        _muteBtn.hidden = YES;
    }
    return _muteBtn;
}


//通话计时
-(UILabel *)timeLabel{
    if(_timeLabel == nil){
        _timeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"00:00" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
        _timeLabel.frame = CGRectMake(0, STHeight(465), ScreenWidth, STHeight(16));
        [self addSubview:_timeLabel];
        _timeLabel.hidden = YES;
    }
    return _timeLabel;
}


//模糊层
-(UIToolbar *)toolbar{
    if(_toolbar == nil){
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _toolbar.barStyle = UIBarStyleBlackTranslucent;
        [self addSubview:_toolbar];
        _toolbar.hidden = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickToolBar)];
        [_toolbar addGestureRecognizer:recognizer];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(210))/2, STHeight(164), STWidth(210), STWidth(180))];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"开启门禁"];
        [_toolbar addSubview:imageView];
        
        UILabel *tipLabel = [[UILabel alloc]initWithFont:STFont(24) text:@"门已经打开咯~" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
        tipLabel.frame = CGRectMake(0, STHeight(364), ScreenWidth, STHeight(24));
        [_toolbar addSubview:tipLabel];
    }
    return _toolbar;
}


//点击接听
-(void)onClickAccept{
    if(statu == 0 ){
        [self audioUI];
    }else if(statu == 1){
        [self videoUI];
    }


  
    NSLog(@"点击接听");
}


//点击开门
-(void)onClickOpenDoor{
    NSLog(@"点击开门");
    _toolbar.hidden = NO;
}


//点击拒绝
-(void)onClickReject{
    if(_mViewModel){
        [_mViewModel doReject];
    }
    NSLog(@"点击拒绝");
}


//点击语音接听
-(void)onClickAudioAcceptBtn{
    NSLog(@"点击语音接听");
    [self videoUI];
}


static bool cutshoot = true;
//切换镜头
-(void)onClickCutShootBtn{
    CGRect tempRect = _myView.frame;
    _myView.frame = _otherView.frame;
    _otherView.frame = tempRect;
    if(cutshoot){
        [_displayView bringSubviewToFront:_myView];
    }else{
        [_displayView bringSubviewToFront:_otherView];
    }
    cutshoot = !cutshoot;
    NSLog(@"点击切换镜头");
}

//静音
-(void)onClickMuteBtn{
    NSLog(@"点击静音");
}

//点击模糊层
-(void)onClickToolBar{
    _toolbar.hidden = YES;
}

//语音通话UI
-(void)audioUI{
    _myView.hidden = NO;
    _otherView.hidden = NO;
    _faceImageView.hidden = YES;
    _positionBtn.hidden = YES;
    _audioAcceptBtn.hidden = YES;
    _cutShootBtn.hidden = NO;
    _muteBtn.hidden = NO;
    _timeLabel.hidden = NO;
    
    [_acceptBtn setImage:[UIImage imageNamed:@"icon_转为语音_normal"] forState:UIControlStateNormal];
    [_acceptBtn setImage:[UIImage imageNamed:@"icon_转为语音_pressed"] forState:UIControlStateHighlighted];
    [self setAcceptText:@"转为语音"];
    [self setRejectText:@"挂断"];
    statu = 1;
}

//视频通话UI
-(void)videoUI{
    _myView.hidden = YES;
    _otherView.hidden = YES;
    _faceImageView.hidden = NO;
    _positionBtn.hidden = NO;
    _audioAcceptBtn.hidden = YES;
    _cutShootBtn.hidden = YES;
    _muteBtn.hidden = NO;
    _timeLabel.hidden = NO;
    
    [_acceptBtn setImage:[UIImage imageNamed:@"icon_转为视频"] forState:UIControlStateNormal];
    [_acceptBtn setImage:[UIImage imageNamed:@"icon_转为视频 _pressed"] forState:UIControlStateHighlighted];
    [self setAcceptText:@"转为视频"];
    [self setRejectText:@"挂断"];
    statu = 0;
}

@end
