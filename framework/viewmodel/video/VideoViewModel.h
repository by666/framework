//
//  VideoViewModel.h
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYManager.h"
#import "UserModel.h"

@protocol VideoViewDelegate<BaseRequestDelegate>

-(void)onRejectOrHungUp;
-(void)onCountTime:(NSString *)timeStr;
@end

@interface VideoViewModel : NSObject

@property(weak, nonatomic)id<VideoViewDelegate> delegate;
@property(strong, nonatomic)UserModel *callerModel;

-(instancetype)initWithCaller:(UserModel *)callerModel;

//音频接听
-(void)doAccept:(UInt64)callID;

//音视频接听
-(void)doAccept:(UInt64)callID videoView:(UIView *)videoView;

//拒绝
-(void)doReject:(UInt64)callID;

//静音
-(void)doMute:(Boolean)isMute;

//挂断
-(void)doHungup:(UInt64)callID;

//切换镜头
-(void)changeDisplay;

//计算时间
-(void)countTime;

//音视频转换
-(void)changeAudioOrVideo:(Boolean)isAudio;

//开门
-(void)openDoor;




@end
