//
//  HabitantViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "HabitantViewModel.h"

@implementation HabitantViewModel

-(instancetype)initWithController:(BaseViewController *)controller{
    if(self == [super init]){
        self.controller = controller;
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}

-(HabitantModel *)buildModel:(NSString *)name identify:(NSString *)identify validDate:(NSString *)validDate{
    HabitantModel *model = [[HabitantModel alloc]init];
    model.name = name;
    model.identify = identify;
    model.validDate = validDate;
    return model;
}



-(void)requestDatas{
    //todo 网络请求
    [_datas addObject:[self buildModel:@"张三丰" identify:@"家属" validDate:@"永久"]];
    [_datas addObject:[self buildModel:@"杨过" identify:@"租客" validDate:@"2018年12月31日"]];
    [_datas addObject:[self buildModel:@"乔峰" identify:@"租客" validDate:@"2019年12月31日"]];
    [_datas addObject:[self buildModel:@"扫地僧" identify:@"租客" validDate:@"永久"]];
    if(_delegate){
        [_delegate onRequestSuccess:_datas];
    }

}


-(void)deleteHabitant:(HabitantModel *)model{
    
}

-(void)updateHabitant:(HabitantModel *)model{
    
}

@end