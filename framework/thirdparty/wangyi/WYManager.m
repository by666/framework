//
//  WYManager.m
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "WYManager.h"
#import "NTESGLView.h"

@interface WYManager()<NIMNetCallManagerDelegate>

@property(strong, nonatomic)NTESGLView *remoteGLView;
@property(strong, nonatomic)UIView *myView;
@property(strong, nonatomic)UIView *otherView;

@end

@implementation WYManager
SINGLETON_IMPLEMENTION(WYManager)


#pragma mark 初始化
-(void)initSDK{
    NIMSDKOption *option  = [NIMSDKOption optionWithAppKey:WANGYI_APPKEY];
    option.apnsCername    =  nil;
    option.pkCername      =  nil;
    [[NIMSDK sharedSDK] registerWithOption:option];
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
}

#pragma mark 登录
-(void)doLogin:(NSString *)username psw:(NSString *)password{
    if(_delegate == nil){
        return;
    }
    if(IS_NS_STRING_EMPTY(username) || IS_NS_STRING_EMPTY(password)){
        [_delegate onDoLoginCallback:NO msg:@"用户名或密码为空"];
    }
    WS(weakSelf)
    [[[NIMSDK sharedSDK] loginManager] login:username token:password completion:^(NSError * _Nullable error) {
        if(error == nil){
            [weakSelf.delegate onDoLoginCallback:YES msg:@""];
        }else{
            [weakSelf.delegate onDoLoginCallback:NO msg:@"登录失败"];
        }
    }];
}


#pragma mark 拨号
-(void)doCall:(NSString *)callee{
    if(_delegate == nil){
        return;
    }
    //先初始化 option 参数
    NIMNetCallOption *option = [self getVideoParamOption];
    option.extendMessage = @"音视频请求扩展信息";
    option.apnsContent = @"通话请求";
    option.apnsSound = @"video_chat_tip_receiver.aac";
    
    [self addWaterMark];
    
    //指定通话类型为 视频通话
    NIMNetCallMediaType type = NIMNetCallMediaTypeVideo;
    if(IS_NS_STRING_EMPTY(callee)){
        [_delegate onDoCallCallback:NO msg:@"被叫为空"];
        return;
    }
    NSArray *calleeArray = @[callee];
    WS(weakSelf)
    [[NIMAVChatSDK sharedSDK].netCallManager start:calleeArray type:type option:option completion:^(NSError *error, UInt64 callID) {
        if (!error) {
            [weakSelf.delegate onDoCallCallback:YES msg:@"通话发起成功"];
        }else{
            [weakSelf.delegate onDoCallCallback:NO msg:@"通话发起失败"];
        }
    }];
}

#pragma mark 接听/拒绝
-(void)doRespond:(UInt64)callId accept:(Boolean)accept{
    WS(weakSelf)
    [[NIMAVChatSDK sharedSDK].netCallManager response:callId accept:accept option: [self getVideoParamOption] completion:^(NSError *error, UInt64 callID) {
        if (!error) {
            [weakSelf.delegate onDoRespondCallback:YES msg:@""];
            return ;
        }
        [weakSelf.delegate onDoRespondCallback:NO msg:@"被叫接听失败"];
    }];
}

#pragma mark 挂断
-(void)doHangup{
    UInt64 callId = [[NIMAVChatSDK sharedSDK].netCallManager currentCallID];
    [[NIMAVChatSDK sharedSDK].netCallManager hangup:callId];
}


#pragma mark 静音
-(Boolean)doMute:(Boolean)mute{
    return [[NIMAVChatSDK sharedSDK].netCallManager setMute:mute];
}

#pragma mark 音视频切换
-(void)doChangeAudioOrVideo:(Boolean)isAudio{
    if(isAudio){
        [[NIMAVChatSDK sharedSDK].netCallManager switchType:NIMNetCallMediaTypeAudio];
    }else{
        [[NIMAVChatSDK sharedSDK].netCallManager switchType:NIMNetCallMediaTypeVideo];
    }
}


#pragma mark 视频部分

#pragma mark 设置自己视频显示区域
-(void)setMyView:(UIView *)myView{
    _myView = myView;
}

#pragma mark 设置用户视频显示区域
-(void)setOtherView:(UIView *)otherView{
    _otherView = otherView;
}


#pragma mark 采集渲染
- (void)onLocalDisplayviewReady:(UIView *)displayView
{
    if(_myView){
        displayView.frame = CGRectMake(0, 0, _myView.bounds.size.width, _myView.bounds.size.height);
        [_myView addSubview:displayView];
    }

    if(_otherView){
        _remoteGLView = [[NTESGLView alloc]initWithFrame:CGRectMake(0, 0, _otherView.bounds.size.width, _otherView.bounds.size.height)];
        [_otherView addSubview:_remoteGLView];
    }
    [self startCapture];
}

