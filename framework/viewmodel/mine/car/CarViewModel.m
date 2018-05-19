//
//  CarViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarViewModel.h"


@implementation CarViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(CarModel *)buildCarModel:(NSString *)cid carNum:(NSString *)carNum carType:(NSString *)carType carIdentify:(NSInteger)carIdentify carHead:(NSString *)carHead name:(NSString *)name{
    CarModel *model = [[CarModel alloc]init];
    model.cid = cid;
    model.carNum = carNum;
    model.carType = carType;
    model.carIdentify = carIdentify;
    model.carHead = carHead;
    model.name = name;
    return model;
}

-(void)getCarDatas{
    
    [_datas addObject:[self buildCarModel:@"0" carNum:@"Y6666" carType:@"月" carIdentify:1 carHead:@"粤B" name:@"张三丰"]];
    [_datas addObject:[self buildCarModel:@"1" carNum:@"867S3" carType:@"临" carIdentify:1 carHead:@"粤B" name:@"张三丰"]];
    [_datas addObject:[self buildCarModel:@"2" carNum:@"1234H" carType:@"月" carIdentify:0 carHead:@"粤B" name:@"张无忌"]];
    [_datas addObject:[self buildCarModel:@"3" carNum:@"3FC84" carType:@"临" carIdentify:0 carHead:@"粤B" name:@"张翠山"]];
    [_datas addObject:[self buildCarModel:@"4" carNum:@"4380DF" carType:@"临" carIdentify:0 carHead:@"粤B" name:@"小张"]];
    if(_delegate){
        [_delegate onGetCarDatas:YES datas:_datas];
    }
}

-(NSMutableArray *)getMyCarDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for(CarModel *model in _datas){
        if(model.carIdentify == 1){
            [datas addObject:model];
        }
    }
    return datas;
}


-(NSMutableArray *)getFamilyCarDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for(CarModel *model in _datas){
        if(model.carIdentify == 0){
            [datas addObject:model];
        }
    }
    return datas;
}

-(void)deleteCarModel:(CarModel *)model{
    if(_delegate){
        [_delegate onDeleteCarModel:YES model:model];
    }
}

-(void)goAddCarPage{
    if(_delegate){
        [_delegate onGoAddCarPage];
    }
}

-(void)goPaymentPage:(CarModel *)model{
    if(_delegate){
        [_delegate onGoPaymentPage:model];
    }
}

-(void)goPaymentRecordsPage{
    if(_delegate){
        [_delegate onGoPaymentRecordsPage];
    }
}

-(void)goCarDetailPage:(CarModel *)model{
    if(_delegate){
        [_delegate onGoCarDetailPage:model];
    }
}


@end
