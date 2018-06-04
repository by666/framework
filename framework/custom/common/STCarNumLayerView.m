//
//  STCarNumLayerView.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STCarNumLayerView.h"

@interface STCarNumLayerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong, nonatomic)UIPickerView *carNumPickerView;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;


@end;

@implementation STCarNumLayerView{
    NSArray *shortHeadArray;
    NSArray *alphabetArray;
    NSInteger row1;
    NSInteger row2;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        self.frame = frame;
        shortHeadArray = [self getCarShortHead];
        alphabetArray = [self getCarAlphabet];
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    self.hidden = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    
    [self addSubview:[self cancelBtn]];
    [self addSubview:[self confirmBtn]];
    [self addSubview:[self carNumPickerView]];
}


-(UIPickerView *)carNumPickerView{
    if(_carNumPickerView == nil){
        _carNumPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(150), ScreenWidth, STHeight(150))];
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
        _cancelBtn.frame = CGRectMake(0, ContentHeight - STHeight(200), ScreenWidth/2, STHeight(50));
        [_cancelBtn addTarget:self action:@selector(OnClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)confirmBtn{
    if(_confirmBtn == nil){
        _confirmBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CONFIRM textColor:c20 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _confirmBtn.frame = CGRectMake(ScreenWidth/2, ContentHeight - STHeight(200), ScreenWidth/2, STHeight(50));
        [_confirmBtn addTarget:self action:@selector(OnClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return STHeight(50);
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


-(void)OnClickLayerView{
    self.hidden = YES;
}

-(void)OnClickCancelBtn{
    self.hidden = YES;
    
}

-(void)OnClickConfirmBtn{
    self.hidden = YES;
    NSString *resultStr = @"";
    resultStr = [resultStr stringByAppendingString:[shortHeadArray objectAtIndex:row1]];
    resultStr = [resultStr stringByAppendingString:[alphabetArray objectAtIndex:row2]];
    if(_delegate){
        [_delegate OnCarNumSelectResult:resultStr];
    }
}


-(NSArray *)getCarShortHead{
    NSArray *array = @[@"京",@"津",@"沪",@"渝",@"蒙",@"新",@"藏",@"宁",@"桂",@"港",@"澳",@"黑",@"吉",@"辽",@"晋",@"冀",@"青",@"鲁",@"豫",@"苏",@"皖",@"浙",@"闽",@"赣",@"湘",@"鄂",@"粤",@"琼",@"甘",@"陕",@"黔",@"滇",@"川"];
    return array;
}

-(NSArray *)getCarAlphabet{
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    return array;
}



-(void)setCarNum:(NSString *)carNumStr{
    NSRange range = NSMakeRange(0, 1);
    NSString *firstStr = [carNumStr substringWithRange:range];
    for(int i = 0 ; i < [shortHeadArray count] ; i++){
        if([firstStr isEqualToString:[shortHeadArray objectAtIndex:i]]){
            row1 = i;
            break;
        }
    }
    range = NSMakeRange(1, 1);
    NSString *secondStr = [carNumStr substringWithRange:range];
    for(int i = 0 ; i < [alphabetArray count] ; i++){
        if([secondStr isEqualToString:[alphabetArray objectAtIndex:i]]){
            row2 = i;
            break;
        }
    }
    [_carNumPickerView selectRow:row1 inComponent:0 animated:YES];
    [_carNumPickerView selectRow:row2 inComponent:1 animated:YES];
}

@end
