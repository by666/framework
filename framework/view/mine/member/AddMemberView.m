//
//  AddMemberView.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddMemberView.h"
#import "AddMemberViewModel.h"
#import "STTimeUtil.h"
#import "AccountManager.h"
#import <SDWebImage/UIButton+WebCache.h>
@interface AddMemberView()

@property(strong, nonatomic) AddMemberViewModel *mViewModel;
@property(strong, nonatomic) UIButton *takePhotoBTN;
@property(strong, nonatomic) UITextField *nameTextField;
@property(strong, nonatomic) UITextField *idNumTextField;
@property(strong, nonatomic) UILabel *errorLabel;


@end

@implementation AddMemberView{
    
}

-(instancetype)initWithViewModel:(AddMemberViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.userInteractionEnabled = YES;
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ADDMEMBER_TIPS textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    tipsLabel.frame = CGRectMake(0, STHeight(28), ScreenWidth, STHeight(14));
    [self addSubview:tipsLabel];
    
    
    _takePhotoBTN = [[UIButton alloc]initWithFont:STFont(30) text:@"" textColor:c12 backgroundColor:cwhite corner:STHeight(70) borderWidth:3.25f borderColor:c22];
    _takePhotoBTN.frame = CGRectMake((ScreenWidth - STHeight(140))/2, STHeight(82), STHeight(140), STHeight(140));
    _takePhotoBTN.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_takePhotoBTN addTarget:self action:@selector(OnClickTakePhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_takePhotoBTN];
    
    UILabel *layerLabel= [[UILabel alloc]initWithFont:STFont(17) text:@"+" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:[c13 colorWithAlphaComponent:0.6f] multiLine:NO];
    layerLabel.frame = CGRectMake(0, STHeight(101), STHeight(140), STHeight(39));
    [_takePhotoBTN addSubview:layerLabel];
    _takePhotoBTN.clipsToBounds = YES;
    
    
    if(_mViewModel.model && !IS_NS_STRING_EMPTY(_mViewModel.model.faceUrl)){
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:_mViewModel.model.faceUrl];
        [_takePhotoBTN sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_default"]];
    }
    
    UILabel *tips2Label = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ADDMEMBER_TIPS2 textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    tips2Label.frame = CGRectMake(STWidth(15), STHeight(277), ScreenWidth - STWidth(30), STHeight(14));
    [self addSubview:tips2Label];

    
    UIView *editView=  [[UIView alloc]init];
    editView.frame = CGRectMake(0, STHeight(308), ScreenWidth, STHeight(114));
    editView.backgroundColor = cwhite;
    editView.userInteractionEnabled = YES;
    [self addSubview:editView];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, LineHeight)];
    topLine.backgroundColor = c17;
    [editView addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(114) - LineHeight, ScreenWidth,LineHeight)];
    bottomLine.backgroundColor = c17;
    [editView addSubview:bottomLine];
    
    UIView *centerLine = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(57), ScreenWidth - STWidth(30), LineHeight)];
    centerLine.backgroundColor = c17;
    [editView addSubview:centerLine];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_ADDMEMBER_NAME textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    nameLabel.frame = CGRectMake(STWidth(15), STHeight(21) , STWidth(100), STHeight(16));
    [editView addSubview:nameLabel];
    

    UILabel *idNumLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_ADDMEMBER_IDNUM textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    idNumLabel.frame = CGRectMake(STWidth(15),STHeight(78) , STWidth(160), STHeight(16));
    [editView addSubview:idNumLabel];
    
    _nameTextField = [[UITextField alloc]init];
    _nameTextField.font = [UIFont systemFontOfSize:STFont(16)];
    _nameTextField.textColor = c12;
    [_nameTextField setPlaceholder:MSG_ADDMEMBER_NAME_TIPS color:c17 fontSize:STFont(16)];
    _nameTextField.frame = CGRectMake(STWidth(175), 0  ,ScreenWidth - STWidth(190), STHeight(57));
    _nameTextField.textAlignment = NSTextAlignmentRight;
    [_nameTextField setMaxLength:@"20"];
    [editView addSubview:_nameTextField];
    if(_mViewModel.model && !IS_NS_STRING_EMPTY(_mViewModel.model.nickname)){
        _nameTextField.text = _mViewModel.model.nickname;
    }
    
    
    _idNumTextField = [[UITextField alloc]init];
    _idNumTextField.font = [UIFont systemFontOfSize:STFont(16)];
    _idNumTextField.textColor = c12;
    _idNumTextField.frame = CGRectMake(STWidth(175), STHeight(57),  ScreenWidth - STWidth(190), STHeight(57));
    _idNumTextField.textAlignment = NSTextAlignmentRight;
    [_idNumTextField setPlaceholder:MSG_ADDMEMBER_IDNUM_TIPS color:c17 fontSize:STFont(16)];
    [_idNumTextField setMaxLength:@"18"];
    [editView addSubview:_idNumTextField];
    
    if(_mViewModel.model && !IS_NS_STRING_EMPTY(_mViewModel.model.creid)){
        _idNumTextField.text = _mViewModel.model.creid;
    }
    
    _errorLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentLeft textColor:c18 backgroundColor:nil multiLine:NO];
    _errorLabel.frame = CGRectMake(STWidth(15), STHeight(442), ScreenWidth - STWidth(30), STHeight(12));
    [self addSubview:_errorLabel];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)removeView{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}


-(void)OnClickTakePhotoBtn{
    if(_mViewModel){
        [_mViewModel doTakePhoto];
    }
}

-(void)updateView:(NSString *)imagePath{
    _mViewModel.model.facePath = imagePath;
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    [_takePhotoBTN setImage:image forState:UIControlStateNormal];
}


-(void)saveMember{
    [_idNumTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
    if(IS_NS_STRING_EMPTY(_nameTextField.text)){
        _errorLabel.text = MSG_ADDMEMBER_NAME_ERROR;
        return;
    }
    if(![STPUtil isIdNumberValid:_idNumTextField.text]){
        _errorLabel.text = MSG_ADDMEMBER_IDNUM_ERROR;
        return;
    }
    if(_takePhotoBTN.imageView.image == nil){
        _errorLabel.text = MSG_ADDMEMBER_AVATAR_ERROR;
        return;
    }
    _mViewModel.model.nickname = _nameTextField.text;
    _mViewModel.model.creid = _idNumTextField.text;
    _mViewModel.model.userUid = [[AccountManager sharedAccountManager]getUserModel].userUid;
    _errorLabel.text = @"";
    [_mViewModel addMemberModel];
}

-(MemberModel *)getCurrentModel{
    _mViewModel.model.nickname = _nameTextField.text;
    _mViewModel.model.creid = _idNumTextField.text;
    return _mViewModel.model;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_idNumTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
}

- (void)onKeyboardShow:(NSNotification*)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    WS(weakSelf)
    [UIView animateWithDuration:duration animations:^{
        weakSelf.frame = CGRectMake(0,  ScreenHeight - STHeight(424)  -  KeyBorodHeight, ScreenWidth, ContentHeight);
    }];

}

- (void)onKeyboardHidden:(NSNotification*)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    WS(weakSelf)
    [UIView animateWithDuration:duration animations:^{
        weakSelf.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    }];
}
@end
