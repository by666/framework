//
//  ByViewController.m
//  framework
//
//  Created by 黄成实 on 2018/4/20.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ByViewController.h"
#import "ByViewModel.h"
#import "ByView.h"


@interface ByViewController ()
@property (strong, nonatomic)ByViewModel *mByViewModel;

@end

@implementation ByViewController


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad{
    [self hideNavigationBar:YES];
    [self.view setBackgroundColor:c01];
    [self initBodyView];
}

-(void)initBodyView{
    _mByViewModel = [[ByViewModel alloc]init];
    ByView *byView = [[ByView alloc]initWithViewModel:_mByViewModel];
    [self.view addSubview:byView];
}

@end
