//
//  TestView.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "TestView.h"
#import "TestViewModel.h"

@interface TestView()

@property (strong, nonatomic) TestViewModel *testViewModel;

@end

@implementation TestView

-(instancetype)init{
    if(self == [super init]){
        _testViewModel = [[TestViewModel alloc]init];
        [self initView];
    }
    return self;
}


-(void)initView{
    self.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    self.backgroundColor = [UIColor redColor];
}

-(void)bindViewModel:(TestViewModel *)viewModel{
    @weakify(self)
    [viewModel requestModel:^(id datas) {
        @strongify(self)
        [self updateView];
    }];
   
}



-(void)updateView{
    
}

@end
