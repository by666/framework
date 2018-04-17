//
//  TestViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "TestViewModel.h"

@implementation TestViewModel

-(instancetype)initWithDelegate:(id<TestViewModelProtocol>)delegate{
    if(self == [super init]){
        _viewModelDelegate = delegate;
    }
    return self;
}

-(void)requestModel:(void (^)(id))result{
    TestModel *model = [[TestModel alloc]init];
    model.username = @"by";
    model.password = @"123456";
    result(model);
}

@end