#pragma mark 开始采集视频
-(void)startCapture{
    NIMNetCallVideoCaptureParam *videoParam = [[NIMNetCallVideoCaptureParam alloc]init];
    videoParam.preferredVideoQuality = NIMNetCallVideoQuality720pLevel;
    //视频采集数据回调
    videoParam.videoHandler =^(CMSampleBufferRef sampleBuffer){
        //对采集数据进行外部前处理
        //        [self addWaterMark];
        //把 sampleBuffer 数据发送给 SDK 进行显示，编码，发送
        [[NIMAVChatSDK sharedSDK].netCallManager sendVideoSampleBuffer:sampleBuffer];
    };
    [[NIMAVChatSDK sharedSDK].netCallManager startVideoCapture:videoParam];
}

#pragma mark 停止采集视频
-(void)stopCapture{
    [[NIMAVChatSDK sharedSDK].netCallManager stopVideoCapture];
}




#pragma mark 获取视频配置
-(NIMNetCallOption *)getVideoParamOption{
    //初始化option
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    
    //指定 option 中的 videoCaptureParam 参数
    NIMNetCallVideoCaptureParam *param = [[NIMNetCallVideoCaptureParam alloc] init];
    param.preferredVideoQuality = NIMNetCallVideoQuality720pLevel;
    param.videoCrop  = NIMNetCallVideoCrop16x9;
    
    NIMNetCallVideoProcessorParam *videoProcessorParam = [[NIMNetCallVideoProcessorParam alloc] init];
    videoProcessorParam.filterType = NIMNetCallFilterTypeZiran;
    
    param.videoProcessorParam = videoProcessorParam;
    option.videoCaptureParam = param;
    
    //打开初始为前置摄像头
    param.startWithBackCamera = NO;
    
    return option;
}

#pragma mark 动态添加水印
-(void)addWaterMark{
    //获取 image 水印图片
    UIImage *image = [UIImage imageNamed:@"ic_cellos_icon"];
    
    //位置为右上 在预览画面的右上角
    NIMNetCallWaterMarkLocation location = NIMNetCallWaterMarkLocationCenter;
    
    //设置水印具体位置 由于水印位置为右上 所以相对于右上角(以右上角为原点) 向下10像素 向左10像素 图片宽50像素 高50像素
    CGRect rect = CGRectMake(10, 10, 50, 50);
    
    //先清除当前水印
    [[NIMAVChatSDK sharedSDK].netCallManager cleanWaterMark];
    
    //添加静态水印
    [[NIMAVChatSDK sharedSDK].netCallManager addWaterMark:image rect:rect location: location];
}

#pragma mark 通话回调
//收到来电邀请
-(void)onReceive:(UInt64)callID from:(NSString *)caller type:(NIMNetCallMediaType)type message:(NSString *)extendMessage{
    if(_delegate ){
        [_delegate onCallStatuCallback:ReciveCall callId:callID caller:caller callee:@"" type:type accept:NO];
    }
}


//主叫收到被叫响应
-(void)onResponse:(UInt64)callID from:(NSString *)callee accepted:(BOOL)accepted{
    if(_delegate){
        [_delegate onCallStatuCallback:RespondCall callId:callID caller:@"" callee:callee type:NIMNetCallMediaTypeVideo accept:accepted];
    }
}

//被叫通话中
-(void)onResponsedByOther:(UInt64)callID accepted:(BOOL)accepted{
    if(_delegate){
        [_delegate onCallStatuCallback:Calling callId:callID caller:@"" callee:@"" type:NIMNetCallMediaTypeVideo accept:accepted];
    }
}


//通话建立成功
-(void)onCallEstablished:(UInt64)callID{
    if(_delegate){
        [_delegate onCallStatuCallback:ConnectSuccess callId:callID caller:@"" callee:@"" type:NIMNetCallMediaTypeVideo accept:NO];
    }
}


//挂断回调
-(void)onHangup:(UInt64)callID by:(NSString *)user{
    if(_delegate){
        [_delegate onCallStatuCallback:Hangup callId:callID caller:user callee:@"" type:NIMNetCallMediaTypeVideo accept:NO];
    }
}

//通话异常断开
-(void)onCallDisconnected:(UInt64)callID withError:(NSError *)error{
    if(_delegate){
        [_delegate onCallStatuCallback:Disconnect callId:callID caller:@"" callee:@"" type:NIMNetCallMediaTypeVideo accept:NO];
    }
}


#pragma mark 视频回调
//接收视频回调
- (void)onRemoteYUVReady:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height
                    from:(NSString *)user
{
    [_remoteGLView render:yuvData width:width height:height];
}


#pragma mark 通话时长
- (void)onSessionTimeDuration:(UInt64)timeDuration{
    if(_delegate){
        [_delegate onTimeDuration:(int)timeDuration];
    }
}


@end
