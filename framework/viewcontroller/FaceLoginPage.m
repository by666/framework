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
#import "MainPage.h"
@interface FaceLoginPage ()<FaceLoginDelegate,STNavigationViewDelegate>

@property(strong, nonatomic)FaceLoginView *mFaceLoginView;
@property(strong, nonatomic)FaceLoginViewModel *mViewModel;
@property(strong, nonatomic)STNavigationView *mNavigationView;
@end

@implementation FaceLoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    [self setStatuBarBackgroud:cwhite];
}

-(void)initView{
    _mViewModel = [[FaceLoginViewModel alloc]init];
    _mViewModel.delegate = self;
    
    _mNavigationView = [[STNavigationView alloc]initWithTitle:@"人脸登录" needBack:YES];
    _mNavigationView.delegate = self;
    [self.view addSubview:_mNavigationView];
    
    _mFaceLoginView = [[FaceLoginView alloc]initWithViewModel:_mViewModel];
    _mFaceLoginView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _mFaceLoginView.backgroundColor = cwhite;
    [self.view addSubview:_mFaceLoginView];
}


-(void)dealloc{
    [_mFaceLoginView releaseCamera];
}
-(void)OnBackBtnClicked{
    [self backLastPage];
}

-(void)onGoMainPage{
   
    [STAlertUtil showAlertController:@"验证通过" content:@"登录成功" controller:self];
}

-(void)onDetectOutOfTime{
    __weak FaceLoginPage *weakSelf = self;
    [STAlertUtil showAlertController:MSG_DETECT_OUTOFTIME content:MSG_OUTOFTIME_CONTENT controller:self confirm:^{
        [weakSelf.mFaceLoginView startDetect];
    } cancel:^{
        [weakSelf.mFaceLoginView startDetect];
    }];
}

-(void)onFaceDetectResult:(Boolean)success{
    
}

@end
