//
//  DeviceShareViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareViewModel.h"

@implementation DeviceShareViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)requestDatas{
    if(_delegate){
        _datas = [DeviceShareModel getTestDatas];
        [_delegate onRequestDatas:YES datas:_datas];
    }
}

-(void)goDeviceShareOrderPage:(DeviceShareModel *)model{
    if(_delegate){
        [_delegate onGoDeviceShareOrderPage:model];
    }
}



@end
