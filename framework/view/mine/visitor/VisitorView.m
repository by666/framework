//
//  VisitorView.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorView.h"
#import "STTimeUtil.h"
#import "STDateLayerView.h"
#import "STCarNumLayerView.h"
#import "PassView.h"
#import "STSwitchView.h"
#import "STSelectLayerButton.h"

@interface VisitorView()<STDateLayerViewDelegate,STCarNumLayerViewDelegate,STSwitchViewDelegate>

@property(strong, nonatomic)VisitorViewModel *mViewModel;
@property(assign, nonatomic)VisitorType mType;

@property(strong, nonatomic)UITextField *nameTextField;
//@property(strong, nonatomic)UIButton *dateBtn;
@property(strong, nonatomic)STDateLayerView *dateLayerView;
@property(strong, nonatomic)UIButton *headBtn;
@property(strong, nonatomic)UITextField *numberTextField;
@property(strong, nonatomic)STCarNumLayerView *carNumLayerView;
@property(strong, nonatomic)STSwitchView *funcSwitch;
@property(strong, nonatomic)UIView *faceView;
@property(strong, nonatomic)UIButton *generateBtn;
@property(strong, nonatomic)UIButton *imageBtn;
@property(strong, nonatomic)UIView *layerView;
@property(strong, nonatomic)UIImageView *addImageView;
@property(strong, nonatomic)UILabel *tipsLabel;
@property(strong, nonatomic)STSelectLayerButton *dateBtn;

@end

@implementation VisitorView{
    NSString *mImagePath;
}

