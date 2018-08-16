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
@property(strong, nonatomic)UIView *layerView;
@property(strong, nonatomic)UIImageView *addImageView;
@property(strong, nonatomic)UITextField *nameTextField;
@property(strong, nonatomic)UITextField *idNumTextField;
@property(strong, nonatomic)UILabel *errorLabel;
@property(strong, nonatomic)UILabel *faceTipsLabel;


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
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_ADDMEMBER_TIPS textAlignment:NSTextAlignmentCenter textColor:c11 backgroundColor:nil multiLine:NO];
    tipsLabel.frame = CGRectMake(0, STHeight(28), ScreenWidth, STHeight(16));
    [self addSubview:tipsLabel];
    
    
    _takePhotoBTN = [[UIButton alloc]initWithFont:STFont(30) text:@"" textColor:c12 backgroundColor:c36 corner:STWidth(85) borderWidth:0 borderColor:nil];
    _takePhotoBTN.frame = CGRectMake((ScreenWidth - STWidth(170))/2, STHeight(64), STWidth(170), STWidth(170));
    _takePhotoBTN.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_takePhotoBTN addTarget:self action:@selector(OnClickTakePhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_takePhotoBTN];
    
    _addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(58), STHeight(63), STWidth(54), STHeight(44))];
    _addImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addImageView.image = [UIImage imageNamed:@"用户认证_icon_相机大"];
    _addImageView.userInteractionEnabled = NO;
    [_takePhotoBTN addSubview:_addImageView];
    
    _layerView= [[UIView alloc]init];
    _layerView.hidden = YES;
    _layerView.userInteractionEnabled = NO;
    _layerView.backgroundColor = [c35 colorWithAlphaComponent:0.6f];
    _layerView.frame = CGRectMake(0, STWidth(122), STWidth(170), STWidth(48));
    [_takePhotoBTN addSubview:_layerView];
    
    UIImageView *layerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STWidth(73), STHeight(12), STWidth(24), STWidth(24))];
    layerImageView.image = [UIImage imageNamed:@"用户认证_icon_相机大"];
    layerImageView.userInteractionEnabled = NO;
    layerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_layerView addSubview:layerImageView];
    
    _takePhotoBTN.clipsToBounds = YES;
    
    _faceTipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ADDMEMBER_FACE_TIPS textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    _faceTipsLabel.frame = CGRectMake(0, STHeight(254), ScreenWidth, STHeight(14));
    [self addSubview:_faceTipsLabel];
    
    
    
    

    
    UIView *editView=  [[UIView alloc]init];
    editView.frame = CGRectMake(0, STHeight(298), ScreenWidth, STHeight(168));
    editView.backgroundColor = cwhite;
    editView.userInteractionEnabled = YES;
    [self addSubview:editView];
    
    
    UILabel *editLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_ADDMEMBER_TIPS2 textAlignment:NSTextAlignmentCenter textColor:c12 backgroundColor:nil multiLine:NO];
    CGSize editSize = [MSG_ADDMEMBER_TIPS2 sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    editLabel.frame = CGRectMake(STWidth(15), 0, editSize.width, STHeight(52));
    [editView addSubview:editLabel];
    

    
    UILabel *nameLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_ADDMEMBER_NAME textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    nameLabel.frame = CGRectMake(STWidth(15), STHeight(74) , STWidth(100), STHeight(16));
    [editView addSubview:nameLabel];
    

    UILabel *idNumLabel = [[UILabel alloc]initWithFont:STFont(16) text:MSG_ADDMEMBER_IDNUM textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
    idNumLabel.frame = CGRectMake(STWidth(15),STHeight(132) , STWidth(160), STHeight(16));
    [editView addSubview:idNumLabel];
    
    _nameTextField = [[UITextField alloc]init];
    _nameTextField.font = [UIFont systemFontOfSize:STFont(16)];
    _nameTextField.textColor = c12;
    [_nameTextField setPlaceholder:MSG_ADDMEMBER_NAME_TIPS color:c17 fontSize:STFont(16)];
    _nameTextField.frame = CGRectMake(STWidth(175), STHeight(52) ,ScreenWidth - STWidth(190), STHeight(57));
    _nameTextField.textAlignment = NSTextAlignmentRight;
    [_nameTextField setMaxLength:@"20"];
    [editView addSubview:_nameTextField];
    if(_mViewModel.model && !IS_NS_STRING_EMPTY(_mViewModel.model.nickname)){
        _nameTextField.text = _mViewModel.model.nickname;
    }
    
    
    _idNumTextField = [[UITextField alloc]init];
    _idNumTextField.font = [UIFont systemFontOfSize:STFont(16)];
    _idNumTextField.textColor = c12;
    _idNumTextField.frame = CGRectMake(STWidth(175), STHeight(110),  ScreenWidth - STWidth(190), STHeight(57));
    _idNumTextField.textAlignment = NSTextAlignmentRight;
    [_idNumTextField setPlaceholder:MSG_ADDMEMBER_IDNUM_TIPS color:c17 fontSize:STFont(16)];
    [_idNumTextField setMaxLength:@"18"];
    [editView addSubview:_idNumTextField];
    
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, STWidth(52)-LineHeight, ScreenWidth, LineHeight)];
    topLine.backgroundColor = cline;
    [editView addSubview:topLine];
    
    UIView *centerLine = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(111) - LineHeight, ScreenWidth,LineHeight)];
    centerLine.backgroundColor = cline;
    [editView addSubview:centerLine];
    
    if(_mViewModel.model && !IS_NS_STRING_EMPTY(_mViewModel.model.creid)){
        _idNumTextField.text = _mViewModel.model.creid;
    }
    
    _errorLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentLeft textColor:c07 backgroundColor:nil multiLine:NO];
    _errorLabel.frame = CGRectMake(STWidth(15), STHeight(485), ScreenWidth - STWidth(30), STHeight(12));
    [self addSubview:_errorLabel];

    
    if(_mViewModel.model && !IS_NS_STRING_EMPTY(_mViewModel.model.faceUrl)){
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil] getRealUrl:_mViewModel.model.faceUrl];
        [_takePhotoBTN sd_setImageWithURL:url forState:UIControlStateNormal];
        _layerView.hidden = NO;
        _addImageView.hidden = YES;
    }
    
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
    _layerView.hidden = NO;
    _addImageView.hidden = YES;
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
        weakSelf.frame = CGRectMake(0,  ScreenHeight - STHeight(466)  -  KeyBorodHeight, ScreenWidth, ContentHeight);
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
