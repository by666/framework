//
//  AuthUserView.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthUserView.h"
#import "STBuildingLayerView.h"

@interface AuthUserView()

@property(strong, nonatomic)AuthUserViewModel *mViewModel;
@property(strong, nonatomic)UITextField *doorTF;
@property(strong, nonatomic)UIButton *buildingBtn;
@property(strong, nonatomic)UIButton *communityBtn;
@property(strong, nonatomic)UITextField *nameTF;
@property(strong, nonatomic)UITextField *idNumTF;

@end

@implementation AuthUserView

-(instancetype)initWithViewModel:(AuthUserViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self initPart1];
    [self initPart2];
  
    UIButton *nextBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_AUTHUSER_BTN textColor:cwhite backgroundColor:c19 corner:STHeight(25) borderWidth:0 borderColor:nil];
    nextBtn.frame = CGRectMake(STWidth(50), STHeight(513), STWidth(276), STHeight(50));
    [nextBtn addTarget:self action:@selector(onClickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)removeView{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

-(void)initPart1{
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_AUTHUSER_PART1_TITLE textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [MSG_AUTHUSER_PART1_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(16),titleSize.width , STHeight(16));
    [self addSubview:titleLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(47), ScreenWidth, STHeight(171))];
    view.backgroundColor = cwhite;
    [self addSubview:view];
    
    NSArray *titieArray = @[MSG_AUTHUSER_PART1_COMMUNITY,MSG_AUTHUSER_PART1_BUILDING,MSG_AUTHUSER_PART1_DOORNUM];
    for(int i = 0 ; i < [titieArray count] ; i++){
        NSString *title = [titieArray objectAtIndex:i];
        UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:title textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
        CGSize labelSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        label.frame = CGRectMake(STWidth(15), STHeight(20) + STHeight(57) * i, labelSize.width, STHeight(16));
        [view addSubview:label];
    }
    
    for(int i = 0 ; i < [titieArray count] - 1 ; i ++){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(57) * (i+1), ScreenWidth, 1)];
        lineView.backgroundColor = c17;
        [view addSubview:lineView];
    }
    
    
    NSString *communitysStr = @"光明顶";
    _communityBtn = [[UIButton alloc]initWithFont:STFont(16) text:communitysStr textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize communitySize = [communitysStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _communityBtn.frame = CGRectMake(ScreenWidth - STWidth(36) - communitySize.width, 0,communitySize.width, STHeight(57));
    [_communityBtn addTarget:self action:@selector(OnClickCommunityBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_communityBtn];
    
    UIImageView *positionImageView = [[UIImageView alloc]init];
    positionImageView.image = [UIImage imageNamed:@"ic_position"];
    positionImageView.contentMode = UIViewContentModeScaleAspectFill;
    positionImageView.frame = CGRectMake(ScreenWidth - STWidth(15)-STWidth(14), STHeight(19), STWidth(14), STHeight(18));
    positionImageView.userInteractionEnabled = NO;
    [view addSubview:positionImageView];
    
    _buildingBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_AUTHUSER_PART1_BUILDING_HINT textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize buildingSize = [MSG_AUTHUSER_PART1_BUILDING_HINT sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _buildingBtn.frame = CGRectMake(ScreenWidth - STWidth(36) - buildingSize.width, STHeight(57),buildingSize.width, STHeight(57));
    [_buildingBtn addTarget:self action:@selector(OnClickBuildingBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_buildingBtn];
    
    UIImageView *buildingImageView = [[UIImageView alloc]init];
    buildingImageView.image = [UIImage imageNamed:@"ic_bottom_arrow"];
    buildingImageView.contentMode = UIViewContentModeScaleAspectFill;
    buildingImageView.frame = CGRectMake(ScreenWidth - STWidth(15)-STWidth(11), STHeight(82), STWidth(11), STHeight(11));
    buildingImageView.userInteractionEnabled = NO;
    [view addSubview:buildingImageView];
    
    _doorTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _doorTF.placeholder = MSG_AUTHUSER_PART1_DOORNUM_HINT;
    _doorTF.textAlignment = NSTextAlignmentRight;
    _doorTF.frame = CGRectMake(ScreenWidth - STWidth(215), STHeight(114), STWidth(200),  STHeight(57));
    [view addSubview:_doorTF];

}

-(void)initPart2{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_AUTHUSER_PART2_TITLE textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [MSG_AUTHUSER_PART1_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    titleLabel.frame = CGRectMake(STWidth(15), STHeight(234),titleSize.width , STHeight(16));
    [self addSubview:titleLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(265), ScreenWidth, STHeight(171))];
    view.backgroundColor = cwhite;
    [self addSubview:view];
    
    NSArray *titieArray = @[MSG_AUTHUSER_PART2_NAME,MSG_AUTHUSER_PART2_IDENTIFY,MSG_AUTHUSER_PART2_IDNUM];
    for(int i = 0 ; i < [titieArray count] ; i++){
        NSString *title = [titieArray objectAtIndex:i];
        UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:title textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
        CGSize labelSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        label.frame = CGRectMake(STWidth(15), STHeight(20) + STHeight(57) * i, labelSize.width, STHeight(16));
        [view addSubview:label];
    }
    
    for(int i = 0 ; i < [titieArray count] - 1 ; i ++){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(57) * (i+1), ScreenWidth, 1)];
        lineView.backgroundColor = c17;
        [view addSubview:lineView];
    }
    
    _nameTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _nameTF.placeholder = MSG_AUTHUSER_PART2_NAME_HINT;
    _nameTF.textAlignment = NSTextAlignmentRight;
    _nameTF.frame = CGRectMake(ScreenWidth - STWidth(215), 0, STWidth(200),  STHeight(57));
    [view addSubview:_nameTF];
    
    
    _idNumTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _idNumTF.placeholder = MSG_AUTHUSER_PART2_IDNUM_HINT;
    _idNumTF.textAlignment = NSTextAlignmentRight;
    _idNumTF.frame = CGRectMake(ScreenWidth - STWidth(215), STHeight(114), STWidth(200),  STHeight(57));
    [view addSubview:_idNumTF];
}


-(void)OnClickCommunityBtn{
    if(_mViewModel){
        [_mViewModel goCommunityPage];
    }
}

-(void)OnClickBuildingBtn{
    STBuildingLayerView *layerView = [[STBuildingLayerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight) datas:nil];
    [self addSubview:layerView];
}

-(void)onClickNextBtn{
    if(_mViewModel){
        [_mViewModel submitUserInfo];
    }
}


- (void)onKeyboardShow:(NSNotification*)notification{
    if([_idNumTF isFirstResponder]){
        NSDictionary *info = [notification userInfo];
        CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        WS(weakSelf)
        [UIView animateWithDuration:duration animations:^{
            weakSelf.frame = CGRectMake(0, -STHeight(50), ScreenWidth, ContentHeight);
        }];
    }
}

- (void)onKeyboardHidden:(NSNotification*)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    WS(weakSelf)
    [UIView animateWithDuration:duration animations:^{
        weakSelf.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    }];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_doorTF resignFirstResponder];
    [_nameTF resignFirstResponder];
    [_idNumTF resignFirstResponder];
}

@end