-(instancetype)initWithViewModel:(VisitorViewModel *)model type:(VisitorType)type{
    if(self == [super init]){
        _mViewModel = model;
        _mType = type;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *commonView =[[UIView alloc]initWithFrame:CGRectMake(0, STHeight(10), ScreenWidth, STHeight(114))];
    commonView.backgroundColor = cwhite;
    [self addSubview:commonView];
    
 
    NSArray *commonTitles = @[MSG_VISITOR_NAME,MSG_VISITOR_DATE];
    for(int i = 0 ; i < commonTitles.count ; i++){
        NSString *title = [commonTitles objectAtIndex:i];
        UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:title textAlignment:NSTextAlignmentLeft textColor:c11 backgroundColor:nil multiLine:NO];
        CGSize labelSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        label.frame = CGRectMake(STWidth(15), STHeight(20.5) + i * STHeight(57), labelSize.width, STHeight(16));
        [commonView addSubview:label];
    }
    
    _nameTextField = [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameTextField.frame = CGRectMake(STWidth(100), 0 , ScreenWidth - STWidth(115), STHeight(57));
    _nameTextField.text = _mViewModel.data.name;
    [_nameTextField setPlaceholder:MSG_VISITOR_NAME_TIPS color:c17 fontSize:STFont(16)];
    [commonView addSubview:_nameTextField];
    
    
    NSString *dateStr = [STTimeUtil generateDate_EN:[STTimeUtil getCurrentTimeStamp]];
    NSString *dateShowStr = [NSString stringWithFormat:@"今天  %@",dateStr];
//    _dateBtn = [[UIButton alloc]initWithFont:STFont(16) text:dateStr textColor:c12 backgroundColor:cclear corner:0 borderWidth:0 borderColor:nil];
//    CGSize dateSize = [dateStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
//    _dateBtn.frame = CGRectMake(ScreenWidth - dateSize.width - STWidth(35), STHeight(57), dateSize.width, STHeight(57));
//    [_dateBtn addTarget:self action:@selector(OnClickDateBtn) forControlEvents:UIControlEventTouchUpInside];
//    [commonView addSubview:_dateBtn];
    
    CGSize dateSize = [dateShowStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _dateBtn = [[STSelectLayerButton alloc]initWithFrame:CGRectMake(ScreenWidth - (dateSize.width + STWidth(36)), STHeight(57), dateSize.width + STWidth(36), STHeight(57))];
    [_dateBtn setSelectText:dateShowStr];
    [_dateBtn addTarget:self action:@selector(OnClickDateBtn) forControlEvents:UIControlEventTouchUpInside];
    [commonView addSubview:_dateBtn];
    
//    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.image = [UIImage imageNamed:@"ic_arrow_bottom"];
//    imageView.frame = CGRectMake(ScreenWidth - STWidth(28), STHeight(57) + (STHeight(57) - STWidth(13))/2, STWidth(13), STWidth(13));
//    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickDateBtn)];
//    [imageView addGestureRecognizer:recongnizer];
//    [commonView addSubview:imageView];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, STHeight(57.5) - LineHeight, ScreenWidth,LineHeight)];
    lineView.backgroundColor = cline;
    [commonView addSubview:lineView];
    
    
    if(_mType == Car){
        [self initCarNumView];
    }
    
    [self initFaceView];
    
    _generateBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_VISITOR_GENERATE_BTN textColor:cwhite backgroundColor:c08 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _generateBtn.frame = CGRectMake(STWidth(50), ContentHeight - STHeight(90), STWidth(276), STHeight(50));
    [_generateBtn addTarget:self action:@selector(onClickGenerateBtn) forControlEvents:UIControlEventTouchUpInside];
    [_generateBtn setBackgroundColor:c08a forState:UIControlStateHighlighted];
    [self addSubview:_generateBtn];
    
    _dateLayerView = [[STDateLayerView alloc]initWithTitle:nil frame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _dateLayerView.delegate = self;
    _dateLayerView.hidden = YES;
    [_dateLayerView setDate:dateStr];
    [self addSubview:_dateLayerView];
    
    _carNumLayerView = [[STCarNumLayerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _carNumLayerView.delegate = self;
    _carNumLayerView.hidden = YES;
    [_carNumLayerView setCarNum:MSG_ADDCAR_DEFAULT_HEAD];
    [self addSubview:_carNumLayerView];
    
    
    
    
}


-(void)initCarNumView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(135), ScreenWidth, STHeight(57))];
    view.backgroundColor = cwhite;
    [self addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:MSG_VISITOR_CARNUM textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    CGSize labelSize = [MSG_VISITOR_CAR_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    label.frame = CGRectMake(STWidth(15), STHeight(20.5), labelSize.width, STHeight(16));
    [view addSubview:label];
    
    
    _headBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_ADDCAR_DEFAULT_HEAD textColor:c16 backgroundColor:[UIColor clearColor] corner:0 borderWidth:0 borderColor:nil];
    _headBtn.frame = CGRectMake(STWidth(213),0, STWidth(60), STHeight(57));
    _headBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_headBtn addTarget:self action:@selector(OnClickHeadBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_headBtn];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"ic_arrow_bottom"];
    imageView.frame = CGRectMake(STWidth(262), STHeight(27), STWidth(11), STHeight(7));
    [view addSubview:imageView];
    
    _numberTextField =  [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _numberTextField.textAlignment = NSTextAlignmentRight;
    _numberTextField.frame = CGRectMake(STWidth(273), 0 , STWidth(90), STHeight(57));
    [_numberTextField setMaxLength:@"6"];
    [_numberTextField setPlaceholder:MSG_VISITOR_CARNUM_TIPS color:c17 fontSize:STFont(16)];

    [view addSubview:_numberTextField];
    
    if(!IS_NS_STRING_EMPTY(_mViewModel.data.carNum)){
        _numberTextField.text = _mViewModel.data.carNum;
    }
    
}

-(void)initFaceView{
    CGFloat height = STHeight(135);
    if(Car == _mType){
        height = STHeight(203);
    }
    _faceView = [[UIView alloc]initWithFrame:CGRectMake(0, height, ScreenWidth, STHeight(57))];
    _faceView.backgroundColor = cwhite;
    [self addSubview:_faceView];
    
    UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:MSG_VISITOR_FACEDECTED textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
    CGSize labelSize = [MSG_VISITOR_FACEDECTED sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    label.frame = CGRectMake(STWidth(15), STHeight(20.5), labelSize.width, STHeight(16));
    [_faceView addSubview:label];
    
    _funcSwitch = [[STSwitchView alloc]init];
    _funcSwitch.frame = CGRectMake(STWidth(318), STHeight(17), STWidth(42), STHeight(26));
    _funcSwitch.on = NO;
    _funcSwitch.delegate = self;
    [_faceView addSubview:_funcSwitch];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(57), ScreenWidth, LineHeight)];
    lineView.backgroundColor = cline;
    [_faceView addSubview:lineView];
    

    _imageBtn = [[UIButton alloc]initWithFont:STFont(30) text:@"" textColor:c12 backgroundColor:c36 corner:STHeight(70) borderWidth:0 borderColor:nil];
    _imageBtn.frame = CGRectMake(STWidth(118), STHeight(85), 0, 0);
    _imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageBtn addTarget:self action:@selector(onClickImageBtn) forControlEvents:UIControlEventTouchUpInside];
    [_faceView addSubview:_imageBtn];
    
    _addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STHeight(52), (STHeight(140) - STWidth(36))/2, STWidth(36), STWidth(36))];
    _addImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addImageView.image = [UIImage imageNamed:@"用户认证_icon_相机大"];
    _addImageView.userInteractionEnabled = NO;
    [_imageBtn addSubview:_addImageView];
    
    _layerView= [[UIView alloc]init];
    _layerView.hidden = YES;
    _layerView.userInteractionEnabled = NO;
    _layerView.backgroundColor = [c35 colorWithAlphaComponent:0.6f];
    _layerView.frame = CGRectMake(0, STHeight(100), STHeight(140), STHeight(40));
    [_imageBtn addSubview:_layerView];
    
    UIImageView *layerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(STHeight(60), STHeight(10), STHeight(20), STHeight(20))];
    layerImageView.image = [UIImage imageNamed:@"用户认证_icon_相机大"];
    layerImageView.userInteractionEnabled = NO;
    layerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_layerView addSubview:layerImageView];
    
    _imageBtn.clipsToBounds = YES;
    
    
    
    _tipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:MSG_VISITOR_TIPS textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    _tipsLabel.frame = CGRectMake(STWidth(15), STHeight(67), ScreenWidth - STWidth(30), STHeight(12));
    [_faceView addSubview:_tipsLabel];
    
    if(!IS_NS_STRING_EMPTY(_mViewModel.data.faceUrl)){
        [_funcSwitch setOn:YES];
        [self onSwitchStatuChange:YES];
        NSURL *url = [[STUploadImageUtil sharedSTUploadImageUtil]getRealUrl:_mViewModel.data.faceUrl];
        [_imageBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_default"]];
    }


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameTextField resignFirstResponder];
    [_numberTextField resignFirstResponder];
}


