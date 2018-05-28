//
//  AuthUserViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AuthUserViewModel.h"

@implementation AuthUserViewModel

-(instancetype)init{
    if(self == [super init]){
        _data = [[UserAuthModel alloc]init];
    }
    return self;
}


-(void)goCommunityPage{
    if(_delegate){
        [_delegate onGoCommunity];
    }
}

-(void)submitUserInfo{
    if(_delegate){
        if(IS_NS_STRING_EMPTY(_data.communityName)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NOCOMMUNITY];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.building)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NOBUILDING];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.doorNum)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NODOORNUM];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.name)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NONAME];
            return;
        }
        if(IS_NS_STRING_EMPTY(_data.idNum)){
            [_delegate submitUserInfo:NO msg:MSG_AUTHUSER_ERROR_NOIDNUM];
            return;
        }
        [_delegate submitUserInfo:YES msg:MSG_SUCCESS];
    }
}

@end
