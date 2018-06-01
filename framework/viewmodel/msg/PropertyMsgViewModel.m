//
//  PropertyMsgViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "PropertyMsgViewModel.h"

@implementation PropertyMsgViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self setupDatas];
    }
    return self;
}

-(void)setupDatas{
    [_datas addObjectsFromArray:[PropertyMsgModel getTestDatas]];
}

-(void)requestNewDatas{
    [_datas removeAllObjects];
    [_datas addObjectsFromArray:[PropertyMsgModel getTestDatas]];
    if(_delegate){
        [_delegate onRequestCallback:YES datas:_datas];
    }
}

-(void)requestMoreDatas{
    [_datas addObjectsFromArray:[PropertyMsgModel getTestDatas]];
    if(_delegate){
        [_delegate onRequestCallback:YES datas:_datas];
    }
}

@end
