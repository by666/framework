//
//  DeviceShareHistoryViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareHistoryViewModel.h"

@implementation DeviceShareHistoryViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)requestDatas{
    if(_delegate){
        _datas = [DeviceShareHistoryModel getTestDatas];
        [_delegate onRequestDatas:YES];
    }
}
@end
