//
//  STBuildingLayerView.m
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STBuildingLayerView.h"
#import "BuildingLayerModel.h"
#import "BuildingModel.h"
#import "BuildingRespondModel.h"

@interface STBuildingLayerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)NSMutableArray *pickerViews;
@property(strong, nonatomic)NSMutableArray *allDatas;


@end


@implementation STBuildingLayerView{
    NSInteger count;
    NSInteger index;
    BuildingRespondModel *fatherModel;
    NSString *result;
}

-(instancetype)initWithFrame:(CGRect)frame data:(id)data level:(int)level{
    if(self == [super init]){
        self.frame = frame;
        count = level;
        index = 0;
        _pickerViews = [[NSMutableArray alloc]init];
        [self setupDatas:data level:level];
        [self initView];
    }
    return self;
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



-(void)initView{
    self.backgroundColor = [cblack colorWithAlphaComponent:0.8];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnClickLayerView)];
    [self addGestureRecognizer:recognizer];
    
    if(IS_NS_COLLECTION_EMPTY(_allDatas)){
        return;
    }
    
    for(int i = 0 ; i < count ; i++){
        UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(i * (ScreenWidth / count), ContentHeight - STHeight(200), ScreenWidth /count, STHeight(200))];
        picker.showsSelectionIndicator = YES;
        picker.backgroundColor = cwhite;
        picker.delegate = self;
        picker.dataSource = self;
        picker.tag = i;
        [self addSubview:picker];
        [_pickerViews addObject:picker];
    }

    [self addSubview:[self cancelBtn]];
    [self addSubview:[self confirmBtn]];
    
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
        BuildingModel *model = [_allDatas objectAtIndex:0];
        result = @"";
        [self generateResult:model index:0];
        if(result.length > 0){
            result = [result substringWithRange:NSMakeRange(0, result.length - 1)];
        }
        NSString *fatherLocator =  fatherModel.layerInfo.layerLocator;
        [_delegate OnBuildingSelectResult:result fatherLocator:fatherLocator];
    }
}

//选中结果处理
-(void)generateResult:(BuildingModel  *)model index:(int)index{
    BuildingRespondModel *selectModel = [model.datas objectAtIndex:model.index];
    result = [result stringByAppendingString:selectModel.layerInfo.layerName];
    result = [result stringByAppendingString:@"，"];
    if(IS_NS_COLLECTION_EMPTY(selectModel.subLayerInfo) || [_allDatas count] == index +1){
        fatherModel = selectModel;
        return;
    }
    BuildingModel *newModel = [_allDatas objectAtIndex:index+1];
    [self generateResult:newModel index:index+1];
}


//初始化数据
-(void)setupDatas:(id)data level:(int)level{
    
    _allDatas = [[NSMutableArray alloc]init];
    for(int i = 0; i < level ; i ++){
        BuildingModel *model = [[BuildingModel alloc]init];
        model.level = i;
        model.index = 0;
        [_allDatas addObject:model];
    }
    
    for(int m=0 ; m < [_allDatas count] ; m ++){
        BuildingModel *model = [_allDatas objectAtIndex:m];
        if(m == 0){
            model.datas = [self splitData:data];
        }else{
            BuildingModel *lastModel = [_allDatas objectAtIndex:m-1];
            NSMutableArray *lastDatas = lastModel.datas;
            if(!IS_NS_COLLECTION_EMPTY(lastDatas)){
                BuildingRespondModel *tempModel = [BuildingRespondModel mj_objectWithKeyValues:[lastDatas objectAtIndex:lastModel.index]];
                model.datas = [self splitData:tempModel.subLayerInfo];
            }
        }
    }
    
}


//获取单列数据
-(NSMutableArray *)splitData:(id)data{
    NSMutableArray *temps = [[NSMutableArray alloc]init];
    NSMutableArray *array = [NSMutableArray mj_objectArrayWithKeyValuesArray:data];
    for(int i = 0 ; i < [array count] ; i ++) {
        BuildingRespondModel *model = [BuildingRespondModel mj_objectWithKeyValues:[array objectAtIndex:i]];
        [temps addObject:model];
        [STLog print:[NSString stringWithFormat:@"%@",model.layerInfo.layerName]];
    }
    return temps;
}


//pickerview回调
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return STHeight(50);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger tag = pickerView.tag;
    BuildingModel *model = [_allDatas objectAtIndex:tag];
    if(IS_NS_COLLECTION_EMPTY(model.datas)){
        return 0;
    }
    return [model.datas count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSInteger tag = pickerView.tag;
    BuildingModel *model = [_allDatas objectAtIndex:tag];
    if(IS_NS_COLLECTION_EMPTY(model.datas)){
        return @"";
    }
    BuildingRespondModel *respondModel = [model.datas objectAtIndex:row];
    return respondModel.layerInfo.layerName;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    @synchronized(self) {
        NSInteger tag = pickerView.tag;
        BuildingModel *model = [_allDatas objectAtIndex:tag];
        model.index = (int)row;
        BuildingRespondModel *selectModel = [model.datas objectAtIndex:model.index];

        [self formatSelectData:selectModel tag:tag model:model];
    }
}



//滚动动态处理
-(void)formatSelectData:(BuildingRespondModel *)selectModel tag:(NSInteger)tag model:(BuildingModel *)tempModel{
    if(tag + 1 == [_allDatas count]){
        return;
    }
    if(IS_NS_COLLECTION_EMPTY(selectModel.subLayerInfo)){
        BuildingModel *model = [_allDatas objectAtIndex:tag+1];
        model.datas = [[NSMutableArray alloc]init];
        
        UIPickerView *pickerView = [_pickerViews objectAtIndex:tag+1];
        [pickerView reloadComponent:0];
        return;
    }
    
    BuildingModel *model = [_allDatas objectAtIndex:tag+1];
    model.index = 0;
    model.datas = [self splitData:selectModel.subLayerInfo];
    BuildingRespondModel *newSelectModel = [model.datas objectAtIndex:model.index];
    
    UIPickerView *pickerView = [_pickerViews objectAtIndex:tag+1];
    [pickerView reloadComponent:0];
    [pickerView selectRow:model.index inComponent:0 animated:YES];
    
    [self formatSelectData:newSelectModel tag:tag+1 model:tempModel];
}

@end

