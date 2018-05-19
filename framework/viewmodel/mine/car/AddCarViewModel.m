//
//  AddCarViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/19.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddCarViewModel.h"

@implementation AddCarViewModel

-(instancetype)init{
    if(self == [super init]){
        _data = [[CarModel alloc]init];
    }
    return self;
}

-(NSArray *)getCarShortHead{
    NSArray *array = @[@"京",@"津",@"沪",@"渝",@"蒙",@"新",@"藏",@"宁",@"桂",@"港",@"澳",@"黑",@"吉",@"辽",@"晋",@"冀",@"青",@"鲁",@"豫",@"苏",@"皖",@"浙",@"闽",@"赣",@"湘",@"鄂",@"粤",@"琼",@"甘",@"陕",@"黔",@"滇",@"川"];
    return array;
}

-(NSArray *)getCarAlphabet{
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    return array;
}

-(void)addCarData{
    if(_delegate){
        if([STPUtil isCarNumberValid:_data.carNum]){
            [_delegate onAddCarDatas:YES data:_data];
        }else{
            [_delegate onAddCarDatas:NO data:_data];
        }
    }
}
@end
