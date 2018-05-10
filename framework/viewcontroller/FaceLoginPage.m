//
//  FaceLoginPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceLoginPage.h"
#import "FaceLoginViewModel.h"
#import "FaceLoginView.h"
#import "STNavigationView.h"
@interface FaceLoginPage ()<FaceLoginDelegate,STNavigationViewDelegate>

@property(strong, nonatomic)FaceLoginView *mFaceLoginView;
@property(strong, nonatomic)FaceLoginViewModel *mViewModel;
@property(strong, nonatomic)STNavigationView *mNavigationView;
@end

@implementation FaceLoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _mViewModel = [[FaceLoginViewModel alloc]init];
    _mViewModel.delegate = self;
    
    _mNavigationView = [[STNavigationView alloc]initWithTitle:@"人脸登录" needBack:YES];
    _mNavigationView.delegate = self;
    [self.view addSubview:_mNavigationView];
    
    _mFaceLoginView = [[FaceLoginView alloc]initWithViewModel:_mViewModel];
    _mFaceLoginView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _mFaceLoginView.backgroundColor = c01;
    [self.view addSubview:_mFaceLoginView];
}


-(void)OnBackBtnClicked{
    [self backLastPage];
}

-(void)onFaceDetectResult:(Boolean)success{
    
}

@end
