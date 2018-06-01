//
//  SystemMsgViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/1.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "SystemMsgViewModel.h"

@implementation SystemMsgViewModel

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self setupDatas];
    }
    return self;
}

-(void)setupDatas{
    [_datas addObjectsFromArray:[SystemMsgModel getTestDatas]];
}

-(void)requestNewDatas{
    [_datas removeAllObjects];
    [_datas addObjectsFromArray:[SystemMsgModel getTestDatas]];
    if(_delegate){
        [_delegate onRequestCallback:YES datas:_datas];
    }
}

-(void)requestMoreDatas{
    [_datas addObjectsFromArray:[SystemMsgModel getTestDatas]];
    if(_delegate){
        [_delegate onRequestCallback:YES datas:_datas];
    }
}

-(CGFloat)countDynamicHeight{
    CGFloat height = 0.0f;
    if(IS_NS_COLLECTION_EMPTY(_datas)){
        return STHeight(108);
    }
    @synchronized(self){
        for(SystemMsgModel *model in _datas){
            height += model.height;
        }
    }
    return height;
}

@end
