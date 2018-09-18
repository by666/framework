//
//  VideoViewModel.h
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYManager.h"

@protocol VideoViewDelegate<BaseRequestDelegate>

-(void)onDoReject;

@end

@interface VideoViewModel : NSObject

@property(weak, nonatomic)id<VideoViewDelegate> delegate;

//接听
-(void)doAccept;

//拒绝
-(void)doReject;

//静音
-(Boolean)doMute;

//切换镜头
-(Boolean)changeDisplay;

//音视频转换
-(Boolean)changeAudioOrVideo;

//开门
-(void)openDoor;

//计时
-(void)countTime;


@end
