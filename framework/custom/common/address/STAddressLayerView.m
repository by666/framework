//
//  STAddressLayerView.m
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STAddressLayerView.h"
#import "AddressLayerModel.h"

@interface STAddressLayerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong, nonatomic)UIPickerView *provincePickerView;
@property(strong, nonatomic)UIPickerView *cityPickerView;
@property(strong, nonatomic)UIPickerView *districtPickerView;

@property(strong, nonatomic)NSMutableArray *provinceDatas;
@property(strong, nonatomic)NSMutableArray *cityDatas;
@property(strong, nonatomic)NSMutableArray *districtDatas;

@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;

@end

@implementation STAddressLayerView{
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
    NSInteger mColumn;
}


-(instancetype)initWithColumn:(NSInteger)column{
    if(self == [super init]){
        _provinceDatas = [[NSMutableArray alloc]init];
        _cityDatas = [[NSMutableArray alloc]init];
        _districtDatas = [[NSMutableArray alloc]init];
        mColumn = column;
        provinceIndex = 0;
        cityIndex = 0;
        districtIndex = 0;
        [self setupDatas];
        [self initView];
    }
    return self;
}


-(void)initView{
    
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight);
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    self.hidden = NO;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    if(mColumn > 0){
        [self addSubview:[self provincePickerView]];
    }
    if(mColumn > 1){
        [self addSubview:[self cityPickerView]];
    }
    if(mColumn > 2){
        [self addSubview:[self districtPickerView]];
    }
    
    [self addSubview:[self cancelBtn]];
    [self addSubview:[self confirmBtn]];

}


-(UIPickerView *)provincePickerView{
    if(_provincePickerView == nil){
        _provincePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(200), ScreenWidth /mColumn, STHeight(200))];
        _provincePickerView.showsSelectionIndicator = YES;
        _provincePickerView.backgroundColor = cwhite;
        _provincePickerView.delegate = self;
        _provincePickerView.dataSource = self;
    }
    return _provincePickerView;
}

-(UIPickerView *)cityPickerView{
    if(_cityPickerView == nil){
        _cityPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(ScreenWidth/mColumn, ContentHeight - STHeight(200), ScreenWidth /mColumn, STHeight(200))];
        _cityPickerView.showsSelectionIndicator = YES;
        _cityPickerView.backgroundColor = cwhite;
        _cityPickerView.delegate = self;
        _cityPickerView.dataSource = self;
    }
    return _cityPickerView;
}

