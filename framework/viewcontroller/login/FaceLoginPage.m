//
//  FaceBaseViewController.m
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceLoginPage.h"
#import "ImageUtils.h"
#import "CircularProgressView.h"
#import "FaceLoginView.h"
#import "MainPage.h"

@interface FaceLoginPage () <FaceLoginViewDelegate>

@property(strong, nonatomic)FaceLoginView *faceLoginView;
@property(strong, nonatomic)FaceLoginViewModel *viewModel;

@end

@implementation FaceLoginPage

+(void)show:(BaseViewController *)controller{
    FaceLoginPage *page = [[FaceLoginPage alloc]init];
    [controller pushPage:page];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self showSTNavigationBar:MSG_FACE_LOGIN needback:YES];
    
    self.view.backgroundColor = cwhite;
    
    _viewModel = [[FaceLoginViewModel alloc]init];
    _viewModel.delegate = self;
    _faceLoginView = [[FaceLoginView alloc]initWithViewModel:_viewModel];
    _faceLoginView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _faceLoginView.backgroundColor = cwhite;
    [self.view addSubview:_faceLoginView];
    
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
    if(_faceLoginView){
        [_faceLoginView updatePreviewImage:image];
    }
}

-(void)onDetectFaceResult:(Boolean)success image:(UIImage *)image tips:(NSString *)tips{
    if(_faceLoginView){
        [_faceLoginView onDetectFaceResult:success image:image tips:tips];
    }
}

-(void)onGoBack{
    [self backLastPage];
}

-(void)onRequestBegin{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)onRequestFail:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showFailureAlertSheet:msg];
    [self backLastPage];
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [STToastUtil showSuccessTips:MSG_LOGIN_SUCCESS];
    [MainPage show:self];
}

-(void)onProgress:(double)progress{
    if(_faceLoginView){
        [_faceLoginView onProgress:progress];
    }
}

-(void)onShowOvertimeDialog{
    WS(weakSelf)
    [STAlertUtil showAlertController:MSG_FACELOGIN_ALERT_TITLE content:MSG_FACELOGIN_ALERT_CONTENT controller:self confirm:^{
        [weakSelf.viewModel startFaceDetect];
    } cancel:^{
        [weakSelf backLastPage];
    } confirmStr:MSG_ONCE cancelStr:MSG_EXIT];
}

@end
