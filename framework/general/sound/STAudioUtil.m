//
//  STAudioUtil.m
//  framework
//
//  Created by by.huang on 2018/9/21.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STAudioUtil.h"
#import <AVFoundation/AVFoundation.h>

@interface STAudioUtil()

@property(strong, nonatomic)AVAudioPlayer *audioPlay;
@end


@implementation STAudioUtil
SINGLETON_IMPLEMENTION(STAudioUtil)

-(void)startPlay:(NSString *)filename{
    NSString *soundPath = [[NSBundle mainBundle]pathForResource:filename ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    self.audioPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
    self.audioPlay.volume = 1;
    self.audioPlay.numberOfLoops =-1;
    self.audioPlay.currentTime = 0;
    [self.audioPlay prepareToPlay];
    [self.audioPlay play];
}

-(void)stopPlay{
    if(self.audioPlay){
        [self.audioPlay stop];
    }
}
@end
