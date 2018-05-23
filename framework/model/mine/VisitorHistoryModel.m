//
//  VisitorHistoryModel.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryModel.h"

@implementation VisitorHistoryModel


+(VisitorHistoryModel *)buildModel:(NSString *)name enterTime:(NSString *)enterTime exitTime:(NSString *)exitTime{
    VisitorHistoryModel *model = [[VisitorHistoryModel alloc]init];
    model.name = name;
    model.enterTime = enterTime;
    model.exitTime = exitTime;
    return model;
}

@end
