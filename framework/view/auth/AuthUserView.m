//
//  AuthUserView.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthUserView.h"
#import "STBuildingLayerView.h"
#import "STSinglePickerLayerView.h"
#import "STRecognizeView.h"
#import "RecognizeModel.h"

@interface AuthUserView()<STBuildingLayerViewDelegate,STSinglePickerLayerViewDelegate,UITextFieldDelegate,STRecognizeViewDelegate>

@property(strong, nonatomic)AuthUserViewModel *mViewModel;
@property(strong, nonatomic)UITextField *doorTF;
@property(strong, nonatomic)UIButton *buildingBtn;
@property(strong, nonatomic)UIButton *communityBtn;
@property(strong, nonatomic)UITextField *nameTF;
@property(strong, nonatomic)UITextField *idNumTF;
@property(strong, nonatomic)STBuildingLayerView *buildingLayerView;
@property(strong, nonatomic)UIButton *identifyBtn;
@property(strong, nonatomic)STSinglePickerLayerView *identifyLayerView;
@property(strong, nonatomic)UILabel *tipsLabel;
@property(strong, nonatomic)STRecognizeView *recognizeView;

@property(strong, nonatomic)UIView *part2View;

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
    [nextBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
    [self addSubview:nextBtn];
    
    _tipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentLeft textColor:c18 backgroundColor:nil multiLine:NO];
    _tipsLabel.frame = CGRectMake(STWidth(15), STHeight(450), ScreenWidth - STWidth(30), STHeight(12));
    [self addSubview:_tipsLabel];
    
    [self addSubview:[self identifyLayerView]];

    _recognizeView = [[STRecognizeView alloc]initWithTitle:MSG_AUTHUSER_RECOGNIZE_TITLE datas:nil];
    _recognizeView.delegate = self;
    _recognizeView.hidden = YES;
    [self addSubview:_recognizeView];
    
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
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(57) * (i+1), ScreenWidth, LineHeight)];
        lineView.backgroundColor = c17;
        [view addSubview:lineView];
    }
    
    
    _communityBtn = [[UIButton alloc]initWithFont:STFont(16) text:@"" textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize communitySize = [@""  sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
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
    buildingImageView.image = [UIImage imageNamed:@"ic_arrow_bottom"];
    buildingImageView.contentMode = UIViewContentModeScaleAspectFill;
    buildingImageView.frame = CGRectMake(ScreenWidth - STWidth(15)-STWidth(11), STHeight(82), STWidth(11), STHeight(11));
    buildingImageView.userInteractionEnabled = NO;
    [view addSubview:buildingImageView];
    
    _doorTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    [_doorTF setPlaceholder:MSG_AUTHUSER_PART1_DOORNUM_HINT color:c17 fontSize:STFont(16)];
    _doorTF.textAlignment = NSTextAlignmentRight;
    _doorTF.keyboardType = UIKeyboardTypeNumberPad;
    _doorTF.frame = CGRectMake(ScreenWidth - STWidth(215), STHeight(114), STWidth(200),  STHeight(57));
    _doorTF.delegate = self;
    [view addSubview:_doorTF];

}

-(void)initPart2{
    
    _part2View = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(218 - 57 * 2), ScreenWidth, ContentHeight-STHeight(218))];
    _part2View.backgroundColor = c15;
    [self addSubview:_part2View];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_AUTHUSER_PART2_TITLE textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    CGSize titleSize = [MSG_AUTHUSER_PART1_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    titleLabel.frame = CGRectMake(STWidth(15),0,titleSize.width , STHeight(47));
    [_part2View addSubview:titleLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(47), ScreenWidth, STHeight(171))];
    view.backgroundColor = cwhite;
    [_part2View addSubview:view];
    
    NSArray *titieArray = @[MSG_AUTHUSER_PART2_NAME,MSG_AUTHUSER_PART2_IDENTIFY,MSG_AUTHUSER_PART2_IDNUM];
    for(int i = 0 ; i < [titieArray count] ; i++){
        NSString *title = [titieArray objectAtIndex:i];
        UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:title textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
        CGSize labelSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        label.frame = CGRectMake(STWidth(15), STHeight(20) + STHeight(57) * i, labelSize.width, STHeight(16));
        [view addSubview:label];
    }
    
    for(int i = 0 ; i < [titieArray count] - 1 ; i ++){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(57) * (i+1), ScreenWidth, LineHeight)];
        lineView.backgroundColor = c17;
        [view addSubview:lineView];
    }
    
    _nameTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    [_nameTF setPlaceholder:MSG_AUTHUSER_PART2_NAME_HINT color:c17 fontSize:STFont(16)];
    _nameTF.textAlignment = NSTextAlignmentRight;
    _nameTF.frame = CGRectMake(ScreenWidth - STWidth(215), 0, STWidth(200),  STHeight(57));
    [view addSubview:_nameTF];
    
    
    _mViewModel.data.identify = MSG_AUTHUSER_PART2_IDENTIFY_DEFAULT;
    _identifyBtn = [[UIButton alloc]initWithFont:STFont(16) text:_mViewModel.data.identify textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil];
    CGSize buildingSize = [MSG_AUTHUSER_PART1_BUILDING_HINT sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _identifyBtn.frame = CGRectMake(ScreenWidth - STWidth(36) - buildingSize.width, STHeight(57),buildingSize.width, STHeight(57));
    [_identifyBtn addTarget:self action:@selector(OnClickIdentifyBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_identifyBtn];
    
    UIImageView *identifyImageView = [[UIImageView alloc]init];
    identifyImageView.image = [UIImage imageNamed:@"ic_arrow_bottom"];
    identifyImageView.contentMode = UIViewContentModeScaleAspectFill;
    identifyImageView.frame = CGRectMake(ScreenWidth - STWidth(15)-STWidth(11), STHeight(82), STWidth(11), STHeight(11));
    identifyImageView.userInteractionEnabled = NO;
    [view addSubview:identifyImageView];
    
    
    _idNumTF = [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    [_idNumTF setPlaceholder:MSG_AUTHUSER_PART2_IDNUM_HINT color:c17 fontSize:STFont(16)];
    _idNumTF.textAlignment = NSTextAlignmentRight;
    _idNumTF.frame = CGRectMake(ScreenWidth - STWidth(215), STHeight(114), STWidth(200),  STHeight(57));
    [view addSubview:_idNumTF];
    
}


-(STBuildingLayerView *)buildingLayerView:(id)data level:(int)level{
    if(_buildingLayerView == nil){
        _buildingLayerView = [[STBuildingLayerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight) data:data level:level];
        _buildingLayerView.delegate = self;
        _buildingLayerView.hidden = YES;
    }
    return _buildingLayerView;
}

-(STSinglePickerLayerView *)identifyLayerView{
    if(_identifyLayerView == nil){
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        [datas addObject:MSG_AUTHUSER_PART2_IDENTIFY_DEFAULT];
        [datas addObject:MSG_AUTHUSER_PART2_IDENTIFY_MEMBER];
        [datas addObject:MSG_AUTHUSER_PART2_IDENTIFY_RENTER];
        _identifyLayerView = [[STSinglePickerLayerView alloc]initWithDatas:datas];
        _identifyLayerView.delegate = self;
        _identifyLayerView.hidden = YES;
    }
    return _identifyLayerView;
}

-(void)OnClickCommunityBtn{
    if(_mViewModel){
        [_mViewModel goCommunityPage];
    }
    [self hideKeyboard];
}

-(void)OnClickBuildingBtn{
    _buildingLayerView.hidden = NO;
    [self hideKeyboard];
}

-(void)OnClickIdentifyBtn{
    _identifyLayerView.hidden = NO;
    [_identifyLayerView setData:_mViewModel.data.identify];
    [self hideKeyboard];
}

-(void)onClickNextBtn{
    if(_mViewModel){
        _mViewModel.data.doorNum = _doorTF.text;
        _mViewModel.data.name = _nameTF.text;
        _mViewModel.data.idNum = _idNumTF.text;
        NSString *communityName = _communityBtn.titleLabel.text;
        if([communityName isEqualToString:MSG_AUTHUSER_POSITION_ERROR] || IS_NS_STRING_EMPTY(communityName)){
            _mViewModel.data.communityName = @"";
        }else{
            _mViewModel.data.communityName = _communityBtn.titleLabel.text;
        }
        [_mViewModel submitUserInfo];
    }
    [self hideKeyboard];
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


-(void)hideKeyboard{
    [_doorTF resignFirstResponder];
    [_nameTF resignFirstResponder];
    [_idNumTF resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideKeyboard];
}


-(void)onSelectResult:(NSString *)result{
    if ([result isEqualToString:MSG_AUTHUSER_PART2_IDENTIFY_DEFAULT]) {
        _mViewModel.userCommitModel.liveAttr = [NSString stringWithFormat:@"%ld",Live_Owner];
    }else if([result isEqualToString:MSG_AUTHUSER_PART2_IDENTIFY_MEMBER]){
        _mViewModel.userCommitModel.liveAttr = [NSString stringWithFormat:@"%ld",Live_Member];
    }else if([result isEqualToString:MSG_AUTHUSER_PART2_IDENTIFY_RENTER]){
        _mViewModel.userCommitModel.liveAttr = [NSString stringWithFormat:@"%ld",Live_Renter];
    }
    _mViewModel.data.identify = result;
    CGSize buildingSize = [MSG_AUTHUSER_PART1_BUILDING_HINT sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _identifyBtn.frame = CGRectMake(ScreenWidth - STWidth(36) - buildingSize.width, STHeight(57),buildingSize.width, STHeight(57));
    [_identifyBtn setTitle:result forState:UIControlStateNormal];

}

-(void)onSubmitResult:(Boolean)success errorMsg:(NSString *)errorMsg{
    if(success){
        _tipsLabel.text = @"";
    }else{
        _tipsLabel.text = errorMsg;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == _doorTF){
        if(IS_NS_STRING_EMPTY(textField.text)){
            return;
        }
        if(_mViewModel){
            [_mViewModel getCommunityDoor:textField.text];
        }
     
    }
}


-(void)updateDoorDatas:(NSMutableArray *)datas{
    [_recognizeView setData:datas];
    _recognizeView.hidden = NO;
}

-(void)onSelectRecognizeResult:(RecognizeModel *)result{
    _doorTF.text = result.homeName;
    _mViewModel.userCommitModel.homeLocator = result.homeLocator;
}

-(void)updateAddress:(NSString *)addressStr{
    [_communityBtn setTitle:addressStr forState:UIControlStateNormal];
    CGSize communitySize = [addressStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _communityBtn.frame = CGRectMake(ScreenWidth - STWidth(36) - communitySize.width, 0,communitySize.width, STHeight(57));
    
    if([addressStr isEqualToString:MSG_AUTHUSER_POSITION_ERROR]){
        WS(weakSelf)
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.part2View.frame = CGRectMake(0, STHeight(218 - 57 * 2), ScreenWidth, ContentHeight-STHeight(218));
        }];
    }else{
        WS(weakSelf)
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.part2View.frame = CGRectMake(0, STHeight(218 - 57), ScreenWidth, ContentHeight-STHeight(218));
        }];
    }
}


-(void)updateBuildLayerView:(id)data level:(int)level{
    [_buildingBtn setTitle:MSG_AUTHUSER_PART1_BUILDING_HINT forState:UIControlStateNormal];
    CGSize buildingSize = [MSG_AUTHUSER_PART1_BUILDING_HINT sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _buildingBtn.frame = CGRectMake(ScreenWidth - STWidth(36) - buildingSize.width, STHeight(57),buildingSize.width, STHeight(57));
    
    [_buildingLayerView removeFromSuperview];
    _buildingLayerView = nil;
    [self addSubview: [self buildingLayerView:data level:level]];
}

-(void)OnBuildingSelectResult:(NSString *)result fatherLocator:(NSString *)fatherLocator{
    _mViewModel.data.building = result;
    _mViewModel.fatherLocator = fatherLocator;
    CGSize buildingSize = [result sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _buildingBtn.frame = CGRectMake(ScreenWidth - STWidth(36) - buildingSize.width, STHeight(57),buildingSize.width, STHeight(57));
    [_buildingBtn setTitle:result forState:UIControlStateNormal];
    
    WS(weakSelf)
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.part2View.frame = CGRectMake(0, STHeight(218), ScreenWidth, ContentHeight-STHeight(218));
    }];
}

@end
