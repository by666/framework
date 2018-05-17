//
//  FaceEnterPage.m
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceEnterPage.h"
#import "STNavigationView.h"
#import "FaceEnterView.h"
#import "FaceEnterViewModel.h"

@interface FaceEnterPage ()<FaceEnterViewDelegate>

@property(strong, nonatomic)FaceEnterView *mFaceEnterView;
@property(strong, nonatomic)FaceEnterViewModel *mViewModel;
@property(strong, nonatomic)STNavigationView *mNavigationView;

@end

@implementation FaceEnterPage

+(void)show:(BaseViewController *)controller{
    FaceEnterPage *page = [[FaceEnterPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self initView];
}

-(void)initView{
    _mViewModel = [[FaceEnterViewModel alloc]init];
    _mViewModel.delegate = self;
    
    [self showSTNavigationBar:@"人脸登录" needback:YES];
    
    _mFaceEnterView = [[FaceEnterView alloc]initWithViewModel:_mViewModel];
    _mFaceEnterView.frame = CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight);
    _mFaceEnterView.backgroundColor = cwhite;
    [self.view addSubview:_mFaceEnterView];
}

-(void)dealloc{
    if(_mViewModel){
        [_mViewModel releaseCamera];
    }
}

-(void)onFaceDetectResult:(Boolean)success image:(UIImage *)image{
    [_mFaceEnterView updateFaceDetectResult:image];
}

-(void)onGoBack{
    [self backLastPage];
}

@end
