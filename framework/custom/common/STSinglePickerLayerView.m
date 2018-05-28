//
//  STSinglePickerLayerView.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STSinglePickerLayerView.h"

@interface STSinglePickerLayerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong, nonatomic)UIPickerView *pickerView;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)NSMutableArray *mDatas;
@end

@implementation STSinglePickerLayerView{
    NSInteger position;
}

-(instancetype)initWithDatas:(NSMutableArray *)datas{
    if(self == [super init]){
        _mDatas = [[NSMutableArray alloc]init];
        [_mDatas addObjectsFromArray:datas];
        [self initView];
    }
    return self;
}


-(void)initView{
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    
    [self addSubview:[self cancelBtn]];
    [self addSubview:[self confirmBtn]];
    [self addSubview:[self pickerView]];
}


-(UIPickerView *)pickerView{
    if(_pickerView == nil){
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(200), ScreenWidth, STHeight(200))];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = cwhite;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}


-(UIButton *)cancelBtn{
    if(_cancelBtn == nil){
        _cancelBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CANCEL textColor:c12 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _cancelBtn.frame = CGRectMake(0, ContentHeight - STHeight(250), ScreenWidth/2, STHeight(50));
        [_cancelBtn addTarget:self action:@selector(OnClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)confirmBtn{
    if(_confirmBtn == nil){
        _confirmBtn = [[UIButton alloc]initWithFont:STFont(16) text:MSG_CONFIRM textColor:c20 backgroundColor:c15 corner:0 borderWidth:0 borderColor:nil];
        _confirmBtn.frame = CGRectMake(ScreenWidth/2, ContentHeight - STHeight(250), ScreenWidth/2, STHeight(50));
        [_confirmBtn addTarget:self action:@selector(OnClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return STHeight(60);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_mDatas count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(IS_NS_COLLECTION_EMPTY(_mDatas)){
        return @"";
    }
    return [_mDatas objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    position = row;
}


-(void)OnClickLayerView{
    self.hidden = YES;
}

-(void)OnClickCancelBtn{
    self.hidden = YES;
    
}

-(void)OnClickConfirmBtn{
    self.hidden = YES;
    if(IS_NS_COLLECTION_EMPTY(_mDatas)){
        return;
    }
    NSString *resultStr = [_mDatas objectAtIndex:position];
    if(_delegate){
        [_delegate onSelectResult:resultStr];
    }
}


-(void)setData:(NSString *)data{
    if(IS_NS_COLLECTION_EMPTY(_mDatas)){
        return;
    }
    
    for(int i = 0 ; i < [_mDatas count] ; i ++){
        NSString *temp = [_mDatas objectAtIndex:i];
        if([temp isEqualToString:data]){
            position = i;
            break;
        }
    }
    
    [_pickerView selectRow:position inComponent:0 animated:YES];
}

@end
