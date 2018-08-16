//
//  DeviceShareHistoryViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "DeviceShareHistoryViewModel.h"
#import "TestModelManager.h"

@implementation DeviceShareHistoryViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)requestDatas{
    if(_delegate){
        _datas = [TestModelManager sharedTestModelManager].deviceShareDatas;
        [_delegate onRequestDatas:YES];
    }
}
@end
