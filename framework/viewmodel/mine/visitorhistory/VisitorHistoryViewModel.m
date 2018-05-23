//
//  VisitorHistoryViewModel.m
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VisitorHistoryViewModel.h"

@implementation VisitorHistoryViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self setupDatas];
    }
    return self;
}

-(void)setupDatas{
    [_datas addObject:[VisitorHistoryModel buildModel:@"张三丰" enterTime:@"2018.05.23 11:32" exitTime:@"2018.05.23 17:50"]];
    [_datas addObject:[VisitorHistoryModel buildModel:@"张无忌" enterTime:@"2018.05.22 07:32" exitTime:@"2018.05.22 11:20"]];
    [_datas addObject:[VisitorHistoryModel buildModel:@"郭靖" enterTime:@"2018.05.21 20:32" exitTime:@"2018.05.21 23:34"]];
    [_datas addObject:[VisitorHistoryModel buildModel:@"周伯通" enterTime:@"2018.05.21 12:32" exitTime:@"2018.05.21 23:12"]];
    [_datas addObject:[VisitorHistoryModel buildModel:@"金毛狮王" enterTime:@"2018.05.20 07:32" exitTime:@"2018.05.20 18:43"]];
}


-(void)getVisitoryHistoryDatas{
    if(_delegate){
        [_delegate onGetVisitoryHistoryDatas:YES];
    }
}

-(void)goVisitorPage:(VisitorModel *)model{
    if(_delegate){
        [_delegate onGoVisitorPage:model];
    }
}

@end
