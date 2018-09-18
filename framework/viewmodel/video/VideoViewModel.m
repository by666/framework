//
//  VideoViewModel.m
//  framework
//
//  Created by by.huang on 2018/9/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "VideoViewModel.h"
#import "WYManager.h"

@implementation VideoViewModel


-(instancetype)init{
    if(self == [super init]){
       
    }
    return self;
}



-(void)doAccept{}


-(void)doReject{
    if(_delegate){
        [[WYManager sharedWYManager]doHangup];
        [_delegate onDoReject];
    }
}


-(Boolean)doMute{
    return NO;
}

-(Boolean)changeDisplay{
    return NO;
}

-(Boolean)changeAudioOrVideo{
    return NO;
}

-(void)openDoor{}

-(void)countTime{
    if(_delegate){
        
    }
}
@end
