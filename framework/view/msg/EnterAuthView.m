//
//  EnterAuthView.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "EnterAuthView.h"
#import "EnterAuthCell.h"
@interface EnterAuthView()

@property(strong, nonatomic)EnterAuthViewModel *mViewModel;
@property(strong, nonatomic)UIImageView *avatarImageView;
@property(strong, nonatomic)UIButton *agreeBtn;
@property(strong, nonatomic)UIButton *rejectBtn;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *positionLabel;
@property(strong, nonatomic)UILabel *timeLabel;

@end


@implementation EnterAuthView

-(instancetype)initWithViewModel:(EnterAuthViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initTopView];
    [self initBottomView];
    
}

-(void)initTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(10),ScreenWidth, STHeight(130))];
    topView.backgroundColor = cwhite;
    topView.layer.masksToBounds = YES;
    [self addSubview:topView];
    
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(16), STHeight(70), STHeight(70))];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    if(!IS_NS_STRING_EMPTY(_mViewModel.model.licenseNum)){
        _avatarImageView.image = [UIImage imageNamed:@"ic_nohead_msg"];
    }else{
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.image = [UIImage imageNamed:@"ic_head"];
        _avatarImageView.layer.cornerRadius = STHeight(35);
    }
    [topView addSubview:_avatarImageView];
    
    _nameLabel = [[UILabel alloc]initWithFont:STFont(17) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    _nameLabel.frame = CGRectMake(STWidth(15), STHeight(96), STHeight(70), STHeight(17));
    [topView addSubview:_nameLabel];
    
    UILabel *positionTitleLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"当前位置:" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    CGSize ptSize = [positionTitleLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    positionTitleLabel.frame = CGRectMake(STWidth(100), STHeight(20), ptSize.width, STHeight(12));
    [topView addSubview:positionTitleLabel];
    
    _positionLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [topView addSubview:_positionLabel];
    
    UILabel *timeTitleLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"拜访时间:" textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    CGSize ttSize = [positionTitleLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(12)]];
    timeTitleLabel.frame = CGRectMake(STWidth(100), STHeight(70), ttSize.width, STHeight(12));
    [topView addSubview:timeTitleLabel];
    
    _timeLabel = [[UILabel alloc]initWithFont:STFont(16) text:@"" textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    [topView addSubview:_timeLabel];

}


-(void)initBottomView{

    
    MessageStatu statu = _mViewModel.model.applyState;
    
    _agreeBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_ENTERAUTH_AGREE_BTN textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _agreeBtn.frame = CGRectMake((ScreenWidth - STWidth(150))/2, ContentHeight - STHeight(130), STWidth(150), STHeight(50));
    [_agreeBtn addTarget:self action:@selector(onClickAgreeBtn) forControlEvents:UIControlEventTouchUpInside];
    [_agreeBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [self addSubview:_agreeBtn];
    if(statu == Reject || statu == Granted || statu == Expired){
        [_agreeBtn setTitle:[MessageModel translateStatu:_mViewModel.model.applyState overdueDate:_mViewModel.model.overdueDate] forState:UIControlStateNormal];
        [_agreeBtn setBackgroundColor:c12];
        _agreeBtn.enabled = NO;
    }
    
    
    _rejectBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_ENTERAUTH_REJECT_BTN textColor:c08 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    _rejectBtn.frame = CGRectMake(STWidth(112), ContentHeight - STHeight(64), STWidth(151), STHeight(24));
    [_rejectBtn addTarget:self action:@selector(onClickRejectBtn) forControlEvents:UIControlEventTouchUpInside];
    _rejectBtn.hidden = YES;
    [self addSubview:_rejectBtn];
    if(statu == DefaultStatu){
        _rejectBtn.hidden = NO;
    }
    
}







-(void)onClickAgreeBtn{
    if(_mViewModel){
        [_mViewModel doAgree:Granted];
    }
}

-(void)onClickRejectBtn{
    if(_mViewModel){
        [_mViewModel doAgree:Reject];
    }
}

-(void)updateView{
    _nameLabel.text = _mViewModel.model.userName;
    _positionLabel.text = @"小区大门门禁处";
    CGSize pSize = [_positionLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _positionLabel.frame = CGRectMake(STWidth(100), STHeight(40), pSize.width, STHeight(16));
    
    _timeLabel.text = _mViewModel.model.modifyTime;
    CGSize tSize = [_timeLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _timeLabel.frame = CGRectMake(STWidth(100), STHeight(90), tSize.width, STHeight(16));
    
    [_avatarImageView sd_setImageWithURL:[[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:_mViewModel.faceUrl] placeholderImage:[UIImage imageNamed:@"ic_head"]];
}

@end
