//
//  ViewController.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "TestViewModel.h"

@interface ViewController ()

@property (strong, nonatomic)TestViewModel *mViewModel;

@end

@implementation ViewController


+(instancetype)allocWithZone:(struct _NSZone *)zone{
    ViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        TestViewModel *viewModel = [[TestViewModel alloc]init];
        [viewController initView:viewModel];
    }];
    return viewController;
}


-(void)initView:(TestViewModel *)viewModel{
    TestView *testView = [[TestView alloc]init];
    [testView bindViewModel:viewModel];
    [self.view addSubview:testView];
}





@end
