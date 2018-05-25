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

@end

@implementation STAddressLayerView{
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
}


-(instancetype)init{
    if(self == [super init]){
        _provinceDatas = [[NSMutableArray alloc]init];
        _cityDatas = [[NSMutableArray alloc]init];
        _districtDatas = [[NSMutableArray alloc]init];
        provinceIndex = 0;
        cityIndex = 0;
        districtIndex = 0;
        [self setupDatas];
        [self initView];
    }
    return self;
}


-(void)initView{
    self.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    self.hidden = NO;
    [self addSubview:[self provincePickerView]];
    [self addSubview:[self cityPickerView]];
    [self addSubview:[self districtPickerView]];

}


-(UIPickerView *)provincePickerView{
    if(_provincePickerView == nil){
        _provincePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ContentHeight - STHeight(300), ScreenWidth /3, STHeight(300 ))];
        _provincePickerView.showsSelectionIndicator = YES;
        _provincePickerView.backgroundColor = cwhite;
        _provincePickerView.delegate = self;
        _provincePickerView.dataSource = self;
    }
    return _provincePickerView;
}

-(UIPickerView *)cityPickerView{
    if(_cityPickerView == nil){
        _cityPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(ScreenWidth/3, ContentHeight - STHeight(300), ScreenWidth /3, STHeight(300))];
        _cityPickerView.showsSelectionIndicator = YES;
        _cityPickerView.backgroundColor = cwhite;
        _cityPickerView.delegate = self;
        _cityPickerView.dataSource = self;
    }
    return _cityPickerView;
}

-(UIPickerView *)districtPickerView{
    if(_districtPickerView == nil){
        _districtPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(ScreenWidth * 2/3, ContentHeight - STHeight(300), ScreenWidth /3, STHeight(300))];
        _districtPickerView.showsSelectionIndicator = YES;
        _districtPickerView.backgroundColor = cwhite;
        _districtPickerView.delegate = self;
        _districtPickerView.dataSource = self;
    }
    return _districtPickerView;
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
    NSString *addressStr = [self getAddressJsonStr];
    NSMutableArray *provinceArray = [AddressLayerModel mj_objectArrayWithKeyValuesArray:addressStr];
    for(AddressLayerModel *model in provinceArray){
        [_provinceDatas addObject:model];
    }
    
    AddressLayerModel *provinceModel = [_provinceDatas objectAtIndex:provinceIndex];
    NSMutableArray *cityArray =  [AddressLayerModel mj_objectArrayWithKeyValuesArray:provinceModel.sub];
    for(AddressLayerModel *model in cityArray){
        [_cityDatas addObject:model];
    }
    
    AddressLayerModel *cityModel = [_cityDatas objectAtIndex:cityIndex];
    NSMutableArray *districtArray = [AddressLayerModel mj_objectArrayWithKeyValuesArray:cityModel.sub];
    for(AddressLayerModel *model in districtArray){
        [_districtDatas addObject:model];
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



@end