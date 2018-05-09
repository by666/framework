//
//  MainPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainPage.h"
#import "MainViewModel.h"
#import "MainView.h"

@interface MainPage ()<MainViewDelegate>

@property(strong, nonatomic)MainViewModel *mViewModel;
@property(strong, nonatomic)MainView *mMainView;

@end

@implementation MainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _mViewModel = [[MainViewModel alloc]init];
    _mViewModel.delegate = self;
    [self initView];
}

-(void)initView{
    _mMainView = [[MainView alloc]initWithViewModel:_mViewModel];
    _mMainView.frame = CGRectMake(0, StatuBarHeight, ScreenWidth, ScreenHeight - StatuBarHeight);
    _mMainView.backgroundColor = c01;
    [self.view addSubview:_mMainView];
}

@end
