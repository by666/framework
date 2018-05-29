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

@interface VisitorView()<STDateLayerViewDelegate,STCarNumLayerViewDelegate>

@property(strong, nonatomic)VisitorViewModel *mViewModel;
@property(assign, nonatomic)VisitorType mType;

@property(strong, nonatomic)UITextField *nameTextField;
@property(strong, nonatomic)UIButton *dateBtn;
@property(strong, nonatomic)STDateLayerView *dateLayerView;
@property(strong, nonatomic)UIButton *headBtn;
@property(strong, nonatomic)UITextField *numberTextField;
@property(strong, nonatomic)STCarNumLayerView *carNumLayerView;
@property(strong, nonatomic)UISwitch *funcSwitch;
@property(strong, nonatomic)UIView *faceView;
@property(strong, nonatomic)UIButton *generateBtn;
@property(strong, nonatomic)UIButton *imageBtn;
@property(strong, nonatomic)UILabel *tipsLabel;
@property(strong, nonatomic)PassView *passView;

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
        UILabel *label = [[UILabel alloc]initWithFont:STFont(16) text:title textAlignment:NSTextAlignmentLeft textColor:c16 backgroundColor:nil multiLine:NO];
        CGSize labelSize = [title sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
        label.frame = CGRectMake(STWidth(15), STHeight(20.5) + i * STHeight(57), labelSize.width, STHeight(16));
        [commonView addSubview:label];
    }
    
    _nameTextField = [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameTextField.frame = CGRectMake(STWidth(100), 0 , ScreenWidth - STWidth(115), STHeight(57));
    _nameTextField.text = _mViewModel.data.name;
    [commonView addSubview:_nameTextField];
    
    NSString *dateStr = [STTimeUtil getTomorrowDate];
    _dateBtn = [[UIButton alloc]initWithFont:STFont(16) text:dateStr textColor:c12 backgroundColor:cclear corner:0 borderWidth:0 borderColor:nil];
    CGSize dateSize = [dateStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _dateBtn.frame = CGRectMake(ScreenWidth - dateSize.width - STWidth(31), STHeight(57), dateSize.width, STHeight(57));
    [_dateBtn addTarget:self action:@selector(OnClickDateBtn) forControlEvents:UIControlEventTouchUpInside];
    [commonView addSubview:_dateBtn];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"ic_bottom_arrow"];
    imageView.frame = CGRectMake(ScreenWidth - STWidth(26), STHeight(83), STWidth(11), STHeight(7));
    [commonView addSubview:imageView];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(STWidth(15), STHeight(57.5) - 1, ScreenWidth - STWidth(30),1 )];
    lineView.backgroundColor = c17;
    [commonView addSubview:lineView];
    
    
    if(_mType == Car){
        [self initCarNumView];
    }
    
    [self initFaceView];
    
    _generateBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_VISITOR_GENERATE_BTN textColor:cwhite backgroundColor:c19 corner:STHeight(25) borderWidth:0 borderColor:nil];
    _generateBtn.frame = CGRectMake(STWidth(50), STHeight(513), ScreenWidth - STWidth(100), STHeight(50));
    [_generateBtn addTarget:self action:@selector(onClickGenerateBtn) forControlEvents:UIControlEventTouchUpInside];
    [_generateBtn setBackgroundColor:c19a forState:UIControlStateHighlighted];
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
    imageView.image = [UIImage imageNamed:@"ic_bottom_arrow"];
    imageView.frame = CGRectMake(STWidth(262), STHeight(27), STWidth(11), STHeight(7));
    [view addSubview:imageView];
    
    _numberTextField =  [[UITextField alloc]initWithFont:STFont(16) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _numberTextField.textAlignment = NSTextAlignmentRight;
    _numberTextField.frame = CGRectMake(STWidth(273), 0 , STWidth(90), STHeight(57));
    [view addSubview:_numberTextField];
    
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
    CGSize labelSize = [MSG_VISITOR_CAR_TITLE sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    label.frame = CGRectMake(STWidth(15), STHeight(20.5), labelSize.width, STHeight(16));
    [_faceView addSubview:label];
    
    _funcSwitch = [[UISwitch alloc]init];
    _funcSwitch.frame = CGRectMake(STWidth(318), STHeight(17), STWidth(42), STHeight(26));
    _funcSwitch.on = NO;
    [_funcSwitch addTarget:self action:@selector(OnClickSwitch) forControlEvents:UIControlEventTouchUpInside];
    [_faceView addSubview:_funcSwitch];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(57), ScreenWidth, 1)];
    lineView.backgroundColor = c17;
    [_faceView addSubview:lineView];
    
    _imageBtn = [[UIButton alloc]initWithFont:STFont(30) text:@"+" textColor:c12 backgroundColor:c15 corner:STHeight(9) borderWidth:1 borderColor:c12];
    _imageBtn.frame = CGRectMake(STWidth(108), STHeight(75), 0, 0);
    _imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageBtn addTarget:self action:@selector(onClickImageBtn) forControlEvents:UIControlEventTouchUpInside];
    [_faceView addSubview:_imageBtn];
    
    _tipsLabel = [[UILabel alloc]initWithFont:STFont(12) text:MSG_VISITOR_TIPS textAlignment:NSTextAlignmentLeft textColor:c12 backgroundColor:nil multiLine:NO];
    _tipsLabel.frame = CGRectMake(STWidth(15), STHeight(67), ScreenWidth - STWidth(30), STHeight(12));
    [_faceView addSubview:_tipsLabel];
    


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameTextField resignFirstResponder];
    [_numberTextField resignFirstResponder];
}


