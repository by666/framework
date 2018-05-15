//
//  FaceLoginViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "FaceLoginViewModel.h"

@implementation FaceLoginViewModel



-(void)startFaceDetect{
    
}

-(void)goMainPage{
    if(_delegate){
        [_delegate onGoMainPage];
    }
}

-(void)detectOutOfTime{
    if(_delegate){
        [_delegate onDetectOutOfTime];
    }
}
@end
