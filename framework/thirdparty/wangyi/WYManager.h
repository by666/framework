//
//  WYManager.h
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>

typedef NS_ENUM(NSInteger,CallStatu){
    ReciveCall = 0, //被叫收到来电邀请
    RespondCall = 1,    //被叫接听或拒接主叫来电
    Calling = 2,        //被叫正在通话中
    ConnectSuccess = 3, //通话建立成功
    Hangup = 4,         //通话挂断
    Disconnect = 5,     //连接异常挂断
};

@protocol WYDelegate

-(void)onDoLoginCallback:(Boolean)success msg:(NSString *)errorMsg;
-(void)onDoCallCallback:(Boolean)success msg:(NSString *)errorMsg;
-(void)onDoRespondCallback:(Boolean)success msg:(NSString *)errorMsg;
-(void)onCallStatuCallback:(CallStatu)statu callId:(UInt64)callID caller:(NSString *)caller callee:(NSString *)callee type:(NIMNetCallMediaType)type accept:(Boolean)accept;
-(void)onRecordCall:(NIMNetCallNotificationContent *)content;


@end

@interface WYManager : NSObject
SINGLETON_DECLARATION(WYManager)

@property(weak, nonatomic)id<WYDelegate> delegate;

-(void)initSDK;

-(void)doLogin:(NSString *)username psw:(NSString *)password;

-(void)doCall:(NSString *)callee;

-(void)doRespond:(UInt64)callId accept:(Boolean)accept;

-(Boolean)doMute:(Boolean)mute;

-(void)doHangup:(UInt64)callID;

-(void)doChangeAudioOrVideo:(Boolean)isAudio;

-(void)setVideoView:(UIView *)videoView;

-(void)changeDisplay;
@end
