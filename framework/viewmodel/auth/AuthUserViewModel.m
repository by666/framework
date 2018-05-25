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
        [_delegate submitUserInfo:YES msg:MSG_SUCCESS];
    }
}

@end