-(void)OnClickDateBtn{
    _dateLayerView.hidden = NO;
}


//日期选择回调
-(void)OnDateSelectResult:(NSString *)dateStr{
    [_dateBtn setTitle:dateStr forState:UIControlStateNormal];
    CGSize dateSize = [dateStr sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(16)]];
    _dateBtn.frame = CGRectMake(ScreenWidth - dateSize.width - STWidth(31), STHeight(57), dateSize.width, STHeight(57));
}


-(void)OnClickHeadBtn{
    _carNumLayerView.hidden = NO;
}

//车牌头选择回调
-(void)OnCarNumSelectResult:(NSString *)carNumStr{
    [_headBtn setTitle:carNumStr forState:UIControlStateNormal];
}

-(void)OnClickSwitch{
    WS(weakSelf)
    CGFloat height = STHeight(135);
    if(Car == _mType){
        height = STHeight(203);
    }
    if(_funcSwitch.on){
        [UIView animateWithDuration:0.3F animations:^{
            weakSelf.faceView.frame = CGRectMake(0, height, ScreenWidth, STHeight(252));
            weakSelf.imageBtn.frame = CGRectMake(STWidth(108), STHeight(75), ScreenWidth - STHeight(216), STWidth(160));
            weakSelf.tipsLabel.frame = CGRectMake(STWidth(15), STHeight(262), ScreenWidth - STWidth(30), STHeight(12));

        }];
    }else{
        [UIView animateWithDuration:0.3F animations:^{
            weakSelf.faceView.frame = CGRectMake(0, height, ScreenWidth, STHeight(57));
            weakSelf.imageBtn.frame = CGRectMake(STWidth(108), STHeight(75),0, 0);
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
        NSString *dateStr = _dateBtn.titleLabel.text;
        NSString *carStr = [NSString stringWithFormat:@"%@%@",_headBtn.titleLabel.text,_numberTextField.text];
        [_mViewModel generatePass:nameStr date:dateStr carNum:carStr on:_funcSwitch.on imagePath:mImagePath type:_mType];
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

}

-(void)showGeneratePass{
    _tipsLabel.textColor = c12;
    _tipsLabel.text = @"";
    
    _passView = [[PassView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ContentHeight) model:_mViewModel];
    [self addSubview:_passView];

}

-(void)updateTipLabel:(NSString *)errorMsg{
    _tipsLabel.text = errorMsg;
    _tipsLabel.textColor = c18;
}

@end
