//
//  NextLoginViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/14.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "NextLoginViewModel.h"

@implementation NextLoginViewModel


-(void)goLoginPage{
    if(_delegate){
        [_delegate onGoLoginPage];
    }
}

-(void)goFaceLoginPage{
    if(_delegate){
        [_delegate onGoFaceLoginPage];
    }
}

@end
