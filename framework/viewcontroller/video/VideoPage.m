//
//  VideoPage.m
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VideoPage.h"
#import "VideoView.h"
#import "STObserverManager.h"
@interface VideoPage ()<VideoViewDelegate,STObserverProtocol>

@property(strong, nonatomic)VideoView *videoView;
@property(assign, nonatomic)UInt64 callID;
@property(strong, nonatomic)VideoViewModel *viewModel;
@property(strong, nonatomic)UserModel *callerModel;

@end

@implementation VideoPage


+(void)show:(BaseViewController *)controller callID:(UInt64)callID userModel:(UserModel *)model{
    VideoPage *page = [[VideoPage alloc]init];
    page.callID = callID;
    page.callerModel  = model;
    [controller presentViewController:page animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_CALL_ACCEPT delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_CALL_REJECT delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_CALL_CALLING delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_CALL_HUNGUP delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_CALL_CONNECTED delegate:self];
    [[STObserverManager sharedSTObserverManager] registerSTObsever:Notify_CALL_DISCONNECT delegate:self];

}

-(void)dealloc{
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_CALL_ACCEPT];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_CALL_REJECT];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_CALL_CALLING];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_CALL_HUNGUP];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_CALL_CONNECTED];
    [[STObserverManager sharedSTObserverManager] removeSTObsever:Notify_CALL_DISCONNECT];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatuBarBackgroud:c39];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)initView{
    _viewModel = [[VideoViewModel alloc]initWithCaller:_callerModel];
    _viewModel.delegate = self;
    
    _videoView = [[VideoView alloc]initWithViewModel:_viewModel callID:_callID];
    _videoView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _videoView.backgroundColor =c39;
    [self.view addSubview:_videoView];
}

-(void)onRejectOrHungUp{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onReciveResult:(NSString *)key msg:(id)msg{
    UInt64 callID = [msg intValue];
    if([key isEqualToString:Notify_CALL_HUNGUP]){
        [_viewModel doHungup:callID];
    }else if([key isEqualToString:Notify_CALL_ACCEPT]){
        
    }else if([key isEqualToString:Notify_CALL_REJECT]){
        
    }else if([key isEqualToString:Notify_CALL_CALLING]){
        
    }else if([key isEqualToString:Notify_CALL_HUNGUP]){
        [_viewModel doHungup:callID];
    }else if([key isEqualToString:Notify_CALL_CONNECTED]){
        [_viewModel countTime];
    }else if([key isEqualToString:Notify_CALL_DISCONNECT]){
        [_viewModel doHungup:callID];
    }
}

-(void)onCountTime:(NSString *)timeStr{
    if(_videoView){
        [_videoView updateTime:timeStr];
    }
}

-(void)onRequestBegin{
    
}

-(void)onRequestSuccess:(RespondModel *)respondModel data:(id)data{
    
}

-(void)onRequestFail:(NSString *)msg{
    
}



@end