-(void)OnClickDateBtn{
    [_nameTextField resignFirstResponder];
    [_numberTextField resignFirstResponder];
    _dateLayerView.hidden = NO;
}


//日期选择回调
-(void)OnDateSelectResult:(NSString *)dateStr{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[STTimeUtil getTimeStamp:[NSString stringWithFormat:@"%@ 23:59:59",dateStr] format:@"yyyy.MM.dd HH:mm:ss"]];
    NSString *resultStr = [NSString stringWithFormat:@"%@  %@",[STTimeUtil getCurrentWeek:date],dateStr];
    [_dateBtn setSelectText:resultStr];
}


-(void)OnClickHeadBtn{
    _carNumLayerView.hidden = NO;
}

//车牌头选择回调
-(void)OnCarNumSelectResult:(NSString *)carNumStr{
    [_headBtn setTitle:carNumStr forState:UIControlStateNormal];
}

-(void)onSwitchStatuChange:(Boolean)on{
    WS(weakSelf)
    CGFloat height = STHeight(135);
    if(Car == _mType){
        height = STHeight(203);
    }
    if(_funcSwitch.on){
        [UIView animateWithDuration:0.3F animations:^{
            weakSelf.faceView.frame = CGRectMake(0, height, ScreenWidth, STHeight(252));
            weakSelf.imageBtn.frame = CGRectMake((ScreenWidth - STHeight(140))/2, STHeight(85), STHeight(140), STHeight(140));
            weakSelf.tipsLabel.frame = CGRectMake(STWidth(15), STHeight(262), ScreenWidth - STWidth(30), STHeight(12));

        }];
    }else{
        [UIView animateWithDuration:0.3F animations:^{
            weakSelf.faceView.frame = CGRectMake(0, height, ScreenWidth, STHeight(57));
            weakSelf.imageBtn.frame = CGRectMake((ScreenWidth - STHeight(140))/2, STHeight(85),0, 0);
            weakSelf.tipsLabel.frame = CGRectMake(STWidth(15), STHeight(67), ScreenWidth - STWidth(30), STHeight(12));

        }];
    }
}


-(void)onClickGenerateBtn{
    if(_mViewModel){
        if(IS_NS_STRING_EMPTY(_numberTextField.text) && _mType == Car){
            [self updateTipLabel:MSG_VISITOR_ERROR_NOCARNUM];
            return;
        }
        NSString *nameStr = _nameTextField.text;
        NSString *dateStr = [[_dateBtn getSelectText] substringWithRange:NSMakeRange(4,  [_dateBtn getSelectText].length - 4)];
        NSString *carStr = @"";
        if(_mType == Car){
            carStr = [NSString stringWithFormat:@"%@%@",_headBtn.titleLabel.text,_numberTextField.text];
        }
        [_mViewModel generatePass:nameStr date:dateStr carNum:carStr on:_funcSwitch.on imagePath:mImagePath type:_mType imageUrl:_mViewModel.data.faceUrl];
  
    }
}

-(void)onClickImageBtn{
    if(_mViewModel){
        [_mViewModel doTakePhoto];
    }
}



-(void)updateView:(NSString *)imagePath{
    mImagePath = imagePath;
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    [_imageBtn setImage:image forState:UIControlStateNormal];
    [_imageBtn setImage:image forState:UIControlStateHighlighted];
    _layerView.hidden = NO;
    _addImageView.hidden = YES;

}

-(void)showGeneratePass:(PassModel *)passModel{
    _tipsLabel.textColor = c12;
    _tipsLabel.text = @"";
    if(_mViewModel){
        [_mViewModel goPassPage:_mViewModel.data passModel:passModel];
    }

}

-(void)updateTipLabel:(NSString *)errorMsg{
    _tipsLabel.text = errorMsg;
    _tipsLabel.textColor = c18;
}

@end
