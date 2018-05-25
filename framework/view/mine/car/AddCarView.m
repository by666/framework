//
//  AddCarView.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddCarView.h"

@interface AddCarView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong, nonatomic)AddCarViewModel *mViewModel;
@property(strong, nonatomic)UIButton *headBtn;


@property(strong, nonatomic)UIView *layerView;
@property(strong, nonatomic)UIPickerView *carNumPickerView;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)UITextField *numTextField;


@end

@implementation AddCarView{
    NSArray *shortHeadArray;
    NSArray *alphabetArray;
    NSInteger row1;
    NSInteger row2;
}

-(instancetype)initWithViewModel:(AddCarViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    shortHeadArray = [_mViewModel getCarShortHead];
    alphabetArray =  [_mViewModel getCarAlphabet];
    
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = cwhite;
    contentView.frame = CGRectMake(0, STHeight(10), ScreenWidth, ContentHeight - STHeight(10));
    [self addSubview:contentView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = c17;
    lineView.frame = CGRectMake(0, STHeight(60),STWidth(ScreenWidth), 1);
    [contentView addSubview:lineView];
    
    UILabel *carNumLabel = [[UILabel alloc]initWithFont:STFont(18) text:MSG_ADDCAR_CARNUM textAlignment:NSTextAlignmentLeft textColor:c20 backgroundColor:nil multiLine:NO];
    carNumLabel.frame = CGRectMake(STWidth(15), STHeight(21), STWidth(80), STHeight(18));
    [contentView addSubview:carNumLabel];
    
    _headBtn = [[UIButton alloc]initWithFont:STFont(18) text:MSG_ADDCAR_DEFAULT_HEAD textColor:c16 backgroundColor:[UIColor clearColor] corner:0 borderWidth:0 borderColor:nil];
    _headBtn.frame = CGRectMake(STWidth(213),0, STWidth(60), STHeight(60));
    [_headBtn setImage:[UIImage imageNamed:@"ic_bottom_arrow"] forState:UIControlStateNormal];
    [_headBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -_headBtn.imageView.size.width, 0, _headBtn.imageView.size.width)];
    [_headBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _headBtn.titleLabel.bounds.size.width + STWidth(6), 0, -_headBtn.titleLabel.bounds.size.width)];
    [_headBtn addTarget:self action:@selector(OnClickHeadBtn) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_headBtn];
    
    _numTextField = [[UITextField alloc]initWithFont:STFont(18) textColor:c12 backgroundColor:nil corner:0 borderWidth:0 borderColor:nil padding:0];
    _numTextField.frame = CGRectMake(STWidth(273), 0, STWidth(102), STHeight(60));
    _numTextField.textAlignment = NSTextAlignmentCenter;
    [_numTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_numTextField becomeFirstResponder];
    [contentView addSubview:_numTextField];
    
    
    _layerView = [[UIView alloc]init];
    _layerView.frame =  CGRectMake(0, 0, ScreenWidth, ContentHeight);
    _layerView.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    _layerView.hidden = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [_layerView addGestureRecognizer:recognizer];
    [self addSubview:_layerView];
    
    
    [_layerView addSubview:[self cancelBtn]];
    [_layerView addSubview:[self confirmBtn]];
    [_layerView addSubview:[self carNumPickerView]];

    
}

-(UIPickerView *)carNumPickerView{
    if(_carNumPickerView == nil){
        _carNumPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(129), ScreenWidth, STHeight(129))];
        _carNumPickerView.showsSelectionIndicator = YES;
        _carNumPickerView.backgroundColor = cwhite;
        _carNumPickerView.delegate = self;
        _carNumPickerView.dataSource = self;
    }
    return _carNumPickerView;
}


-(UIButton *)cancelBtn{
    if(_cancelBtn == nil){
        _cancelBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CANCEL textColor:c12 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _cancelBtn.frame = CGRectMake(0, ContentHeight - STHeight(179), ScreenWidth/2, STHeight(50));
        [_cancelBtn addTarget:self action:@selector(OnClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)confirmBtn{
    if(_confirmBtn == nil){
        _confirmBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CONFIRM textColor:c20 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _confirmBtn.frame = CGRectMake(ScreenWidth/2, ContentHeight - STHeight(179), ScreenWidth/2, STHeight(50));
        [_confirmBtn addTarget:self action:@selector(OnClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}



-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return  [shortHeadArray count];
    }
    return [alphabetArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [shortHeadArray objectAtIndex:row];
    }
    return [alphabetArray objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        row1 = row;
    }
    else if(component == 1){
        row2 = row;
    }
}


- (void)textFieldDidChange:(UITextField *)textField{
    UITextRange * selectedRange = textField.markedTextRange;
    if(selectedRange == nil || selectedRange.empty){
        NSInteger maxLength = 6;
        NSString *text = textField.text;
        if(text.length >= maxLength){
            textField.text = [text substringWithRange: NSMakeRange(0, maxLength)];
        }
    }
}

-(void)OnClickHeadBtn{
    
    [_numTextField resignFirstResponder];
    _layerView.hidden = NO;

    NSString *text =  _headBtn.titleLabel.text;
    NSRange range = NSMakeRange(0, 1);
    NSString *firstStr = [text substringWithRange:range];
    for(int i = 0 ; i < [shortHeadArray count] ; i++){
        if([firstStr isEqualToString:[shortHeadArray objectAtIndex:i]]){
            row1 = i;
            break;
        }
    }
    range = NSMakeRange(1, 1);
    NSString *secondStr = [text substringWithRange:range];
    for(int i = 0 ; i < [alphabetArray count] ; i++){
        if([secondStr isEqualToString:[alphabetArray objectAtIndex:i]]){
            row2 = i;
            break;
        }
    }
    [_carNumPickerView selectRow:row1 inComponent:0 animated:YES];
    [_carNumPickerView selectRow:row2 inComponent:1 animated:YES];
    

}

-(void)OnClickLayerView{
    _layerView.hidden = YES;
}

-(void)OnClickCancelBtn{
    _layerView.hidden = YES;

}

-(void)OnClickConfirmBtn{
    _layerView.hidden = YES;
    NSString *resultStr = @"";
    resultStr = [resultStr stringByAppendingString:[shortHeadArray objectAtIndex:row1]];
    resultStr = [resultStr stringByAppendingString:[alphabetArray objectAtIndex:row2]];
    [_headBtn setTitle:resultStr forState:UIControlStateNormal];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_numTextField resignFirstResponder];
}


-(void)addCarData{
    if(_mViewModel){
        NSString *resultStr = @"";
        resultStr = [resultStr stringByAppendingString:[shortHeadArray objectAtIndex:row1]];
        resultStr = [resultStr stringByAppendingString:[alphabetArray objectAtIndex:row2]];
        _mViewModel.data.carNum = _numTextField.text;
        _mViewModel.data.carHead = resultStr;
        [_mViewModel addCarData];
    }
}


@end
