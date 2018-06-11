//
//  DeviceShareHistoryModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareHistoryModel.h"

@implementation DeviceShareHistoryModel


+(NSMutableArray *)getTestDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [datas addObject:[self buildModel:@"10000001" orderStatu:@"已支付" imageSrc:@"ic_冲击钻" name:@"冲击钻" price:@"15" total:@"45" days:@"3"]];
    [datas addObject:[self buildModel:@"10000002" orderStatu:@"已支付" imageSrc:@"ic_打气筒" name:@"打气筒" price:@"5" total:@"30" days:@"6"]];
    [datas addObject:[self buildModel:@"10000003" orderStatu:@"已支付" imageSrc:@"ic_电烤箱" name:@"电烤箱" price:@"10" total:@"20" days:@"2"]];
    [datas addObject:[self buildModel:@"10000004" orderStatu:@"已支付" imageSrc:@"ic_轮椅" name:@"轮椅" price:@"20" total:@"100" days:@"5"]];
    [datas addObject:[self buildModel:@"10000005" orderStatu:@"已支付" imageSrc:@"ic_轮椅" name:@"轮椅" price:@"20" total:@"400" days:@"20"]];
    return datas;
}

+(DeviceShareHistoryModel *)buildModel:(NSString *)orderNum orderStatu:(NSString *)orderStatu imageSrc:(NSString *)imageSrc name:(NSString *)name price:(NSString *)price total:(NSString *)total days:(NSString *)days{
    DeviceShareHistoryModel *model = [[DeviceShareHistoryModel alloc]init];
    model.orderNum = orderNum;
    model.orderStatu = orderStatu;
    model.imageSrc = imageSrc;
    model.name = name;
    model.price = price;
    model.total = total;
    model.days = days;
    return model;
}
@end
