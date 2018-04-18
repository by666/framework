//
//  ViewController.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ViewController.h"
#import "ByViewModel.h"
#import "ByView.h"

@interface ViewController ()

@property (strong, nonatomic)ByViewModel *mByViewModel;

@end

@implementation ViewController



-(void)viewDidLoad{
    _mByViewModel = [[ByViewModel alloc]init];
    ByView *byView = [[ByView alloc]initWithViewModel:_mByViewModel];
    [self.view addSubview:byView];
   
}






@end
