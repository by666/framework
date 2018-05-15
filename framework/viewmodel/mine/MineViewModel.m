//
//  MineViewModel.m
//  framework
//
//  Created by 黄成实 on 2018/5/15.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MineViewModel.h"

@implementation MineViewModel


-(instancetype)init{
    if(self == [super init]){
        _titleArray = @[@"家庭成员",@"访客登记",@"访客通行记录",@"我的车辆",@"车辆通行记录",@"消息通知设置",@"账号管理",@"设置"];
    }
    return self;
}

-(void)goProfilePage{
    if(_delegate){[_delegate onGoProfilePage];}
}

-(void)goMemberPage{
    if(_delegate){[_delegate onGoMemberPage];}
}

-(void)goVictorPage{
    if(_delegate){[_delegate onGoVictorPage];}
}

-(void)goVictorHistoryPage{
    if(_delegate){[_delegate onGoVictorHistoryPage];}
}

-(void)goCarPage{
    if(_delegate){[_delegate onGoCarPage];}
}

-(void)goCarHistoryPage{
    if(_delegate){[_delegate onGoCarHistoryPage];}
}

-(void)goMessageSettingPage{
    if(_delegate){[_delegate onGoMessageSettingPage];}
}

-(void)goAccountManagePage{
    if(_delegate){[_delegate onGoAccountManagePage];}
}

-(void)goSettingPage{
    if(_delegate){[_delegate onGoSettingPage];}
}


@end
