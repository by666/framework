

//
//  CarDetailViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarDetailViewModel.h"

@implementation CarDetailViewModel


-(instancetype)initWithModel:(CarModel *)data{
    if(self == [super init]){
        _data = data;
        _titleDatas = [[NSMutableArray alloc]init];
        [self setData];
    }
    return self;
}

-(void)setData{
    [_titleDatas addObject:[TitleContentModel buildModel:@"车牌号" content:[NSString stringWithFormat:@"%@ %@",_data.carHead,_data.carNum]]];
    [_titleDatas addObject:[TitleContentModel buildModel:@"车主姓名" content:_data.name]];
    [_titleDatas addObject:[TitleContentModel buildModel:@"车辆类型" content:@"月卡A"]];
    [_titleDatas addObject:[TitleContentModel buildModel:@"月卡价格" content:@"300元"]];
    [_titleDatas addObject:[TitleContentModel buildModel:@"月卡有效期" content:@"2018.5.21-2019.5.21"]];
    [_titleDatas addObject:[TitleContentModel buildModel:@"车辆绑定账号" content:_data.name]];
}

-(void)deleteCarData{
    if(_delegate){
        [_delegate onDeleteCarData];
    }
}

-(void)goPaymentPage{
    if(_delegate){
        [_delegate onGoPaymentPage];
    }
}


@end
