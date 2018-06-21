//
//  FaceBaseViewController.m
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceEnterPage2.h"
#import "ImageUtils.h"
#import "CircularProgressView.h"
#import "FaceEnterView2.h"

@interface FaceEnterPage2 () <FaceEnterViewDelegate2>

@property(strong, nonatomic)FaceEnterView2 *faceEnterView;
@property(strong, nonatomic)FaceEnterViewModel2 *viewModel;

@end

@implementation FaceEnterPage2

+(void)show:(BaseViewController *)controller{
    FaceEnterPage2 *page = [[FaceEnterPage2 alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:MSG_AUTHFACE_TITLE needback:YES];
    
    self.view.backgroundColor = cwhite;
    
    _viewModel = [[FaceEnterViewModel2 alloc]init];
    _viewModel.delegate = self;
    _faceEnterView = [[FaceEnterView2 alloc]initWithViewModel:_viewModel];
    _faceEnterView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _faceEnterView.backgroundColor = cwhite;
    [self.view addSubview:_faceEnterView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppWillResignAction) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(_viewModel){
        [_viewModel startFaceDetect];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if(_viewModel){
        [_viewModel stopFaceDetect];
    }
}


#pragma mark - Notification

- (void)onAppWillResignAction {
    if(_viewModel){
        [_viewModel appResign];
    }
}

- (void)onAppBecomeActive {
    if(_viewModel){
        [_viewModel appActive];
    }
}


-(void)onCaptureError:(NSString *)errorStr{
    [STToastUtil showFailureAlertSheet:errorStr];
}

-(void)updatePreviewImage:(UIImage *)image{
    if(_faceEnterView){
        [_faceEnterView updatePreviewImage:image];
    }
}

-(void)onDetectFaceResult:(Boolean)success image:(UIImage *)image tips:(NSString *)tips{
    if(_faceEnterView){
        [_faceEnterView onDetectFaceResult:success image:image tips:tips];
    }
}

-(void)onGoBack{
    [self backLastPage];
}

@end
