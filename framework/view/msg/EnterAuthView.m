//
//  EnterAuthView.m
//  framework
//
//  Created by 黄成实 on 2018/5/30.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "EnterAuthView.h"
#import "EnterAuthCell.h"
@interface EnterAuthView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)EnterAuthViewModel *mViewModel;
@property(strong, nonatomic)UIImageView *avatarImageView;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)UIView *lineView;
@property(strong, nonatomic)UIButton *agreeBtn;
@property(strong, nonatomic)UIButton *rejectBtn;

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
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    [self addSubview:bgView];
    [STColorUtil setGradientColor:bgView startColor:c30 endColor:c31 director:Top];
    
    [self initTopView];
    [self initBottomView];
    
}

-(void)initTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(23), STHeight(63), STWidth(329), STHeight(275))];
    topView.backgroundColor = cwhite;
    topView.layer.masksToBounds = YES;
    CAShapeLayer *topLayer = [[CAShapeLayer alloc] init];
    topLayer.frame = topView.bounds;
    topLayer.path =  [UIBezierPath bezierPathWithRoundedRect:topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(STHeight(10), STHeight(10))].CGPath;
    topView.layer.mask = topLayer;
    [self addSubview:topView];
    
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(120), STHeight(10), STHeight(90), STHeight(90))];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    if(_mViewModel.model.messageType == CarEnter){
        _avatarImageView.image = [UIImage imageNamed:@"ic_nohead_msg"];
    }else{
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.image = [UIImage imageNamed:@"ic_test1"];
        _avatarImageView.layer.cornerRadius = STHeight(45);
    }
    [topView addSubview:_avatarImageView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STHeight(129), ScreenWidth, STHeight(275-129))];
    _tableView.backgroundColor = cwhite;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentSize = CGSizeMake(ScreenWidth, STHeight(31)*[_mViewModel.datas count]);
    [topView addSubview:_tableView];

}


-(void)initBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(STWidth(23), STHeight(339), STWidth(329), STHeight(155))];
    bottomView.backgroundColor = cwhite;
    bottomView.layer.masksToBounds = YES;
    CAShapeLayer *bottomLayer = [[CAShapeLayer alloc] init];
    bottomLayer.frame = bottomView.bounds;
    bottomLayer.path = [UIBezierPath bezierPathWithRoundedRect:bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(STHeight(10), STHeight(10))].CGPath;
    bottomView.layer.mask = bottomLayer;
    [self addSubview:bottomView];
    
    MessageStatu statu = _mViewModel.model.messageStatu;

    _agreeBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_ENTERAUTH_AGREE_BTN textColor:cwhite backgroundColor:c19 corner:STHeight(22.4) borderWidth:0 borderColor:nil];
    _agreeBtn.frame = CGRectMake(STWidth(89), STHeight(48), STWidth(151), STHeight(45));
    [_agreeBtn addTarget:self action:@selector(onClickAgreeBtn) forControlEvents:UIControlEventTouchUpInside];
    [_agreeBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    [bottomView addSubview:_agreeBtn];
    if(statu == Reject || statu == Granted || statu == Expired){
        [_agreeBtn setTitle:[MessageModel translateStatu:statu] forState:UIControlStateNormal];
        [_agreeBtn setBackgroundColor:c19b];
        _agreeBtn.enabled = NO;
    }
    
    
    _rejectBtn = [[UIButton alloc]initWithFont:STFont(14) text:MSG_ENTERAUTH_REJECT_BTN textColor:c21 backgroundColor:cclear corner:0 borderWidth:0 borderColor:nil];
    _rejectBtn.frame = CGRectMake(STWidth(109), STHeight(93), STWidth(111), STHeight(45));
    [_rejectBtn addTarget:self action:@selector(onClickRejectBtn) forControlEvents:UIControlEventTouchUpInside];
    _rejectBtn.hidden = YES;
    [bottomView addSubview:_rejectBtn];
    if(statu == DefaultStatu){
        _rejectBtn.hidden = NO;
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_mViewModel.datas count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(16);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return STHeight(15);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self lineView];
}


-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = cwhite;
    }
    return _lineView;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EnterAuthCell *cell = [tableView dequeueReusableCellWithIdentifier:[EnterAuthCell identify]];
    if(!cell){
        cell = [[EnterAuthCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EnterAuthCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    TitleContentModel *model = [_mViewModel.datas objectAtIndex:indexPath.section];
    [cell updateData:model];
    return cell;
}


-(void)onClickAgreeBtn{
    if(_mViewModel){
        [_mViewModel doAgree];
    }
}

-(void)onClickRejectBtn{
    if(_mViewModel){
        [_mViewModel doReject];
    }
}

@end
