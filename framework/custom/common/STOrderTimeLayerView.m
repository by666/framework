//
//  STOrderTimeLayerView.m
//  framework
//
//  Created by 黄成实 on 2018/6/7.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STOrderTimeLayerView.h"
#import "STTimeUtil.h"

@interface STOrderTimeLayerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong, nonatomic)UIPickerView *datePickerView;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;

@end

@implementation STOrderTimeLayerView{
    NSArray *dateArray1;
//    NSArray *dateArray2;
    NSArray *dateArray3;
    NSInteger row1;
//    NSInteger row2;
    NSInteger row3;

}

-(instancetype)init{
    if(self == [super init]){
        dateArray1 = [self getDatas1];
//        dateArray2 = [self getDatas2];
        dateArray3 = [self getDatas3];
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    self.hidden = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    
    [self addSubview:[self cancelBtn]];
    [self addSubview:[self confirmBtn]];
    [self addSubview:[self datePickerView]];
}


-(UIPickerView *)datePickerView{
    if(_datePickerView == nil){
        _datePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(150), ScreenWidth, STHeight(150))];
        _datePickerView.showsSelectionIndicator = YES;
        _datePickerView.backgroundColor = cwhite;
        _datePickerView.delegate = self;
        _datePickerView.dataSource = self;
    }
    return _datePickerView;
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


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = (UILabel *)view;
    label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth/3, STHeight(50))];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:STFont(14)];
    label.textColor = cblack;
    switch (component) {
        case 0:
            label.text = [dateArray1 objectAtIndex:row];
            break;
        case 1:
//            label.text = [dateArray2 objectAtIndex:row];
//            break;
//        case 2:
            label.text = [dateArray3 objectAtIndex:row];
            break;
            
        default:
            break;
    }
    return label;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return STHeight(50);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return 3;
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return  [dateArray1 count];
    }
//    else if(component == 1){
//        return [dateArray2 count];
//    }
    return [dateArray3 count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return  [dateArray1 objectAtIndex:row];
    }
//    else if(component == 1){
//        return [dateArray2 objectAtIndex:row];
//    }
    return [dateArray3 objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        row1 = row;
    }
//    else if(component == 1){
//        row2 = row;
//    }
    else{
        row3 = row;
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
    resultStr = [resultStr stringByAppendingString:[dateArray1 objectAtIndex:row1]];
    resultStr = [resultStr stringByAppendingString:@" "];
//    resultStr = [resultStr stringByAppendingString:[dateArray2 objectAtIndex:row2]];
//    resultStr = [resultStr stringByAppendingString:@" "];
    resultStr = [resultStr stringByAppendingString:[dateArray3 objectAtIndex:row3]];
    if(_delegate){
        [_delegate OnOrderTimeSelectResult:resultStr];
    }
}


-(NSArray *)getDatas1{
    return [STTimeUtil getOneWeeks];
}

//-(NSArray *)getDatas2{
//    return @[@"上午",@"下午"];
//
//}

-(NSArray *)getDatas3{
    return @[@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00",@"18:00-19:00",@"19:00-20:00",@"20:00-21:00",@"21:00-22:00"];
}



-(void)setOrderTime:(NSString *)carNumStr{
    NSArray *datas = [carNumStr componentsSeparatedByString:@" "];
    NSString *firstStr = datas[0];
    for(int i = 0 ; i < [dateArray1 count] ; i++){
        if([firstStr isEqualToString:[dateArray1 objectAtIndex:i]]){
            row1 = i;
            break;
        }
    }
//    NSString *secondStr = datas[1];
//    for(int i = 0 ; i < [dateArray2 count] ; i++){
//        if([secondStr isEqualToString:[dateArray2 objectAtIndex:i]]){
//            row2 = i;
//            break;
//        }
//    }
//
    NSString *thirdStr = datas[1];
    for(int i = 0 ; i < [dateArray3 count] ; i++){
        if([thirdStr isEqualToString:[dateArray3 objectAtIndex:i]]){
            row3 = i;
            break;
        }
    }
    [_datePickerView selectRow:row1 inComponent:0 animated:YES];
//    [_datePickerView selectRow:row2 inComponent:1 animated:YES];
    [_datePickerView selectRow:row3 inComponent:1 animated:YES];

}

@end
