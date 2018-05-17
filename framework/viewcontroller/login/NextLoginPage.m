//
//  NextLoginPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "NextLoginPage.h"
#import "NextLoginView.h"
#import "NextLoginViewModel.h"
#import "LoginPage.h"
#import "FaceLoginPage.h"
@interface NextLoginPage ()<NextLoginDelegate>

@end

@implementation NextLoginPage

+(void)show:(BaseViewController *)controller{
    NextLoginPage *page = [[NextLoginPage alloc]init];
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    
    self.view.backgroundColor = cwhite;
    
    NextLoginViewModel *viewModel = [[NextLoginViewModel alloc]init];
    viewModel.delegate = self;
    NextLoginView *nextLoginView = [[NextLoginView alloc]initWithViewModel:viewModel];
    nextLoginView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:nextLoginView];
    
    
}

-(void)onGoFaceLoginPage{
    FaceLoginPage *page = [[FaceLoginPage alloc]init];
    [self pushPage:page];
}

-(void)onGoLoginPage{
    LoginPage *page = [[LoginPage alloc]init];
    [self pushPage:page];
}



@end