-(UIPickerView *)districtPickerView{
    if(_districtPickerView == nil){
        _districtPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(ScreenWidth * 2/mColumn, ContentHeight - STHeight(200), ScreenWidth /mColumn, STHeight(200))];
        _districtPickerView.showsSelectionIndicator = YES;
        _districtPickerView.backgroundColor = cwhite;
        _districtPickerView.delegate = self;
        _districtPickerView.dataSource = self;
    }
    return _districtPickerView;
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
    return STHeight(40);
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(_provincePickerView == pickerView && !IS_NS_COLLECTION_EMPTY(_provinceDatas)){
        return [_provinceDatas count];
    }else if(_cityPickerView == pickerView && !IS_NS_COLLECTION_EMPTY(_cityDatas)){
        return [_cityDatas count];
    }else if(_districtPickerView == pickerView && !IS_NS_COLLECTION_EMPTY(_districtDatas)){
        return [_districtDatas count];
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(_provincePickerView == pickerView && !IS_NS_COLLECTION_EMPTY(_provinceDatas)){
        AddressLayerModel *provinceModel = [_provinceDatas objectAtIndex:row];
        return provinceModel.name;
    }else if(_cityPickerView == pickerView && !IS_NS_COLLECTION_EMPTY(_cityDatas)){
        AddressLayerModel *cityModel = [_cityDatas objectAtIndex:row];
        return cityModel.name;
    }else if(_districtPickerView == pickerView && !IS_NS_COLLECTION_EMPTY(_districtDatas)){
        AddressLayerModel *districtModel = [_districtDatas objectAtIndex:row];
        return districtModel.name;
    }
    return @"";
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(_provincePickerView == pickerView){
        provinceIndex = row;
        
        AddressLayerModel *provinceModel = [_provinceDatas objectAtIndex:provinceIndex];
        [_cityDatas removeAllObjects];
        [_districtDatas removeAllObjects];
        if(IS_NS_COLLECTION_EMPTY(provinceModel.sub)){
            [_cityPickerView reloadComponent:0];
            [_districtPickerView reloadComponent:0];
            return;
        }
        NSMutableArray *cityArray =  [AddressLayerModel mj_objectArrayWithKeyValuesArray:provinceModel.sub];
        for(AddressLayerModel *model in cityArray){
            [_cityDatas addObject:model];
        }
        cityIndex = 0;
        [_cityPickerView reloadComponent:0];
        [_cityPickerView selectRow:cityIndex inComponent:0 animated:YES];
        
        AddressLayerModel *cityModel = [_cityDatas objectAtIndex:cityIndex];
        if(IS_NS_COLLECTION_EMPTY(cityModel.sub)){
            [_cityPickerView reloadComponent:0];
            return;
        }
        NSMutableArray *districtArray = [AddressLayerModel mj_objectArrayWithKeyValuesArray:cityModel.sub];
        for(AddressLayerModel *model in districtArray){
            [_districtDatas addObject:model];
        }
        districtIndex = 0;
        [_districtPickerView reloadComponent:0];
        [_districtPickerView selectRow:districtIndex inComponent:0 animated:YES];


    }else if(_cityPickerView == pickerView){
        cityIndex = row;
        AddressLayerModel *cityModel = [_cityDatas objectAtIndex:cityIndex];
        [_districtDatas removeAllObjects];
        if(IS_NS_COLLECTION_EMPTY(cityModel.sub)){
            [_districtPickerView reloadComponent:0];
            return;
        }
        NSMutableArray *districtArray = [AddressLayerModel mj_objectArrayWithKeyValuesArray:cityModel.sub];
        for(AddressLayerModel *model in districtArray){
            [_districtDatas addObject:model];
        }
        districtIndex = 0;
        [_districtPickerView reloadComponent:0];
        [_districtPickerView selectRow:districtIndex inComponent:0 animated:YES];

    }else if(_districtPickerView == pickerView){
        districtIndex = row;
    }
}



//初始化数据
-(void)setupDatas{
    
    if(mColumn > 0){
        NSString *addressStr = [self getAddressJsonStr];
        NSMutableArray *provinceArray = [AddressLayerModel mj_objectArrayWithKeyValuesArray:addressStr];
        for(AddressLayerModel *model in provinceArray){
            [_provinceDatas addObject:model];
        }
    }
    
    if(mColumn > 1){
        AddressLayerModel *provinceModel = [_provinceDatas objectAtIndex:provinceIndex];
        NSMutableArray *cityArray =  [AddressLayerModel mj_objectArrayWithKeyValuesArray:provinceModel.sub];
        for(AddressLayerModel *model in cityArray){
            [_cityDatas addObject:model];
        }
    }
    
    if(mColumn > 2){
        AddressLayerModel *cityModel = [_cityDatas objectAtIndex:cityIndex];
        NSMutableArray *districtArray = [AddressLayerModel mj_objectArrayWithKeyValuesArray:cityModel.sub];
        for(AddressLayerModel *model in districtArray){
            [_districtDatas addObject:model];
        }
    }

}


//解析txt
-(NSString *)getAddressJsonStr{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"txt"];
    NSError  *error;
    NSString *addressStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    }
    return addressStr;
}


-(void)OnClickLayerView{
    self.hidden = YES;
}

-(void)OnClickCancelBtn{
    self.hidden = YES;
    
}

-(void)OnClickConfirmBtn{
    self.hidden = YES;
    if(_delegate){
        NSString *result = @"";
        if(!IS_NS_COLLECTION_EMPTY(_cityDatas)){
            AddressLayerModel *model = [_cityDatas objectAtIndex:cityIndex];
            result = model.name;
        }
        [_delegate onSelectAddressResult:result];
    }
}

@end
