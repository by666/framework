//
//  AddMemberViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AddMemberViewModel.h"

@implementation AddMemberViewModel

-(instancetype)init{
    if(self == [super init]){
        _model = [[MemberModel alloc]init];
    }
    return self;
}

-(void)addMemberModel{
    if(_delegate){
        [_delegate onAddMemberModel:YES model:_model];
    }
}


@end
