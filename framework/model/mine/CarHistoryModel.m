//
//  CarHistoryModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/22.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "CarHistoryModel.h"

@implementation CarHistoryModel

+(CarHistoryModel *)buildModel:(NSString *)carNum name:(NSString *)name enterTime:(NSString *)enterTime exitTime:(NSString *)exitTime hasPaid:(Boolean)hasPaid{
    CarHistoryModel *model = [[CarHistoryModel alloc]init];
    model.carNum = carNum;
    model.name = name;
    model.enterTime = enterTime;
    model.exitTime = exitTime;
    model.hasPaid = hasPaid;
    return model;
}

@end
