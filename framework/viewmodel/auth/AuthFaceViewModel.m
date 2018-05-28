//
//  AuthFaceViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/28.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthFaceViewModel.h"
@interface AuthFaceViewModel()

@property(assign, nonatomic)float progress;
@end

@implementation AuthFaceViewModel

-(void)addPhoto{
    if(_delegate){
        [_delegate onAddPhoto];
    }
}

-(void)commitUserInfo{
    if(_delegate){
        if(_progress == 0.0f){
            [_delegate onCommitStart];
        }
        if(_progress >= 1){
            [_delegate onCommitEnd];
        }else{
            [self doProgress];
        }
    }
}

-(void)doProgress{
    _progress +=0.1f;
    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.delegate onCommitProgress:weakSelf.progress];
        [self commitUserInfo];
    });
}

-(void)goMainPage{
    if(_delegate){
        [_delegate onGoMainPage];
    }
}

@end
