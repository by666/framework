//
//  STBuildingLayerView.m
//  framework
//
//  Created by 黄成实 on 2018/5/25.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STBuildingLayerView.h"
#import "BuildingLayerModel.h"

@interface STBuildingLayerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong, nonatomic)NSMutableArray *mDatas;
@property(strong, nonatomic)NSMutableArray *mSubDatas;
@property(strong, nonatomic)NSMutableArray *mSubSubDatas;
@property(strong, nonatomic)UIButton *cancelBtn;
@property(strong, nonatomic)UIButton *confirmBtn;
@property(strong, nonatomic)NSMutableArray *pickerViews;


@end


@implementation STBuildingLayerView{
    NSInteger count;
    NSUInteger index0;
    NSUInteger index1;
    NSUInteger index2;
}

-(instancetype)initWithFrame:(CGRect)frame datas:(NSMutableArray *)datas{
    if(self == [super init]){
        self.frame = frame;
        _mDatas = [[NSMutableArray alloc]init];
        _mSubDatas = [[NSMutableArray alloc]init];
        _mSubSubDatas = [[NSMutableArray alloc]init];
        _pickerViews = [[NSMutableArray alloc]init];
        index0 = 0;
        index1 = 0;
        index2 = 0;
        [self setupDatas];
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
    
    if(IS_NS_COLLECTION_EMPTY(_mDatas)){
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
        NSString *result = @"";
        if(!IS_NS_COLLECTION_EMPTY(_mDatas)){
            BuildingLayerModel *model = [_mDatas objectAtIndex:index0];
            result = [result stringByAppendingString:model.name];
            result = [result stringByAppendingString:@"，"];
        }
        if(!IS_NS_COLLECTION_EMPTY(_mSubDatas)){
            BuildingLayerModel *model = [_mSubDatas objectAtIndex:index1];
            result =  [result stringByAppendingString:model.name];
            result = [result stringByAppendingString:@"，"];
        }
        if(!IS_NS_COLLECTION_EMPTY(_mSubSubDatas)){
            BuildingLayerModel *model = [_mSubSubDatas objectAtIndex:index2];
            result = [result stringByAppendingString:model.name];
            result = [result stringByAppendingString:@"，"];
        }
        if(result.length > 0){
            result = [result substringWithRange:NSMakeRange(0, result.length - 1)];
        }
        [_delegate OnBuildingSelectResult:result];
    }
}


//初始化数据
-(void)setupDatas{
    

    NSString *jsonStr = [self getBuildingJsonStr];
    NSMutableArray *datas = [BuildingLayerModel mj_objectArrayWithKeyValuesArray:jsonStr];
    for(BuildingLayerModel *model in datas){
        [_mDatas addObject:model];
    }
    
    [self getPickerCount:_mDatas];
    
    [STLog print:[NSString stringWithFormat:@"%ld",count]];
    
    BuildingLayerModel *subModel = [_mDatas objectAtIndex:index1];
    if(IS_NS_COLLECTION_EMPTY(subModel.sub)){
        return;
    }
    NSMutableArray *subArray =  [BuildingLayerModel mj_objectArrayWithKeyValuesArray:subModel.sub];
    for(BuildingLayerModel *model in subArray){
        [_mSubDatas addObject:model];
    }

    BuildingLayerModel *subsubModel = [_mSubDatas objectAtIndex:index2];
    if(IS_NS_COLLECTION_EMPTY(subsubModel.sub)){
        return;
    }
    NSMutableArray *subsubArray = [BuildingLayerModel mj_objectArrayWithKeyValuesArray:subsubModel.sub];
    for(BuildingLayerModel *model in subsubArray){
        [_mSubSubDatas addObject:model];
    }
}

-(void)setData:(NSString *)dataStr{
    NSArray *datas = [dataStr componentsSeparatedByString:@"，"];
    if(IS_NS_COLLECTION_EMPTY(datas)){
        return;
    }
    NSInteger count = [datas count];
    @synchronized(self) {
        if(count > 0){
            if(!IS_NS_COLLECTION_EMPTY(_mDatas)){
                for(int i = 0 ; i < [_mDatas count]  ; i ++){
                    BuildingLayerModel *model = [_mDatas objectAtIndex:i];
                    if([model.name isEqualToString:[datas objectAtIndex:0]]){
                        index0 = i;
                        break;
                    }
                }
                UIPickerView *picker = [_pickerViews objectAtIndex:0];
                [picker selectRow:index0 inComponent:0 animated:YES];
            }
        }
        if(count > 1){
            if(!IS_NS_COLLECTION_EMPTY(_mSubDatas)){
                for(int i = 0 ; i < [_mSubDatas count]  ; i ++){
                    BuildingLayerModel *model = [_mSubDatas objectAtIndex:i];
                    if([model.name isEqualToString:[datas objectAtIndex:1]]){
                        index1 = i;
                    }
                }
                UIPickerView *picker = [_pickerViews objectAtIndex:1];
                [picker selectRow:index1 inComponent:0 animated:YES];
            }
        }
        if(count > 2){
            if(!IS_NS_COLLECTION_EMPTY(_mSubSubDatas)){
                for(int i = 0 ; i < [_mSubSubDatas count]  ; i ++){
                    BuildingLayerModel *model = [_mSubSubDatas objectAtIndex:i];
                    if([model.name isEqualToString:[datas objectAtIndex:2]]){
                        index2 = i;
                    }
                }
                UIPickerView *picker = [_pickerViews objectAtIndex:2];
                [picker selectRow:index2 inComponent:0 animated:YES];
            }
        }
    }
    
}

-(void)getPickerCount:(NSMutableArray *)datas{
    count++;
    if(!IS_NS_COLLECTION_EMPTY(datas)){
        BuildingLayerModel *model = [datas objectAtIndex:0];
        if(!IS_NS_COLLECTION_EMPTY(model.sub)){
            NSMutableArray *subDatas = [BuildingLayerModel mj_objectArrayWithKeyValuesArray:model.sub];
            [self getPickerCount:subDatas];
        }
    }
}


//解析txt
-(NSString *)getBuildingJsonStr{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"building3" ofType:@"txt"];
    NSError  *error;
    NSString *buildStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    }
    return buildStr;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return STHeight(50);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger tag = pickerView.tag;
    if(tag == 0){
        return [_mDatas count];
    }else if(tag == 1){
        return [_mSubDatas count];
    }else if(tag == 2){
        return [_mSubSubDatas count];
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSInteger tag = pickerView.tag;
    if(tag == 0 && !IS_NS_COLLECTION_EMPTY(_mDatas)){
        BuildingLayerModel *data = [_mDatas objectAtIndex:row];
        return data.name;
    }else if(tag == 1 && !IS_NS_COLLECTION_EMPTY(_mSubDatas)){
        BuildingLayerModel *subData = [_mSubDatas objectAtIndex:row];
        return subData.name;
    }else if(tag == 2 && !IS_NS_COLLECTION_EMPTY(_mSubSubDatas)){
        BuildingLayerModel *subsubData = [_mSubSubDatas objectAtIndex:row];
        return subsubData.name;
    }
    return @"";
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    @synchronized(self) {
        NSInteger tag = pickerView.tag;
        if(tag == 0){
            index0 = row;
            BuildingLayerModel *data = [_mDatas objectAtIndex:index0];
            
            if(IS_NS_COLLECTION_EMPTY(data.sub)){
                return;
            }
            [_mSubDatas removeAllObjects];
            NSMutableArray *subArray =  [BuildingLayerModel mj_objectArrayWithKeyValuesArray:data.sub];
            for(BuildingLayerModel *model in subArray){
                [_mSubDatas addObject:model];
            }
            index1 = 0;
            UIPickerView *pickerView1 = [_pickerViews objectAtIndex:1];
            [pickerView1 reloadComponent:0];
            [pickerView1 selectRow:index1 inComponent:0 animated:YES];
            
            
            BuildingLayerModel *subsubData = [_mSubDatas objectAtIndex:index1];
            if(IS_NS_COLLECTION_EMPTY(subsubData.sub)){
                return;
            }
            [_mSubSubDatas removeAllObjects];
        
            NSMutableArray *subsubArray = [BuildingLayerModel mj_objectArrayWithKeyValuesArray:subsubData.sub];
            for(BuildingLayerModel *model in subsubArray){
                [_mSubSubDatas addObject:model];
            }
            index2 = 0;
            UIPickerView *pickerView2 = [_pickerViews objectAtIndex:2];
            [pickerView2 reloadComponent:0];
            [pickerView2 selectRow:index2 inComponent:0 animated:YES];
            
            
        }else if(tag == 1){
            index1 = row;
            BuildingLayerModel *subModel = [_mSubDatas objectAtIndex:index1];
            if(IS_NS_COLLECTION_EMPTY(subModel.sub)){
                return;
            }
            [_mSubSubDatas removeAllObjects];
         
            index2 = 0;
            NSMutableArray *subsubArray = [BuildingLayerModel mj_objectArrayWithKeyValuesArray:subModel.sub];
            for(BuildingLayerModel *model in subsubArray){
                [_mSubSubDatas addObject:model];
            }
            UIPickerView *pickerView2 = [_pickerViews objectAtIndex:2];
            [pickerView2 reloadComponent:0];
            [pickerView2 selectRow:index2 inComponent:0 animated:YES];
            
            
        }else if(tag == 2){
            index2 = row;
        }
    }
}


@end

