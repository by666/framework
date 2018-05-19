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

@interface AddMemberView()

@property(strong, nonatomic) AddMemberViewModel *mViewModel;
@property(strong, nonatomic)MemberModel *memeberModel;
@property(strong, nonatomic) UIButton *takePhotoBTN;
@property(strong, nonatomic) UITextField *nameTextField;
@property(strong, nonatomic) UITextField *idNumTextField;
@property(strong, nonatomic) UILabel *errorLabel;


@end

@implementation AddMemberView

-(instancetype)initWithViewModel:(AddMemberViewModel *)viewModel memberModel:(MemberModel *)memberModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        _memeberModel = memberModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.userInteractionEnabled = YES;
    
    UILabel *tipsLabel = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ADDMEMBER_TIPS textAlignment:NSTextAlignmentCenter textColor:c20 backgroundColor:nil multiLine:NO];
    tipsLabel.frame = CGRectMake(0, STHeight(28), ScreenWidth, STHeight(14));
    [self addSubview:tipsLabel];
    
    _takePhotoBTN = [[UIButton alloc]initWithFont:STFont(14) text:MSG_ADDMEMBER_TAKEPHOTO textColor:c12 backgroundColor:cwhite corner:STHeight(57) borderWidth:0 borderColor:nil];
    _takePhotoBTN.frame = CGRectMake(STWidth(131), STHeight(70), STHeight(114), STHeight(114));
    _takePhotoBTN.titleLabel.numberOfLines = 0;
    _takePhotoBTN.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _takePhotoBTN.titleLabel.textAlignment = NSTextAlignmentCenter;
    _takePhotoBTN.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_takePhotoBTN addTarget:self action:@selector(OnClickTakePhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_takePhotoBTN];
    
    if(_memeberModel && !IS_NS_STRING_EMPTY(_memeberModel.avatarUrl)){
        UIImage *image = [UIImage imageWithContentsOfFile:_memeberModel.avatarUrl];
        [_takePhotoBTN setImage:image forState:UIControlStateNormal];
    }
    
    UILabel *tips2Label = [[UILabel alloc]initWithFont:STFont(14) text:MSG_ADDMEMBER_TIPS2 textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    tips2Label.frame = CGRectMake(STWidth(15), STHeight(237), ScreenWidth - STWidth(30), STHeight(14));
    [self addSubview:tips2Label];

    
    UIView *editView=  [[UIView alloc]init];
    editView.frame = CGRectMake(0, STHeight(268), ScreenWidth, STHeight(114));
    editView.backgroundColor = cwhite;
    editView.userInteractionEnabled = YES;
    [self addSubview:editView];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, STHeight(1))];
    topLine.backgroundColor = c17;
    [editView addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(113), ScreenWidth, STHeight(1))];
    bottomLine.backgroundColor = c17;
    [editView addSubview:bottomLine];
    
    UIView *centerLine = [[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(57), ScreenWidth - STWidth(30), STHeight(1))];
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
    _nameTextField.frame = CGRectMake(STWidth(175), 0  ,ScreenWidth - STWidth(190), STHeight(57));
    _nameTextField.textAlignment = NSTextAlignmentRight;
    [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [editView addSubview:_nameTextField];
    if(_memeberModel && !IS_NS_STRING_EMPTY(_memeberModel.name)){
        _nameTextField.text = _memeberModel.name;
    }
    
    
    _idNumTextField = [[UITextField alloc]init];
    _idNumTextField.font = [UIFont systemFontOfSize:STFont(16)];
    _idNumTextField.textColor = c12;
    _idNumTextField.frame = CGRectMake(STWidth(175), STHeight(57),  ScreenWidth - STWidth(190), STHeight(57));
    _idNumTextField.textAlignment = NSTextAlignmentRight;
    [_idNumTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [editView addSubview:_idNumTextField];
    
    if(_memeberModel && !IS_NS_STRING_EMPTY(_memeberModel.idNum)){
        _idNumTextField.text = _memeberModel.idNum;
    }
    
    _errorLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentLeft textColor:c18 backgroundColor:nil multiLine:NO];
    _errorLabel.frame = CGRectMake(STWidth(15), STHeight(392), ScreenWidth - STWidth(30), STHeight(12));
    [self addSubview:_errorLabel];
}

-(void)OnClickTakePhotoBtn{
    if(_mViewModel){
        [_mViewModel doTakePhoto];
    }
}

-(void)updateView:(NSString *)imagePath{
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    [_takePhotoBTN setImage:image forState:UIControlStateNormal];
}

- (void)textFieldDidChange:(UITextField *)textField{
    UITextRange * selectedRange = textField.markedTextRange;
    if(selectedRange == nil || selectedRange.empty){
        NSInteger maxLength = 0;
        if(textField == _nameTextField){
            maxLength = 20;
        }
        if(textField == _idNumTextField){
            maxLength = 18;
        }
        NSString *text = textField.text;
        if(text.length >= maxLength){
            textField.text = [text substringWithRange: NSMakeRange(0, maxLength)];
        }
    }
}


-(void)saveMember{
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
    _mViewModel.model.name = _nameTextField.text;
    _mViewModel.model.idNum = _idNumTextField.text;
    _mViewModel.model.uid = [STTimeUtil getCurrentTimeStamp];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"head.jpg"];
    _mViewModel.model.avatarUrl = imageFilePath;
    
    _errorLabel.text = @"";
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [_mViewModel addMemberModel];
}

-(void)deleteMember{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [_mViewModel deleteMemberModel:_memeberModel];

}

-(MemberModel *)getCurrentModel{
    _memeberModel.name = _nameTextField.text;
    _memeberModel.idNum = _idNumTextField.text;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"head.jpg"];
    _memeberModel.avatarUrl = imageFilePath;
    return _memeberModel;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_idNumTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
}
@end
