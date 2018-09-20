//
//  VideoViewModel.m
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VideoViewModel.h"
#import "WYManager.h"
#import "STTimeUtil.h"

@interface VideoViewModel()

@property(assign, nonatomic)long count;
@property(assign, nonatomic)Boolean hasCallHungup;
@end

@implementation VideoViewModel



-(void)doAccept:(UInt64)callID{
    [[WYManager sharedWYManager]doRespond:callID accept:YES];
}

-(void)doAccept:(UInt64)callID videoView:(UIView *)videoView{
    [[WYManager sharedWYManager] setVideoView:videoView];
    [[WYManager sharedWYManager] doRespond:callID accept:YES];
}


-(void)doReject:(UInt64)callID{
    [[WYManager sharedWYManager] doRespond:callID accept:NO];
    if(_delegate){
        [_delegate onRejectOrHungUp];
    }
    _hasCallHungup = YES;
}

-(void)doHungup:(UInt64)callID{
    [[WYManager sharedWYManager] doHangup:callID];
    if(_delegate){
        [_delegate onRejectOrHungUp];
    }
    _hasCallHungup = YES;
}

-(void)doMute:(Boolean)isMute{
    [[WYManager sharedWYManager]doMute:isMute];
}


-(void)changeDisplay{
    [[WYManager sharedWYManager]changeDisplay];
}


-(void)countTime{
    WS(weakSelf)
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if(weakSelf.hasCallHungup){
                weakSelf.count = 0;
                dispatch_cancel(timer);
            }else{
                weakSelf.count ++;
                if(weakSelf.delegate){
                    [weakSelf.delegate onCountTime:[STTimeUtil getCallTime:weakSelf.count]];
                }
            }
        });
    });
    dispatch_resume(timer);
}

-(void)changeAudioOrVideo:(Boolean)isAudio{
    [[WYManager sharedWYManager] doChangeAudioOrVideo:isAudio];
}

-(void)openDoor{}

@end
