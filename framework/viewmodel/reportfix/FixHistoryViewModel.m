//
//  FixHistoryViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/6/8.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FixHistoryViewModel.h"
#import "TestModelManager.h"
@implementation FixHistoryViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}



-(void)requestNew{
    if(_delegate){
        _datas = [TestModelManager sharedTestModelManager].reportFixDatas;
        [_delegate onRequestDatasCallback:YES datas:_datas];
    }
}

-(void)requestMore{
    if(_delegate){
        _datas = [TestModelManager sharedTestModelManager].reportFixDatas;
        [_delegate onRequestDatasCallback:YES datas:_datas];
    }
}


@end
