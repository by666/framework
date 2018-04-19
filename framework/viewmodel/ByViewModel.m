//
//  ByViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ByViewModel.h"

@interface ByViewModel()

@property (strong, nonatomic) ByModel *mByModel;

@end

@implementation ByViewModel


-(instancetype)init{
    if(self == [super init]){
        _mByModel = [[ByModel alloc]init];
    }
    return self;
}


-(ByModel *)requestData{
    _mByModel.test1 = @"测试标题";
    _mByModel.test2 = @"测试内容";
    return _mByModel;
}

-(void)changeData : (id<ByViewModelProtocol>) delegate{
    _mByModel.test1 = @"改变标题";
    if(delegate){
        [delegate updateView:_mByModel];
    }
}

@end
